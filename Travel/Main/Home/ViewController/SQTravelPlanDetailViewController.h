//
//  SQTravelPlanDetailViewController.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQBaseViewController.h"
#import "SQHomePlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTravelPlanDetailViewController : SQBaseViewController

@property (nonatomic, strong) SQHomePlanModel *model;

@property (nonatomic, assign) NSInteger detailHeight;

@end

NS_ASSUME_NONNULL_END
