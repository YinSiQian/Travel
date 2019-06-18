//
//  SQEmptyView.m
//  Travel
//
//  Created by yinsiqian on 2019/6/18.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQEmptyView.h"

@interface SQEmptyView ()

@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation SQEmptyView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreen_width, 200);
        self.msgLabel = [UILabel new];
        self.msgLabel.textColor = kDarkGrayColor;
        self.msgLabel.textAlignment = NSTextAlignmentCenter;
        self.msgLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.msgLabel];
        
        [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    self.msgLabel.text = message;
}

@end
