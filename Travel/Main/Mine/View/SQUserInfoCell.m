//
//  SQUserInfoCell.m
//  Travel
//
//  Created by yinsiqian on 2019/6/26.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQUserInfoCell.h"

@interface SQUserInfoCell ()

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UIImageView *icon;

@end

@implementation SQUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubviews {
    
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.title = [UILabel new];
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.textColor = kBlackColor;
    [self.contentView addSubview:self.title];
    
    self.name = [UILabel new];
    self.name.font = [UIFont systemFontOfSize:16];
    self.name.textColor = kBlackColor;
    [self.contentView addSubview:self.name];
    
    self.icon = [UIImageView new];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = YES;
    self.icon.backgroundColor = kSeparatorColor;
    [self.contentView addSubview:self.icon];
}

- (void)setupConstraints {
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(120);
        make.right.equalTo(self.contentView).offset(-120);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.width.equalTo(@40);
        make.left.equalTo(self.contentView).offset(120);
    }];
    
}

- (void)setDataWithTitle:(NSString *)title content:(NSString *)content isAvatar:(BOOL)isAvatar {
    self.icon.hidden = !isAvatar;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[SQUserModel shared].icon]];
    self.title.text = title;
    self.name.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
