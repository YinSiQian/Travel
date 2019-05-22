//
//  SQMinePublishPlanCell.m
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQMinePublishPlanCell.h"

@interface SQMinePublishPlanCell ()

@property (nonatomic, strong) UILabel *date;

@property (nonatomic, strong) UILabel *pubDate;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UILabel *commentNum;

@property (nonatomic, strong) UIImageView *commentImage;

@property (nonatomic, strong) UIImageView *dateImage;

@end

@implementation SQMinePublishPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubviews {
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
    
    self.dateImage = [UIImageView new];
    self.dateImage.image = [UIImage imageNamed:@"icon_home_date"];
    [self.contentView addSubview:self.dateImage];
    
    self.commentImage = [UIImageView new];
    self.commentImage.image = [UIImage imageNamed:@"icon_home_comment"];
    [self.contentView addSubview:self.commentImage];
}

- (void)setupConstraints {
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateImage.mas_right).offset(5);
        make.centerY.equalTo(self.dateImage);
    }];
    
    [self.dateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.date.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.pubDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.content.mas_bottom).offset(20);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.pubDate);
    }];
    
    [self.commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentNum);
        make.right.equalTo(self.commentNum.mas_left).offset(-5);
        
    }];
}

- (void)setModel:(SQHomePlanModel *)model {
    _model = model;
    self.title.text = model.title;
    self.date.text = model.date;
    self.content.text = model.content;
    self.commentNum.text = [NSString stringWithFormat:@"%ld", model.num];
    self.pubDate.text = [SQHelp formatterTimestamp:model.createTime / 1000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
