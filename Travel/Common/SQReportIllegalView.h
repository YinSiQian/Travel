//
//  SQReportIllegalView.h
//  Travel
//
//  Created by yinsiqian on 2019/6/13.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQReportIllegalView : UIView

- (instancetype)initComplectionHandler:(void(^)(NSString *content))complection;

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
