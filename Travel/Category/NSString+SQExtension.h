//
//  NSString+SQExtension.h
//  Travel
//
//  Created by yinsiqian on 2019/5/27.
//  Copyright © 2019 ysq. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (SQExtension)

- (BOOL)isEmpty;

- (CGSize)textSize:(CGSize)size font:(UIFont *)font;

- (CGSize)textSize:(CGSize)size font:(UIFont *)font style:(NSParagraphStyle *)style;


@end

NS_ASSUME_NONNULL_END
