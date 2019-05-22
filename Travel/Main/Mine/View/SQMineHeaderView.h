//
//  SQMineHeaderView.h
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQMineHeaderViewDelegate <NSObject>

- (void)userLogin;

@end

@interface SQMineHeaderView : UIView

@property (nonatomic, weak) id<SQMineHeaderViewDelegate> delegate;

- (void)updateUserInfo;

@end

NS_ASSUME_NONNULL_END
