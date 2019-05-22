//
//  SQHomeViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQHomeViewController.h"
#import "SQTravelPlanDetailViewController.h"
#import "SQHomeListCell.h"
#import "SQHomePlanModel.h"


@interface SQHomeViewController ()

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray<SQHomePlanModel *> *models;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark -- Load Data

- (void)loadData {
    
    NSDictionary *params = @{@"page": @(self.page), @"rows": @(10)};
    [SQNetworkManager GET:sq_url_combine(plan_list) parameters:params success:^(NSDictionary * _Nonnull data) {
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
    } fail:^(NSError * _Nonnull error) {
        [self.sq_tableView.mj_header endRefreshing];
        [self.sq_tableView.mj_footer endRefreshing];
    }];
    
}

- (void)refreshData {
    self.page = 1;
    [self loadData];
}

- (void)loadMoreData {
    [self loadData];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomeListCell *cell = [SQHomeListCell cellWithTableView:tableView];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomeListCell *cell = (SQHomeListCell *)[tableView cellForRowAtIndexPath:indexPath];
    SQTravelPlanDetailViewController *plan = [SQTravelPlanDetailViewController new];
    plan.model = self.models[indexPath.row];
    plan.detailHeight = cell.height;
    [self.navigationController pushViewController:plan animated:YES];
}

#pragma mark -- getter

- (NSMutableArray<SQHomePlanModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
