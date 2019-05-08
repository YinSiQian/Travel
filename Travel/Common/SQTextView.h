//
//  SQTextView.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTextView : UIView

@property (nonatomic, assign) NSInteger maxNum;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy, readonly) NSString *content;

@end

NS_ASSUME_NONNULL_END
