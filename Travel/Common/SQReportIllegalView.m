//
//  SQReportIllegalView.m
//  Travel
//
//  Created by yinsiqian on 2019/6/13.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQReportIllegalView.h"


@interface SQReportIllegalCell : SQBaseCell

@property (nonatomic, strong) UIImageView *selectedImage;

@property (nonatomic, strong) UILabel *content;

@property (nonatomic, assign) BOOL isSelected;

@end

@implementation SQReportIllegalCell

- (void)setupSubviews {
    self.selectedImage = [UIImageView new];
    self.selectedImage.image = [UIImage imageNamed:@"icon_report_unselected"];
    [self.contentView addSubview:self.selectedImage];
    
    self.content = [UILabel new];
    self.content.textColor = kBlackColor;
    self.content.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.content];
}

- (void)setupConstraints {
    [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(80);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.selectedImage.image = [UIImage imageNamed:@"icon_report_selected"];
    } else {
        self.selectedImage.image = [UIImage imageNamed:@"icon_report_unselected"];
    }
}


@end

@interface SQReportIllegalView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) void(^complectionHandler)(NSString *content);

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *ensureBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<NSMutableDictionary *> *data;

@end

@implementation SQReportIllegalView

- (instancetype)initComplectionHandler:(void(^)(NSString *content))complection {
    if (self = [super init]) {
        self.complectionHandler = complection;
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMaskColor;
        [self setupSubviews];
        [self initialData];
    }
    return self;
}

- (void)initialData {
    NSDictionary *reason1 = @{@"content": @"言语辱骂", @"isSelected": @0};
    NSDictionary *reason2 = @{@"content": @"情色暴力", @"isSelected": @0};
    NSDictionary *reason3 = @{@"content": @"广告", @"isSelected": @0};
    NSDictionary *reason4 = @{@"content": @"其他", @"isSelected": @0};
    self.data = @[reason1.mutableCopy,
                  reason2.mutableCopy,
                  reason3.mutableCopy,
                  reason4.mutableCopy];

}

- (void)setupSubviews {
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(15, (kScreen_height - 400) / 2, kScreen_width - 30, 300)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    
    UILabel *title = [UILabel new];
    title.textColor = kBlackColor;
    title.font = [UIFont boldSystemFontOfSize:16];
    title.text = @"举报";
    [self.contentView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = kSeparatorColor;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(40);
        make.height.equalTo(@1);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 41, self.contentView.width - 30, self.contentView.height - 95) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, self.contentView.height - 50, (self.contentView.width - 45) / 2, 40)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:kLightDarkColor forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = kDarkBackColor;
    self.cancelBtn.layer.cornerRadius = 6;
    self.cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    self.ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(30 + (self.contentView.width - 45) / 2, self.contentView.height - 50, (self.contentView.width - 45) / 2, 40)];
    [self.ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ensureBtn.backgroundColor = kThemeColor;
    self.ensureBtn.layer.cornerRadius = 6;
    self.ensureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ensureBtn.layer.borderWidth = 1;
    [self.contentView addSubview:self.ensureBtn];
    [self.ensureBtn addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQReportIllegalCell *cell = [SQReportIllegalCell cellWithTableView:tableView];
    cell.content.text = self.data[indexPath.row][@"content"];
    cell.isSelected = [self.data[indexPath.row][@"isSelected"] boolValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.data[indexPath.row][@"isSelected"] boolValue]) {
        self.data[indexPath.row][@"isSelected"] = @0;
    } else {
        self.data[indexPath.row][@"isSelected"] = @1;
    }
    SQReportIllegalCell *cell = (SQReportIllegalCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = [self.data[indexPath.row][@"isSelected"] boolValue];
}

#pragma mark -- events

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)ensure {
    
    NSMutableArray<NSString *> *contents = [NSMutableArray array];
    for (NSDictionary *dict in self.data) {
        if ([dict[@"isSelected"] boolValue]) {
            [contents addObject:dict[@"content"]];
        }
    }
    if (contents.count == 0) {
        [self showMessage:@"请选择举报内容再提交!"];
        return;
    }
    NSString *reportContent = [contents componentsJoinedByString:@","];
    
    if (self.complectionHandler) {
        self.complectionHandler(reportContent);
    }
    [self hide];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [touches.allObjects.firstObject locationInView:self];
    if (point.y < self.contentView.y || point.y > self.contentView.maxY || point.x < self.contentView.x || point.x > self.contentView.maxX) {
        [self hide];
    }
}



@end
