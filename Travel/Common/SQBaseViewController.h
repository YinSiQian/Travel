//
//  SQBaseViewController.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SQRefreshType) {
    SQRefreshTypeAll,          //上下拉
    SQRefreshTypePullDown,     //下拉刷新
    SQRefreshTypePullUp,       //上拉加载更多
    SQRefreshTypeNone          //默认无
};

@interface SQBaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) SQRefreshType refreshType;

//设置tableViewStyle. 需在设置刷新类型前使用
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, strong) UITableView *sq_tableView;

//交由子类重载, 加载更多数据
- (void)loadMoreData;

//交由子类重载, 刷新数据
- (void)refreshData;

- (void)setupSubviews;

@end

NS_ASSUME_NONNULL_END
