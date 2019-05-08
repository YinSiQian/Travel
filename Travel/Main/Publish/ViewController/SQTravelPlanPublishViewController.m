//
//  SQTravelPlanPublishViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQTravelPlanPublishViewController.h"

@interface SQTravelPlanPublishViewController ()

@end

@implementation SQTravelPlanPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBack];
    [self setupSubviews];
    [self setupItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarAlpha = @"0.0";
}

- (void)setupBack {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, kScreen_width, kScreen_height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.8].CGColor, (__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.5].CGColor, (__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.3].CGColor];
    gl.locations = @[@(0.0), @(0.3),@(1.0)];
    [self.view.layer addSublayer:gl];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    
}

- (void)setupItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishPlan)];
}

- (void)setupSubviews {
    
    
    
    
}


#pragma mark -- events

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishPlan {
    
}

@end
