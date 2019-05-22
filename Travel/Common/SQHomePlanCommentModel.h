//
//  SQHomePlanCommentModel.h
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHomePlanCommentModel : NSObject

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) long date;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger cid;

@end

NS_ASSUME_NONNULL_END
