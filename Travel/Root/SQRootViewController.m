//
//  SQRootViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQRootViewController.h"
#import "SQNavigationController.h"
#import "SQMineViewController.h"
#import "SQHomeViewController.h"
#import "SQTravelPlanPublishViewController.h"

@interface SQRootViewController ()<UITabBarControllerDelegate>

@end

@implementation SQRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setupViewControlllers];
//    05b14b
}

- (void)setupViewControlllers {
    
    SQHomeViewController *home = [SQHomeViewController new];
    SQNavigationController *homeNav = [[SQNavigationController alloc]initWithRootViewController:home];
    home.title = @"首页";
    
    UIViewController *placeView = [UIViewController new];
    placeView.title = @"占位";
    
    SQMineViewController *mine = [SQMineViewController new];
    SQNavigationController *mineNav = [[SQNavigationController alloc]initWithRootViewController:mine];
    mine.title = @"我的";
    
    self.viewControllers = @[homeNav, placeView, mineNav];
    [self customizeTabbar];
}

- (void)customizeTabbar {
    NSArray<NSString *> *imageNames = @[@"icon_home", @"icon_publish", @"icon_mine"];
    NSArray<NSString *> *titles = @[@"首页", @"", @"我的"];
    NSInteger index = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitle:titles[index]];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: kThemeColor} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        NSString *selectedImage = [NSString stringWithFormat:@"%@_selected", imageNames[index]];
        NSString *normalImage = [NSString stringWithFormat:@"%@_normal", imageNames[index]];
        if (index == 1) {

            
        } else {
            [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
            [item setImage:[[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item setSelectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        index++;
    }
    
    UIButton *publishBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreen_width - 35) / 2, (self.tabBar.height - 35) / 2, 35, 35)];
    [publishBtn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishTravelPlan) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:publishBtn];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController.title isEqualToString:@"占位"]) {
        return NO;
    }
    return YES;
}

#pragma mark -- events

- (void)publishTravelPlan {
    SQTravelPlanPublishViewController *publish = [SQTravelPlanPublishViewController new];
    SQNavigationController *nav = [[SQNavigationController alloc]initWithRootViewController:publish];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
