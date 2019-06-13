//
//  SQHomePlanCommentCell.h
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQBaseCell.h"
#import "SQHomePlanCommentModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol SQHomePlanCommentCellDelegate <NSObject>

- (void)reportIllegalUserOrContentWithIndex:(NSInteger)index;

@end

@interface SQHomePlanCommentCell : SQBaseCell

@property (nonatomic, weak) id <SQHomePlanCommentCellDelegate> delegate;

@property (nonatomic, strong) SQHomePlanCommentModel *model;

@end

NS_ASSUME_NONNULL_END
