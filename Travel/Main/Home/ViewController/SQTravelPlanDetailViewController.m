//
//  SQTravelPlanDetailViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQTravelPlanDetailViewController.h"
#import "SQHomeListCell.h"
#import "SQHomePlanCommentModel.h"
#import "SQHomePlanCommentCell.h"
#import "SQInputView.h"
#import "SQLoginViewController.h"
#import "SQReportIllegalView.h"

@interface SQTravelPlanDetailViewController ()<SQHomePlanCommentCellDelegate>

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray<SQHomePlanCommentModel *> *comments;

@property (nonatomic, strong) NSNumber *isLove;

@end

@implementation SQTravelPlanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.page = 1;
    self.refreshType = SQRefreshTypeAll;
    [self setupSubviews];
    [self loadPlanInfo];
    [self checkPlanIsLove];
}

- (void)setupSubviews {
    
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.frame = CGRectMake(0, self.safeTop, kScreen_width, kScreen_height - self.safeBottom - 50 - self.safeTop);
    self.sq_tableView.estimatedRowHeight = 80;
    self.sq_tableView.rowHeight = UITableViewAutomaticDimension;
    
    SQHomeListCell *headerView = [[SQHomeListCell alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, self.detailHeight)];
    headerView.frame = CGRectMake(0, 0, kScreen_width, self.detailHeight);
    headerView.backgroundColor = kDarkBackColor;
    headerView.model = self.model;
    self.sq_tableView.tableHeaderView = headerView;
    
    UIBarButtonItem *loveItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_plan_love_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(userLove)];
    UIBarButtonItem *reportItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_report"] style:UIBarButtonItemStylePlain target:self action:@selector(reportIllegalContent)];
    
    self.navigationItem.rightBarButtonItems = @[loveItem, reportItem];
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreen_height - self.safeBottom - 50, kScreen_width, 50)];
    [commentBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    commentBtn.backgroundColor = kThemeColor;
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentBtn];
}

#pragma mark -- load Data

- (void)loadPlanInfo {
    if (self.model) {
        [self.sq_tableView.mj_header beginRefreshing];
        return;
    }
    NSDictionary *params = @{@"pid": @(self.pid)};
    [SQNetworkManager GET:sq_url_combine(detail) parameters:params success:^(NSDictionary * _Nullable data) {
        NSDictionary *dict = data[@"data"];
        self.model = [SQHomePlanModel mj_objectWithKeyValues:dict];
        [self calculateInfoHeight];
    } fail:^(NSError * _Nullable error) {
        
    }];
    
}


- (void)loadData {
    
    NSDictionary *params = @{@"pid": @(self.model.pid),
                             @"page": @(self.page),
                             @"rows": @10};
    [SQNetworkManager GET:sq_url_combine(plan_comment_list) parameters:params success:^(NSDictionary * _Nonnull data) {
        if (self.page == 1) {
            [self.comments  removeAllObjects];
            [self.sq_tableView.mj_header endRefreshing];
        } else {
            [self.sq_tableView.mj_footer endRefreshing];
        }
        self.page ++;
        NSInteger isMore = [data[@"more"] integerValue];
        NSArray *dataArr = data[@"list"];
        NSArray<SQHomePlanCommentModel *> *models = [SQHomePlanCommentModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.comments addObjectsFromArray:models];
        if (isMore == 0) {
            [self.sq_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.sq_tableView reloadData];
        NSLog(@"detail ----> %@", data);
    } fail:^(NSError * _Nonnull error) {
        [self.sq_tableView.mj_header endRefreshing];
        [self.sq_tableView.mj_footer endRefreshing];
    }];
}

- (void)checkPlanIsLove {
    if (![SQUserModel shared].isLogin) {
        return;
    }
    if (!self.model) {
        return;
    }
    [SQNetworkManager POST:sq_url_combine(plan_isLove) parameters:@{@"pid": @(self.model.pid)} success:^(NSDictionary * _Nullable data) {
        NSDictionary *result = data[@"data"];
        self.isLove = result[@"isLove"];
        [self refreshPlanFavoriteStatus];
    } fail:^(NSError * _Nullable error) {
        
    }];
}

- (void)favoritePlan {
    if (![SQUserModel shared].isLogin) {
        SQLoginViewController *login = [[SQLoginViewController alloc]initWithFinishAction:^{
            [self favoritePlan];
        }];
        SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
        return;
    }
    NSDictionary *param = @{@"pid": @(self.model.pid), @"isLove": self.isLove};
    [SQNetworkManager POST:sq_url_combine(plan_love) parameters:param success:^(NSDictionary * _Nullable data) {
        
        self.isLove = data[@"isLove"];
        [self refreshPlanFavoriteStatus];
    } fail:^(NSError * _Nullable error) {
        
    }];
}

- (void)reportWithReportedUid:(NSInteger)reportedUid content:(NSString *)content {
    [self showHUDWithMessage:@"正在提交举报内容..."];
    NSDictionary *params = @{@"reported_uid": @(reportedUid),
                             @"pid": @(self.model.pid),
                             @"content": content};
    [SQNetworkManager POST:sq_url_combine(plan_report) parameters:params success:^(NSDictionary * _Nullable data) {
        [self hideHUD];
        [self showSuccessWithMessage:@"举报内容提交成功!"];
    } fail:^(NSError * _Nullable error) {
        [self hideHUD];
    }];

}

- (void)commitComment:(NSString *)comment {
    [self showHUDWithMessage:@"正在提交评论..."];
    NSDictionary *params = @{@"pid": @(self.model.pid), @"content": comment};
    [SQNetworkManager POST:sq_url_combine(plan_comment) parameters:params success:^(NSDictionary * _Nullable data) {
        [self hideHUD];
        [self.sq_tableView.mj_header beginRefreshing];
    } fail:^(NSError * _Nullable error) {
        [self hideHUD];
    }];
}

- (void)loadMoreData {
    [self loadData];
}

- (void)refreshData {
    self.page = 1;
    [self loadData];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreen_width, 40)];
    label.text = @"所有评论";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kBlackColor;
    [v addSubview:label];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomePlanCommentCell *cell = [SQHomePlanCommentCell cellWithTableView:tableView];
    cell.model = self.comments[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomePlanCommentModel *model = self.comments[indexPath.row];
    [self commentWithName:[NSString stringWithFormat:@"回复%@:", model.name]];
}

#pragma mark -- SQHomePlanCommentCellDelegate

- (void)reportIllegalUserOrContentWithIndex:(NSInteger)index {
    if (index >= self.comments.count) {
        return;
    }
    [self reportIllegalContentWithReportedUid:self.comments[index].uid];
}

#pragma mark -- private method

- (void)calculateInfoHeight {
    CGSize size = [self.model.content textSize:CGSizeMake(kScreen_width - 80, MAXFLOAT) font:[UIFont systemFontOfSize:15]];
    CGFloat currentHeight = size.height + 180;
    SQHomeListCell *header = (SQHomeListCell *)self.sq_tableView.tableHeaderView;
    header.frame = CGRectMake(0, 0, kScreen_width, currentHeight);
    header.model = self.model;
    [self.sq_tableView.mj_header beginRefreshing];
    [self checkPlanIsLove];
}

- (void)refreshPlanFavoriteStatus {
    if (self.isLove.boolValue) {
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"icon_plan_love_selected"];
    } else {
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"icon_plan_love_normal"];
    }
}

#pragma mark -- events

- (void)reportIllegalContent {
    [self reportIllegalContentWithReportedUid:0];
}

- (void)reportIllegalContentWithReportedUid:(NSInteger)reportedUid {
    if (![SQUserModel shared].isLogin) {
        
        SQLoginViewController *login = [[SQLoginViewController alloc]initWithFinishAction:^{
            [self reportIllegalContentWithReportedUid:reportedUid];
        }];
        SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    SQReportIllegalView *report = [[SQReportIllegalView alloc]initComplectionHandler:^(NSString * _Nonnull content) {
        [self reportWithReportedUid:reportedUid content:content];
    }];
    [report show];
    
}

- (void)userLove {
    [self favoritePlan];
}

- (void)comment {
    [self commentWithName:@"输入你的想法"];
}

- (void)commentWithName:(NSString *)name {
    if (![SQUserModel shared].isLogin) {
        SQLoginViewController *login = [[SQLoginViewController alloc]initWithFinishAction:^{
            [self commentWithName:name];
        }];
        SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    SQInputView *input = [[SQInputView alloc]initComplectionHandler:^(NSString * _Nonnull content) {
        if (!content.isEmpty) {
            content = [NSString stringWithFormat:@"%@%@", name, content];
            [self commitComment:content];
        }
    }];
    input.placeholder = name;
    [input show];
}

#pragma mark -- getter

- (NSMutableArray<SQHomePlanCommentModel *> *)comments {
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}


@end
