//
//  SQMineViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMineViewController.h"
#import "SQLoginViewController.h"
#import "SQMineHeaderView.h"
#import "SQSettingViewController.h"
#import "SQUserFavoriteViewController.h"
#import "SQUserPublishedViewController.h"


@interface SQMineViewController ()<SQMineHeaderViewDelegate>

@end

@implementation SQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [((SQMineHeaderView *)self.sq_tableView.tableHeaderView) updateUserInfo];
}

- (void)setupSubviews {
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.rowHeight = 50;
    
    SQMineHeaderView *headerView = [[SQMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 160)];
    self.sq_tableView.tableHeaderView = headerView;
    headerView.delegate = self;
    [headerView updateUserInfo];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
}


#pragma mark -- UITableViewDataSource && UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *titles = @[@"我的帖子", @"我的收藏"];
    NSArray *images = @[@"icon_mine_publish", @"icon_mine_collection"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![SQUserModel shared].isLogin) {
        [self userLogin];
        return;
    }
    if (indexPath.row == 0) {
        SQUserPublishedViewController *pb = [SQUserPublishedViewController new];
        [self.navigationController pushViewController:pb animated:YES];
    } else {
        SQUserFavoriteViewController *ft = [SQUserFavoriteViewController new];
        [self.navigationController pushViewController:ft animated:YES];
    }
}

#pragma mark -- SQMineHeaderViewDelegate

- (void)userLogin {
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:[SQLoginViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -- events

- (void)setting {
    SQSettingViewController *set = [SQSettingViewController new];
    [self.navigationController pushViewController:set animated:YES];
}

@end
