//
//  SQNetworkManager.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQNetworkManager.h"
#import "AFNetworking.h"
#import "SQHTTPSessionManager.h"

@implementation SQNetworkManager

+ (NSURLSessionDataTask *)GET:(NSString *)urlString parameters:(NSDictionary *)parameters success:(complectionHandler)success fail:(failure)fail {
    NSLog(@"url ----> %@", urlString);
    if ([SQUserModel shared].isLogin) {
        [[SQHTTPSessionManager shared].requestSerializer setValue:[SQUserModel shared].accessToken forHTTPHeaderField:@"accessToken"];
    }
    return [[SQHTTPSessionManager shared] GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)urlString parameters:(NSDictionary *)parameters success:(complectionHandler)success fail:(failure)fail {
    NSLog(@"url ----> %@", urlString);

    if ([SQUserModel shared].isLogin) {
        [[SQHTTPSessionManager shared].requestSerializer setValue:[SQUserModel shared].accessToken forHTTPHeaderField:@"accessToken"];
    }
    
    return [[SQHTTPSessionManager shared] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject[@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}



@end
