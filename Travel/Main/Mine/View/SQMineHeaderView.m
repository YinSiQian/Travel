//
//  SQMineHeaderView.m
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMineHeaderView.h"

@interface SQMineHeaderView ()

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UIImageView *avatar;


@end

@implementation SQMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.avatar = [UIImageView new];
    self.avatar.layer.cornerRadius = 40;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.image = [UIImage imageNamed:@"icon_mine_avatar"];
    [self addSubview:self.avatar];
    
    self.name = [UILabel new];
    self.name.font = [UIFont systemFontOfSize:20];
    self.name.textColor = [UIColor blackColor];
    self.name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.name];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.height.width.equalTo(@(80));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.avatar.mas_bottom).offset(15);

    }];
    
}

- (void)updateUserInfo {
    if ([SQUserModel shared].isLogin) {
        self.name.text = [SQUserModel shared].name;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:[SQUserModel shared].icon] placeholderImage:[UIImage imageNamed:@"icon_mine_avatar"]];
    } else {
        self.name.text = @"立即登录";
        self.avatar.image = [UIImage imageNamed:@"icon_mine_avatar"];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(userLogin)]) {
        [self.delegate userLogin];
    }
    

}

@end
