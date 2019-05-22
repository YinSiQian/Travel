//
//  SQHomePlanCommentCell.m
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQHomePlanCommentCell.h"

@interface SQHomePlanCommentCell ()

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UILabel *content;

@end

@implementation SQHomePlanCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubviews {
    self.avatar = [UIImageView new];
    self.avatar.layer.cornerRadius = 5;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.avatar];
    
    self.userName = [UILabel new];
    self.userName.textColor = kDarkGrayColor;
    self.userName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.userName];
    
    self.content = [UILabel new];
    self.content.textColor = kBlackColor;
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.numberOfLines = 0;
    [self.contentView addSubview:self.content];
}

- (void)setupConstraints {
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@(30));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.avatar.mas_right).offset(10);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(8);
        make.leading.equalTo(self.userName);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

- (void)setModel:(SQHomePlanCommentModel *)model {
    _model = model;
    self.userName.text = model.name;
    self.content.text = model.content;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
