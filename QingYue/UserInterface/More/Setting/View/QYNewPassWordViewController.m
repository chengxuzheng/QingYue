//
//  QYNewPassWordViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYNewPassWordViewController.h"
#import "QYMainTabBarViewController.h"
#import "DYLimitLengthTextField.h"
#import "QYLoginViewController.h"

@interface QYNewPassWordViewController ()<UITextFieldDelegate>
/** 密码输入框*/
@property (nonatomic,strong) DYLimitLengthTextField* passwordTextField;
/** 确认密码输入框*/
@property (nonatomic, strong) DYLimitLengthTextField *confirmTextField;
/** 完成按钮*/
@property (nonatomic, strong) UIButton *completeButton;
/** 提示框*/
@property (nonatomic, strong) UILabel *messageLabel;
/** 小绿点*/
@property (nonatomic, strong) UILabel *greenLabel;

@end

@implementation QYNewPassWordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_passwordTextField resignFirstResponder];
    [_confirmTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250, 1.0);
    self.navigationItem.title = @"新密码";
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.completeButton];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.greenLabel];
}
#pragma mark - 按钮实现方法
//确定按钮
- (void)completeButtonAction
{
    [_passwordTextField resignFirstResponder];
    [_confirmTextField resignFirstResponder];
    if ([_confirmTextField.text length] != [_passwordTextField.text length]) {
        _messageLabel.hidden = NO;
        _greenLabel.hidden = YES;
    } else {
        _messageLabel.hidden = YES;
        _greenLabel.hidden = YES;
        QYLoginViewController *loginVC = [[QYLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma mark - textfield delegate
//当输入框 输入内容 是空格 禁止输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *characterSet;
    characterSet = [[NSCharacterSet characterSetWithCharactersInString:kPassWord] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        return NO;
    }
    return YES;
}

#pragma mark - 点击空白处收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_passwordTextField resignFirstResponder];
    [_confirmTextField resignFirstResponder];
    
}
#pragma mark - 2个textfield编辑的时候实现的方法
//输入新密码
- (void)passwordTextFieldClick
{
    if ([_passwordTextField.text length] != 0 && [_confirmTextField.text length] != 0) {
        _completeButton.enabled = YES;
        _completeButton.backgroundColor = RGB(38, 203, 100, 1.0);
    } else {
        _completeButton.enabled = NO;
        _completeButton.backgroundColor = RGB(231, 232, 233, 1.0);
    }
}

//确认密码
- (void)confirmTextFieldClick
{
    if ([_passwordTextField.text length] != 0 && [_confirmTextField.text length] != 0) {
        _completeButton.enabled = YES;
        _completeButton.backgroundColor = RGB(38, 203, 100, 1.0);
    } else {
        _completeButton.enabled = NO;
        _completeButton.backgroundColor = RGB(231, 232, 233, 1.0);
    }
}
#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.height.equalTo(@(50));
    }];
    [_confirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
    }];
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_confirmTextField.mas_bottom).offset(45);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_confirmTextField.mas_bottom).offset(15);
        make.bottom.equalTo(_completeButton.mas_top).offset(- 15);
    }];
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageLabel.mas_centerY);
        make.right.equalTo(_messageLabel.mas_left).offset(- 3);
        make.width.equalTo(@(5));
        make.height.equalTo(@(5));
    }];
}

#pragma mark - lazy load
- (DYLimitLengthTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[DYLimitLengthTextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor clearColor];
        _passwordTextField.delegate = self;
        _passwordTextField.layer.borderWidth = 0.7;
        _passwordTextField.layer.borderColor = RGB(235, 235, 235, 1.0).CGColor;
        _passwordTextField.placeholder = @" 请输入新密码";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"mima"];
        leftIcon.width = 30;
        leftIcon.height = 30;
        leftIcon.contentMode = UIViewContentModeCenter;
        _passwordTextField.leftView = leftIcon;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _passwordTextField.font = [UIFont systemFontOfSize:17];
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordTextField becomeFirstResponder];
        _passwordTextField.limitLength = 20;
        _passwordTextField.layer.cornerRadius = 5;
        [_passwordTextField addTarget:self action:@selector(passwordTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}
- (DYLimitLengthTextField *)confirmTextField
{
    if (!_confirmTextField) {
        _confirmTextField = [[DYLimitLengthTextField alloc] init];
        _confirmTextField.backgroundColor = [UIColor clearColor];
        _confirmTextField.delegate = self;
        _confirmTextField.layer.borderWidth = 0.7;
        _confirmTextField.layer.borderColor = RGB(235, 235, 235, 1.0).CGColor;
        _confirmTextField.placeholder = @" 请再次输入新密码";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"mima"];
        leftIcon.width = 30;
        leftIcon.height = 30;
        leftIcon.contentMode = UIViewContentModeCenter;
        _confirmTextField.leftView = leftIcon;
        _confirmTextField.leftViewMode = UITextFieldViewModeAlways;
        _confirmTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _confirmTextField.font = [UIFont systemFontOfSize:17];
        _confirmTextField.borderStyle = UITextBorderStyleNone;
        _confirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_confirmTextField becomeFirstResponder];
        _confirmTextField.limitLength = 20;
        _confirmTextField.layer.cornerRadius = 5;
        [_confirmTextField addTarget:self action:@selector(confirmTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _confirmTextField;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //上来注册的按钮就设置为灰色
        _completeButton.backgroundColor = RGB(231, 232, 233, 1.0);
        _completeButton.layer.cornerRadius = 5;
        _completeButton.enabled = NO;
        [_completeButton setTitle:@"确定" forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.hidden = YES;
        _messageLabel.text = @"两次输入的密码不一致";
        _messageLabel.textColor = RGB(145, 145, 145, 1.0);
        _messageLabel.font = Font(14);
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        CGSize maximumLabelSize = CGSizeMake(100, 9999);
        //关键语句
        CGSize expectSize = [_messageLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        _messageLabel.frame = CGRectMake(0, 0, expectSize.width, expectSize.height);
    }
    return _messageLabel;
}

- (UILabel *)greenLabel
{
    if (!_greenLabel) {
        _greenLabel = [[UILabel alloc] init];
        _greenLabel.backgroundColor = RGB(38, 203, 100, 1.0);
        _greenLabel.layer.cornerRadius = 5;
        _greenLabel.clipsToBounds = YES;
        _greenLabel.hidden = YES;
    }
    return _greenLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
