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

- (CGSize)textSize:(CGSize)size font:(UIFont *)font {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    return [self textSize:size font:font style:style];
}

- (CGSize)textSize:(CGSize)size font:(UIFont *)font style:(NSParagraphStyle *)style {
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: style};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

@end
