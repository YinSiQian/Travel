//
//  SQNetworkManager.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^complectionHandler)( NSDictionary * _Nullable data);
typedef void(^failure)(NSError * _Nullable error);

@interface SQNetworkManager : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)urlString parameters:(nullable NSDictionary *)parameters success:(complectionHandler)success fail:(failure)fail;

+ (NSURLSessionDataTask *)POST:(NSString *)urlString parameters:(nullable NSDictionary *)parameters success:(complectionHandler)success fail:(failure)fail;

@end

NS_ASSUME_NONNULL_END
