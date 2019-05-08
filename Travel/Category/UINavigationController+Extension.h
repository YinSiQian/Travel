//
//  UINavigationController+Extension.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Extension)

- (void)setNeedsNavigationBackground:(CGFloat)alpha;

- (void)setNavigationBarSeparatorLineHidden:(BOOL)isHidden;

@end

NS_ASSUME_NONNULL_END
