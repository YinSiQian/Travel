//
//  UIView+Extension.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

///hud
- (void)showHUD;

- (void)showMessage:(NSString *)message;

- (void)showHUDWithMessage:(NSString *)message;

- (void)showSuccessWithMessage:(NSString *)message;

- (void)showFailureWithMessage:(NSString *)message;

- (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
