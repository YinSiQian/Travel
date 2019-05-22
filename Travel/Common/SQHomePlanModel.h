//
//  SQHomePlanModel.h
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHomePlanModel : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, strong) NSNumber *isForbid;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) long createTime;

@end

NS_ASSUME_NONNULL_END
