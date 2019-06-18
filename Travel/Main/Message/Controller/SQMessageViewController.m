//
//  SQMessageViewController.m
//  Travel
//
//  Created by yinsiqian on 2019/6/18.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMessageViewController.h"
#import "SQMessageModel.h"
#import "SQLoginViewController.h"
#import "SQMessageCell.h"
#import "SQTravelPlanDetailViewController.h"

@interface SQMessageViewController ()

@property (nonatomic, strong) NSMutableArray<SQMessageModel *> *data;

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation SQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearData) name:kUserLogout object:nil];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshViewForUserStatusChanged];
}

- (void)setupSubviews {
    self.refreshType = SQRefreshTypePullDown;
    [self.view addSubview:self.sq_tableView];
    
}

- (void)refreshViewForUserStatusChanged {
    
    if (![SQUserModel shared].isLogin) {
        self.refreshType = SQRefreshTypeNone;
        [self.sq_tableView addSubview:self.loginBtn];
    } else {
        if (!self.sq_tableView.mj_header) {
            self.refreshType = SQRefreshTypePullDown;
        }
        [self.sq_tableView.mj_header beginRefreshing];
        [self.loginBtn removeFromSuperview];
    }
    
}

#pragma mark -- load Data

- (void)loadData {
    NSDictionary *params;
    if (self.data.count == 0) {
        params = @{@"timestamp": @0};
    } else {
        params = @{@"timestamp": @(self.data.firstObject.timestamp)};
    }
    [SQNetworkManager GET:sq_url_combine(reply_msg) parameters:params success:^(NSDictionary * _Nullable data) {
        [self.sq_tableView.mj_header endRefreshing];
        NSArray *msg = data[@"data"];
        NSMutableArray<SQMessageModel *> *list = [SQMessageModel mj_objectArrayWithKeyValuesArray:msg];
        for (NSInteger index = msg.count - 1; index >= 0; index--) {
            [self.data insertObject:list[index] atIndex:0];
        }
        [self handleEmptyData];
        [self.sq_tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        [self.sq_tableView.mj_header endRefreshing];
    }];
}

- (void)refreshData {
    [self loadData];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQMessageCell *cell = [SQMessageCell cellWithTableView:tableView];
    cell.model = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTravelPlanDetailViewController *planDetail = [SQTravelPlanDetailViewController new];
    planDetail.pid = self.data[indexPath.row].pid;
    [self.navigationController pushViewController:planDetail animated:YES];
}

#pragma mark -- private method

- (void)handleEmptyData {
    if (self.data.count == 0) {
        self.emptyView.message = @"暂无消息";
        [self.sq_tableView addSubview:self.emptyView];
    } else {
        [self.emptyView removeFromSuperview];
    }
}

#pragma mark -- events

- (void)clearData {
    [self.data removeAllObjects];
    [self.sq_tableView reloadData];
    [self.emptyView removeFromSuperview];
}

- (void)userLogin {
    SQLoginViewController *login = [[SQLoginViewController alloc]initWithFinishAction:^{
        [self refreshViewForUserStatusChanged];
        [self.sq_tableView.mj_header beginRefreshing];
    }];
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:login];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark -- getter

- (NSMutableArray<SQMessageModel *> *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreen_width - 200) / 2, (kScreen_height - 44) / 2, 200, 44)];
        [_loginBtn setTitle:@"登录账号,查看更多精彩" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginBtn.backgroundColor = kThemeColor;
        _loginBtn.layer.cornerRadius = 22;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
