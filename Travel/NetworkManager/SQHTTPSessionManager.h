//
//  SQHTTPSessionManager.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
