//
//  SQLoginViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQLoginViewController.h"
#import "SQRegisterViewController.h"

@interface SQLoginViewController ()

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation SQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavSeparatorLineHidden:YES];
}

- (void)setupNavItem {
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAccount)];
}

- (void)setupSubviews {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.safeTop + 20, kScreen_width - 40, 30)];
    label.text = @"账号密码登录";
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:label];
    
    
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, label.maxY + 30, kScreen_width - 40, 40)];
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    self.phoneTF.tintColor = kThemeColor;
    self.phoneTF.placeholder = @"请输入手机号码";
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.phoneTF];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(20, self.phoneTF.maxY, self.phoneTF.width, 1)];
    line1.backgroundColor = kThemeColor;
    line1.backgroundColor = [kThemeColor colorWithAlphaComponent:0.3];
    [self.view addSubview:line1];
    
    self.passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, self.phoneTF.maxY + 30, kScreen_width - 40, 40)];
    self.passwordTF.font = [UIFont systemFontOfSize:15];
    self.passwordTF.tintColor = kThemeColor;
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.secureTextEntry = YES;
    [self.view addSubview:self.passwordTF];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, self.passwordTF.maxY, self.phoneTF.width, 1)];
    line2.backgroundColor = [kThemeColor colorWithAlphaComponent:0.3];
    [self.view addSubview:line2];
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, self.passwordTF.maxY + 80, kScreen_width - 80, 40)];
    self.loginBtn.backgroundColor = kThemeColor;
    self.loginBtn.layer.cornerRadius = 20;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    @weakify(self);
    
    RAC(self.loginBtn, enabled) = [RACSignal combineLatest:@[self.passwordTF.rac_textSignal, self.phoneTF.rac_textSignal] reduce:^(NSString *password, NSString *username) {
        if (username.length == 11 && password.length >= 6) {
            self_weak_.loginBtn.backgroundColor = kThemeColor;
        } else {
            self_weak_.loginBtn.backgroundColor = [kThemeColor colorWithAlphaComponent:0.4];
        }
        return @(username.length == 11 && password.length >= 6);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
//        @strongify(self);
        NSLog(@"123456");
        [self_weak_ login];
    }];
    
}

#pragma mark -- login

- (void)login {
    [self showHUDWithMessage:@"正在登录中..."];
    NSDictionary *param = @{@"mobile": self.phoneTF.text, @"password": self.passwordTF.text};
    [SQNetworkManager POST:sq_url_combine(user_login) parameters:param success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        [self showSuccessWithMessage:@"登录成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
        NSLog(@"data----->%@", data);
    } fail:^(NSError * _Nonnull error) {
        NSLog(@"error----->%@", error);

    }];
    
}

#pragma mark -- event

- (void)registerAccount {
    SQRegisterViewController *re = [SQRegisterViewController new];
    [self.navigationController pushViewController:re animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
