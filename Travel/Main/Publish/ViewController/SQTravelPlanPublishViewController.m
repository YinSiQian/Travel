//
//  SQTravelPlanPublishViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQTravelPlanPublishViewController.h"
#import "SQTextView.h"
#import "SQCalendarView.h"

@interface SQTravelPlanPublishViewController ()

@property (nonatomic, strong) UITextField *titleTF;

@property (nonatomic, strong) SQTextView *textView;

@property (nonatomic, strong) UIButton *chooseDateBtn;

@property (nonatomic, strong) UIButton *chooseEndDateBtn;

@property (nonatomic, assign) BOOL isChooseDate;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;


@end

@implementation SQTravelPlanPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布出行计划";
    [self setupBack];
    [self setupSubviews];
    [self setupItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarAlpha = @"0.0";
}

- (void)setupBack {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, kScreen_width, kScreen_height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.8].CGColor, (__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.5].CGColor, (__bridge id)[UIColor colorWithHexString:@"5fa33c" alpha:0.3].CGColor];
    gl.locations = @[@(0.0), @(0.3),@(1.0)];
    [self.view.layer addSublayer:gl];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    
}

- (void)setupItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishPlan)];
}

- (void)setupSubviews {
    
    UILabel *title = [UILabel new];
    title.text = @"出行标题:";
    title.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.safeTop + 20);
        make.left.equalTo(self.view).offset(15);
    }];
    
    self.titleTF = [UITextField new];
    self.titleTF.font = [UIFont systemFontOfSize:16];
    self.titleTF.tintColor = kThemeColor;
    self.titleTF.placeholder = @"请输入少于20字的标题";
    self.titleTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.titleTF];
    
    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(title);
        make.height.equalTo(@30);
    }];
    
    UILabel *date = [UILabel new];
    date.text = @"出发时间:";
    date.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:date];
    
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(title.mas_bottom).offset(30);
    }];
    
    UILabel *endDate = [UILabel new];
    endDate.text = @"结束时间:";
    endDate.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:endDate];
    
    [endDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(date.mas_bottom).offset(30);
    }];
    
    self.chooseDateBtn = [UIButton new];
    [self.chooseDateBtn setTitle:@"选择出发日期>" forState:UIControlStateNormal];
    [self.chooseDateBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    self.chooseDateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.chooseDateBtn addTarget:self action:@selector(chooseData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseDateBtn];
    
    
    [self.chooseDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(date);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    self.chooseEndDateBtn = [UIButton new];
    [self.chooseEndDateBtn setTitle:@"选择结束日期>" forState:UIControlStateNormal];
    [self.chooseEndDateBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    self.chooseEndDateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.chooseEndDateBtn addTarget:self action:@selector(chooseEndData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseEndDateBtn];
    
    [self.chooseEndDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(endDate);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    UILabel *des = [UILabel new];
    des.text = @"出行描述:";
    des.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:des];
    
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endDate.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(15);
    }];
    
    
    self.textView = [SQTextView new];
    self.textView.maxNum = 300;
    self.textView.placeholder = @"请输入详细的出行计划描述,内容在10-300字之间.";
    self.textView.layer.borderColor = [kThemeColor colorWithAlphaComponent:0.3].CGColor;
    self.textView.layer.borderWidth = 1;
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(des.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@300);
    }];
    
}


#pragma mark -- events

- (void)chooseEndData {
    SQCalendarView *calendarView = [[SQCalendarView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    calendarView.complectionHandler = ^(NSString *date) {
        NSLog(@"date--->%@", date);
        if (date) {
            self.endDate = date;
            [self.chooseEndDateBtn setTitle:date forState:UIControlStateNormal];
        }
    };
    if (self.startDate) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd";
        calendarView.minimumDate = [formatter dateFromString:self.startDate];
    }
    [calendarView show];
}

- (void)chooseData {
    
    SQCalendarView *calendarView = [[SQCalendarView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    calendarView.complectionHandler = ^(NSString *date) {
        NSLog(@"date--->%@", date);
        if (date) {
            self.startDate = date;
            [self.chooseDateBtn setTitle:date forState:UIControlStateNormal];
        }

    };
    if (self.endDate) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd";
        calendarView.maximumDate = [formatter dateFromString:self.endDate];
    }
    [calendarView show];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishPlan {
    
    if (self.startDate && self.endDate && self.titleTF.text.length > 0 && self.textView.content.length > 0) {
        
        [self showMessage:@"正在发布中..."];
        NSString *date = [NSString stringWithFormat:@"%@ - %@", self.startDate, self.endDate];
        NSDictionary *params = @{@"title": self.titleTF.text,
                                 @"date": date,
                                 @"content": self.textView.content};
        [SQNetworkManager POST:sq_url_combine(publish) parameters:params success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [self showSuccessWithMessage:@"发布成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        } fail:^(NSError * _Nonnull error) {
            
        }];
    } else {
        [self showFailureWithMessage:@"请完善信息后,再发布."];
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.titleTF resignFirstResponder];
}

@end
