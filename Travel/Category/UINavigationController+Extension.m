//
//  UINavigationController+Extension.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [self.navigationBar subviews].firstObject;// _UIBarBackground
    UIImageView *backgroundImageView = [barBackgroundView subviews].firstObject;// UIImageView
    if (@available(iOS 10, *)) {
        if (self.navigationBar.isTranslucent) {
            if (backgroundImageView != nil && backgroundImageView.image != nil) {
                barBackgroundView.alpha = alpha;
            } else  {
                UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.alpha = alpha;
                }
            }
            
        } else {
            barBackgroundView.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
    
    // 对导航栏下面那条线做处理
    self.navigationBar.clipsToBounds = alpha == 0.0;
}

- (void)setNavigationBarSeparatorLineHidden:(BOOL)isHidden {
    if (@available(iOS 10, *)) {
        UIView *backgroundView = [self.navigationBar subviews].firstObject;
        UIView *separatorLine = backgroundView.subviews.firstObject;
        separatorLine.hidden = isHidden;
    }
}


@end
