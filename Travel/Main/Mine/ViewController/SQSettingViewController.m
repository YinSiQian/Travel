//
//  SQSettingViewController.m
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SDImageCache.h"

@interface SQSettingViewController ()

@end

@implementation SQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupSubviews];
}


- (void)setupSubviews {
    [self.view addSubview:self.sq_tableView];
    self.sq_tableView.rowHeight = 50;
    
}

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
    NSArray *titles = @[@"清理缓存", @"退出登录"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showHUDWithMessage:@"正在清理缓存..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        });
    }
    if (indexPath.row == 1) {
        if (![SQUserModel shared].isLogin) {
            [self showMessage:@"你还未登录哦..."];
            return;
        }
        [[SQUserModel shared] clear];
        [self.navigationController popViewControllerAnimated:YES];

    }
}



@end
