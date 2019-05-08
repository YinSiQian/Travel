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
}

- (void)setuNavItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
}


- (void)login {
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:[SQLoginViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
