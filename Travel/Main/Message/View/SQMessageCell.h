//
//  SQMessageCell.h
//  Travel
//
//  Created by yinsiqian on 2019/6/18.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@class SQMessageModel;
@interface SQMessageCell : SQBaseCell

@property (nonatomic, strong) SQMessageModel *model;

@end

NS_ASSUME_NONNULL_END
