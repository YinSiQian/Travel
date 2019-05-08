//
//  SQRegisterViewController.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQRegisterViewController.h"

@interface SQRegisterViewController ()

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UITextField *passwordTF2;


@end

@implementation SQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self setupSubviews];
}

- (void)setupSubviews {
    
    
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, self.safeTop + 40, kScreen_width - 40, 40)];
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    self.phoneTF.tintColor = kThemeColor;
    self.phoneTF.placeholder = @"请输入手机号码";
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.phoneTF];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(20, self.phoneTF.maxY, self.phoneTF.width, 1)];
    line1.backgroundColor = [kThemeColor colorWithAlphaComponent:0.3];
    [self.view addSubview:line1];
    
    self.passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(20, self.phoneTF.maxY + 30, kScreen_width - 40, 40)];
    self.passwordTF.font = [UIFont systemFontOfSize:15];
    self.passwordTF.tintColor = kThemeColor;
    self.passwordTF.placeholder = @"请输入密码(至少6位)";
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.secureTextEntry = YES;
    [self.view addSubview:self.passwordTF];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, self.passwordTF.maxY, self.phoneTF.width, 1)];
    line2.backgroundColor = [kThemeColor colorWithAlphaComponent:0.3];
    [self.view addSubview:line2];
    
    self.passwordTF2 = [[UITextField alloc]initWithFrame:CGRectMake(20, self.passwordTF.maxY + 30, kScreen_width - 40, 40)];
    self.passwordTF2.font = [UIFont systemFontOfSize:15];
    self.passwordTF2.tintColor = kThemeColor;
    self.passwordTF2.placeholder = @"请再次输入密码(至少6位)";
    self.passwordTF2.borderStyle = UITextBorderStyleNone;
    self.passwordTF2.secureTextEntry = YES;
    [self.view addSubview:self.passwordTF2];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(20, self.passwordTF2.maxY, self.phoneTF.width, 1)];
    line3.backgroundColor = [kThemeColor colorWithAlphaComponent:0.3];
    [self.view addSubview:line3];
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, self.passwordTF2.maxY + 80, kScreen_width - 80, 40)];
    self.loginBtn.backgroundColor = [kThemeColor colorWithAlphaComponent:0.4];
    self.loginBtn.layer.cornerRadius = 20;
    [self.loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    @weakify(self);
    
    RAC(self.loginBtn, enabled) = [RACSignal combineLatest:@[self.passwordTF.rac_textSignal, self.phoneTF.rac_textSignal, self.passwordTF2.rac_textSignal] reduce:^(NSString *password, NSString *username, NSString *password2) {
        if (username.length == 11 && password.length >= 6 && password2.length >= 6) {
            self.loginBtn.backgroundColor = kThemeColor;
        } else {
            self.loginBtn.backgroundColor = [kThemeColor colorWithAlphaComponent:0.4];
        }
        return @(username.length == 11 && password.length >= 6 && password2.length >= 6);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        //        @strongify(self);
        [self showSuccessWithMessage:@"注册成功"];
        NSLog(@"123456");
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
