//
//  SQInputView.m
//  Travel
//
//  Created by yinsiqian on 2019/5/27.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQInputView.h"
#import "SQTextView.h"

@interface SQInputView ()

@property (nonatomic, copy) void(^complectionHandler)(NSString *content);

@property (nonatomic, strong) SQTextView *textView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *ensureBtn;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation SQInputView

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
    }
    return self;
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
    title.text = @"输入评论信息";
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
    
    self.textView = [[SQTextView alloc]initWithFrame:CGRectMake(15, 55, self.contentView.width - 30, self.contentView.height - 120)];
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    self.textView.backgroundColor = kDarkBackColor;
    self.textView.maxNum = 400;
    self.textView.placeholder = @"输入你的想法";
    [self.contentView addSubview:self.textView];
    
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
    
    if (self.complectionHandler) {
        self.complectionHandler(self.textView.content);
    }
    [self hide];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textView.placeholder = _placeholder;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [touches.allObjects.firstObject locationInView:self];
    if (point.y < self.contentView.y || point.y > self.contentView.maxY || point.x < self.contentView.x || point.x > self.contentView.maxX) {
        [self endEditing:YES];
    }
}

@end
