//
//  UIViewController+Extension.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)

@property (nonatomic, assign) CGFloat safeTop;

@property (nonatomic, assign) CGFloat safeBottom;

///navigationBar
@property (nonatomic, copy) NSString *navBarAlpha;

- (void)setNavSeparatorLineHidden:(BOOL)isHidden;

- (void)setupNavBarColor:(UIColor *)color;

- (void)setTintColor:(UIColor *)color;


///hud
- (void)showHUD;

- (void)showMessage:(NSString *)message;

- (void)showHUDWithMessage:(NSString *)message;

- (void)showSuccessWithMessage:(NSString *)message;

- (void)showFailureWithMessage:(NSString *)message;

- (void)hideHUD;

- (MBProgressHUD *)showHUDWithMessage:(NSString *)message progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
