//
//  SQHelp.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQHelp.h"
#import "SQDeviceMsg.h"

@implementation SQHelp

+ (BOOL)isSpecialShapedScreen {
    NSString *deviceModel = [SQDeviceMsg getDeviceModel];
    if ([deviceModel isEqualToString:@"iPhone X"] || [deviceModel isEqualToString:@"iPhone XS"] || [deviceModel isEqualToString:@"iPhone XS Max"] || [deviceModel isEqualToString:@"iPhone XR"]) {
        return YES;
    }
    if ([deviceModel isEqualToString:@"iPhone Simulator"]) {
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896))) {
            return YES;
        }
    }
    return NO;
}

@end
