//
//  UIViewController+Extension.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (Extension)

@dynamic safeTop;
@dynamic safeBottom;

- (CGFloat)safeTop {
    return self.navigationController.navigationBar.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (CGFloat)safeBottom {
    return [SQHelp isSpecialShapedScreen] ? 34 : 0;
}

- (void)setNavBarAlpha:(NSString *)navBarAlpha {
    objc_setAssociatedObject(self, @selector(navBarAlpha), navBarAlpha, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBackground:navBarAlpha.floatValue];
}

- (NSString *)navBarAlpha {
    id resut = objc_getAssociatedObject(self, _cmd);
    if (!resut) {
        return @"1.0";
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavSeparatorLineHidden:(BOOL)isHidden {
    [self.navigationController setNavigationBarSeparatorLineHidden:isHidden];
}

- (void)setTintColor:(UIColor *)color {
    [self.navigationController.navigationBar setTintColor:color];
}

- (void)setupNavBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBarTintColor:color];
}


- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)showHUDWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = message;
    [hud showAnimated:YES];
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = message;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
}

- (void)showSuccessWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Optional label text.
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void)showFailureWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Optional label text.
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:2.f];
}

- (MBProgressHUD *)showHUDWithMessage:(NSString *)message progress:(CGFloat)progress {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = message;
    return hud;
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
