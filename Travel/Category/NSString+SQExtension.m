//
//  NSString+SQExtension.m
//  Travel
//
//  Created by yinsiqian on 2019/5/27.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "NSString+SQExtension.h"

@implementation NSString (SQExtension)

- (BOOL)isEmpty {
    if ([self isKindOfClass:[NSNull class]] || [self isEqualToString:@"(null)"]) {
        return YES;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
    if ([trimedString length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
