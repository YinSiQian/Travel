//
//  SQUserModel.h
//  Travel
//
//  Created by ABJ on 2019/5/9.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQUserModel : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *phoneNum;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign, readonly) BOOL isLogin;


+ (instancetype)shared;

- (void)initWithDict:(NSDictionary *)dict;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
