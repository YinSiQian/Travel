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


@interface SQHomeViewController ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupSubviews];
    [self loadData];
}

- (void)setupSubviews {
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.estimatedRowHeight = 100;
    self.sq_tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark -- Load Data

- (void)loadData {
    
    NSDictionary *params = @{@"page": @(self.page), @"rows": @(10)};
    [SQNetworkManager GET:sq_url_combine(list) parameters:params success:^(NSDictionary * _Nonnull data) {
        NSLog(@"data--->%@", data);
    } fail:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomeListCell *cell = [SQHomeListCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTravelPlanDetailViewController *plan = [SQTravelPlanDetailViewController new];
    [self.navigationController pushViewController:plan animated:YES];
}

@end
