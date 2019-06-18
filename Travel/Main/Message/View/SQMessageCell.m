//
//  SQMessageCell.m
//  Travel
//
//  Created by yinsiqian on 2019/6/18.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMessageCell.h"
#import "SQMessageModel.h"

@interface SQMessageCell ()

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *userName;

@end

@implementation SQMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubviews {
    
    
    self.avatar = [UIImageView new];
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatar];
    
    self.userName = [UILabel new];
    self.userName.textColor = [UIColor blackColor];
    self.userName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.userName];
    
    self.content = [UILabel new];
    self.content.textColor = kBlackColor;
    self.content.font = [UIFont systemFontOfSize:13];
    self.content.numberOfLines = 0;
    [self.contentView addSubview:self.content];
    
    self.time = [UILabel new];
    self.time.textColor = [UIColor lightGrayColor];
    self.time.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.time];
    
}

- (void)setupConstraints {
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@(40));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.top.equalTo(self.userName.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.self.userName);
    }];
    
    
}

- (void)setModel:(SQMessageModel *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"icon_mine_avatar"]];
    self.content.text = model.content;
    self.userName.text = model.userName;
    self.time.text = [SQHelp formatterTimestampToMonthDay:model.timestamp / 1000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
