//
//  SQUserInfoCell.h
//  Travel
//
//  Created by yinsiqian on 2019/6/26.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQUserInfoCell : SQBaseCell

- (void)setDataWithTitle:(NSString *)title
                 content:(NSString *)content
                isAvatar:(BOOL)isAvatar;

@end

NS_ASSUME_NONNULL_END
