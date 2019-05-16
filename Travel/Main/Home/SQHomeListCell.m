//
//  SQHomeListCell.m
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQHomeListCell.h"

@interface SQHomeListCell ()

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UILabel *commentNum;

@property (nonatomic, strong) UILabel *date;

@property (nonatomic, strong) UILabel *pubDate;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *content;

@end

@implementation SQHomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubviews {
    
    self.avatar = [UIImageView new];
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.avatar];
    
    self.userName = [UILabel new];
    self.userName.textColor = [UIColor blackColor];
    self.userName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.userName];
    
    self.content = [UILabel new];
    self.content.textColor = [UIColor blackColor];
    self.content.font = [UIFont systemFontOfSize:15];
    self.content.numberOfLines = 0;
    [self.contentView addSubview:self.content];
    
    self.date = [UILabel new];
    self.date.textColor = kThemeColor;
    self.date.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.date];
    
    self.pubDate = [UILabel new];
    self.pubDate.textColor = [UIColor lightGrayColor];
    self.pubDate.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.pubDate];
    
    self.title = [UILabel new];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.title];
    
    self.commentNum = [UILabel new];
    self.commentNum.textColor = [UIColor lightGrayColor];
    self.commentNum.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.commentNum];
    
    self.userName.text = @"我一个人的宝宝";
    self.title.text = @"发啦发啦发啦见覅我减肥啦";
    self.date.text = @"出行时间: 2019-03-08 - 2019-05-04";
    self.content.text = @"发甲方领取文件费力气减肥了就爱了就发了房间里去忘记发了穷家富路沁芳居发静安路附近阿拉基";
    self.pubDate.text = @"2019年6月5号";
    self.commentNum.text = @"已看: 1099";
    
}

- (void)setupConstraints {
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.equalTo(@(40));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(10);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(65);
        make.top.equalTo(self.avatar.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(65);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.date.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(65);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.pubDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(65);
        make.top.equalTo(self.content.mas_bottom).offset(20);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.pubDate);
    }];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
