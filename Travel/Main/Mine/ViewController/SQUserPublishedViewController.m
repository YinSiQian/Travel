//
//  SQUserPublishedViewController.m
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQUserPublishedViewController.h"
#import "SQTravelPlanDetailViewController.h"
#import "SQMinePublishPlanCell.h"
#import "SQHomePlanModel.h"

@interface SQUserPublishedViewController ()

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray<SQHomePlanModel *> *models;

@end

@implementation SQUserPublishedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发布的计划";
    self.refreshType = SQRefreshTypeAll;
    self.page = 1;
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.sq_tableView.mj_header beginRefreshing];
}

- (void)setupSubviews {
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.estimatedRowHeight = 100;
    self.sq_tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark -- load Data

- (void)loadData {
    
    [SQNetworkManager GET:sq_url_combine(plan_pubList) parameters:@{@"page": @(self.page), @"rows": @(10)} success:^(NSDictionary * _Nullable data) {
        
        NSLog(@"data ---> %@", data);
        if (self.page == 1) {
            [self.sq_tableView.mj_header endRefreshing];
            [self.models removeAllObjects];
        } else {
            [self.sq_tableView.mj_footer endRefreshing];
        }
        self.page ++;
        NSInteger isMore = [data[@"more"] integerValue];
        NSArray *list = data[@"list"];
        NSArray<SQHomePlanModel *> *plans = [SQHomePlanModel mj_objectArrayWithKeyValuesArray:list];
        [self.models addObjectsFromArray:plans];
        if (isMore == 0) {
            [self.sq_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.sq_tableView reloadData];
        [self handleEmptyData];
        
    } fail:^(NSError * _Nullable error) {
        [self.sq_tableView.mj_footer endRefreshing];
        [self.sq_tableView.mj_header endRefreshing];
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
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQMinePublishPlanCell *cell = [SQMinePublishPlanCell cellWithTableView:tableView];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQMinePublishPlanCell *cell = (SQMinePublishPlanCell *)[tableView cellForRowAtIndexPath:indexPath];
    SQTravelPlanDetailViewController *plan = [SQTravelPlanDetailViewController new];
    plan.model = self.models[indexPath.row];
    plan.detailHeight = cell.height;
    [self.navigationController pushViewController:plan animated:YES];
}

#pragma mark -- private method

- (void)handleEmptyData {
    if (self.models.count > 0) {
        [self.emptyView removeFromSuperview];
    } else {
        self.emptyView.message = @"您还没有发布任何帖子呢!";
        [self.sq_tableView addSubview:self.emptyView];
    }
}

#pragma mark -- getter

- (NSMutableArray<SQHomePlanModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}


@end
