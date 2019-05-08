//
//  SQDeviceMsg.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQDeviceMsg : NSObject

+ (NSString *)getDeviceName;
+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceType;
+ (NSString *)getSystemVersion;
+ (NSString *)getAppVersion;
+ (NSString *)getAPP_VERSION_INT;
//+ (NSString *)getNetwork_type;

@end

NS_ASSUME_NONNULL_END
