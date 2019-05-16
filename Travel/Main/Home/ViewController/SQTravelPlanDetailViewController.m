//
//  SQTravelPlanDetailViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQTravelPlanDetailViewController.h"

@interface SQTravelPlanDetailViewController ()

@end

@implementation SQTravelPlanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
}

- (void)setupSubviews {
    
    [self.view addSubview:self.sq_tableView];
}




@end
