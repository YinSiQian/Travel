//
//  SQBaseCell.h
//  Travel
//
//  Created by ysq on 2019/5/16.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQBaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupSubviews;

- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
