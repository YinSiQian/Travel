//
//  SQHelp.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHelp : NSObject

+ (BOOL)isSpecialShapedScreen;

+ (NSString *)formatterTimestamp:(long)timestamp;

+ (NSString *)formatterTimestampToMonthDay:(long)timestamp;

@end

NS_ASSUME_NONNULL_END
