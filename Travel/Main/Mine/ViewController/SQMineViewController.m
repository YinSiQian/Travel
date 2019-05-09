//
//  SQMineViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMineViewController.h"
#import "SQLoginViewController.h"

@interface SQMineViewController ()

@end

@implementation SQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuNavItem];
    [self setupSubviews];
}

- (void)setuNavItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
}

- (void)setupSubviews {
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.rowHeight = 50;
}


- (void)login {
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:[SQLoginViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate

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


@end
