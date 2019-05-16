//
//  SQBaseViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQBaseViewController.h"

@interface SQBaseViewController ()

@end

@implementation SQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableViewStyle = UITableViewStylePlain;
    self.refreshType = SQRefreshTypeNone;
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarAlpha = @"1.0";
}

- (void)setupSubviews {
    
}

#pragma mark -- UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -- subClass override

- (void)refreshData {
    
}

- (void)loadMoreData {
    
}

#pragma mark -- setter

- (void)setRefreshType:(SQRefreshType)refreshType {
    _refreshType = refreshType;
    @weakify(self);
    switch (refreshType) {
            
        case SQRefreshTypeAll:{}
        case SQRefreshTypePullUp: {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self_weak_ loadMoreData];
            }];
            footer.automaticallyRefresh = YES;
            footer.automaticallyHidden = YES;
            [footer setTitle:@"加载完毕,请君使用。" forState:MJRefreshStateNoMoreData];
            self_weak_.sq_tableView.mj_footer = footer;
            if (refreshType != SQRefreshTypeAll) {
                break;
            }
        }
        case SQRefreshTypePullDown: {
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self_weak_ refreshData];
            }];
            self_weak_.sq_tableView.mj_header = header;
        }
            break;
        case SQRefreshTypeNone: {
            if (_sq_tableView.mj_header) {
                _sq_tableView.mj_header = nil;
            }
            if (_sq_tableView.mj_footer) {
                _sq_tableView.mj_footer = nil;
            }
        }
            break;
            
    }
}


- (UITableView *)sq_tableView {
    if (!_sq_tableView) {
        _sq_tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:self.tableViewStyle];
        _sq_tableView.delegate = self;
        _sq_tableView.dataSource = self;
        _sq_tableView.tableFooterView = [UIView new];
        _sq_tableView.estimatedRowHeight = 0;
        _sq_tableView.estimatedSectionFooterHeight = 0;
        _sq_tableView.estimatedSectionHeaderHeight = 0;
        _sq_tableView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11, *)) {
            _sq_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
    }
    return _sq_tableView;
}

- (void)dealloc {
    NSLog(@"%@ is dealloc", [self class]);
}

@end
