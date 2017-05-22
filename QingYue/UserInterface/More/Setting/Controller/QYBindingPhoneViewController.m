//
//  QYBindingPhoneViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/2.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBindingPhoneViewController.h"
#import "DYLimitLengthTextField.h"
#import "QYNewPassWordViewController.h"

@interface QYBindingPhoneViewController ()<UITextFieldDelegate>
/** 手机号输入框*/
@property (nonatomic,strong) DYLimitLengthTextField* phoneTextField;
/** 验证码输入框*/
@property (nonatomic, strong) DYLimitLengthTextField *codeTextField;
/** 发送验证码按钮*/
@property (nonatomic,strong) UIButton* gainButton;
/** 完成按钮*/
@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation QYBindingPhoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"绑定手机号码";
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.gainButton];
    [self.view addSubview:self.completeButton];
}

#pragma mark - 按钮实现方法
//发送验证码按钮 点击事件
- (void)gainButtonClick
{
    [self setMessage];
}

//发送验证码方法
- (void)setMessage
{
    //倒计时
    __block int timeout = 60;
    //全局队列并行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每一秒执行timmer
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    //设置dispatch事件的block, 在指定队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //倒计时结束
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            //异步加载 主队列
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮 显示, 自己设置
                [_gainButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                _gainButton.userInteractionEnabled = YES;
                _gainButton.backgroundColor = RGB(210, 210, 210, 1.0);
            });
        } else {
            int seconds = timeout % 120;
            NSString *timeStr = [NSString stringWithFormat:@"%.2d", seconds];
            //异步加载 主队列
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置自己的页面
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_gainButton setTitle:[NSString stringWithFormat:@"重新发送(%@)", timeStr] forState:UIControlStateNormal];
                _gainButton.backgroundColor = RGB(38, 203, 100, 1.0);
                //结束 动画
                [UIView commitAnimations];
                //当读秒的时候, 禁止点击
                _gainButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    //恢复到计时器的队列
    dispatch_resume(timer);
}

//立即注册按钮 点击事件
- (void)completeButtonAction
{
    QYNewPassWordViewController *newPassVC = [[QYNewPassWordViewController alloc] init];
    [self.navigationController pushViewController:newPassVC animated:YES];
}


#pragma mark - 点击空白处收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}

#pragma mark - textfield delegate
//当输入框输入return健的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTextField) {
        [_phoneTextField resignFirstResponder];
        [_codeTextField becomeFirstResponder];
        
    } else {
        [_codeTextField resignFirstResponder];
    }
    return YES;
}

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

#pragma mark - 两个textfield编辑的时候实现的方法
//手机号
- (void)phoneTextFiedlClick
{
    if ([_phoneTextField.text length] == 11 && [_codeTextField.text length] == 4) {
        _completeButton.enabled = YES;
        _completeButton.backgroundColor = RGB(38, 203, 100, 1.0);
    }else{
        _completeButton.enabled = NO;
        _completeButton.backgroundColor = RGB(231, 232, 233, 1.0);
    }
}

//验证码
- (void)codeTextFieldClick
{
    if ([_phoneTextField.text length] == 11 && [_codeTextField.text length] == 4) {
        _completeButton.enabled = YES;
        _completeButton.backgroundColor = RGB(38, 203, 100, 1.0);
    }else{
        _completeButton.enabled = NO;
        _completeButton.backgroundColor = RGB(231, 232, 233, 1.0);
    }
}

#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.height.equalTo(@(50));
    }];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_phoneTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_codeTextField.mas_bottom).offset(20);
    }];
    [_gainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(- 10);
        make.width.mas_equalTo(125);
        make.centerY.equalTo(_codeTextField.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
}
#pragma mark - lazy load
- (DYLimitLengthTextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[DYLimitLengthTextField alloc] init];
        _phoneTextField.backgroundColor = [UIColor clearColor];
        _phoneTextField.delegate = self;
        _phoneTextField.layer.borderWidth = 0.7;
        _phoneTextField.layer.borderColor = RGB(235, 235, 235, 1.0).CGColor;
        _phoneTextField.placeholder = @" 请输入您的手机号";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"shoujihaoma"];
        leftIcon.width = 30;
        leftIcon.height = 30;
        leftIcon.contentMode = UIViewContentModeCenter;
        _phoneTextField.leftView = leftIcon;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.font = [UIFont systemFontOfSize:17];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTextField becomeFirstResponder];
        _phoneTextField.limitLength = 11;
        _phoneTextField.layer.cornerRadius = 5;
        [_phoneTextField addTarget:self action:@selector(phoneTextFiedlClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (DYLimitLengthTextField *)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = [[DYLimitLengthTextField alloc] init];
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        _codeTextField.placeholder = @" 请输入您的验证码";
        _codeTextField.font = Font(17);
        _codeTextField.layer.borderWidth = 0.7;
        _codeTextField.layer.cornerRadius = 5;
        _codeTextField.layer.borderColor = RGB(235, 235, 235, 1.0).CGColor;
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"yanzhengma"];
        leftIcon.width = 30;
        leftIcon.height = 30;
        leftIcon.contentMode = UIViewContentModeCenter;
        _codeTextField.leftView = leftIcon;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.limitLength = 4;
        [_codeTextField addTarget:self action:@selector(codeTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTextField;
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

- (UIButton *)gainButton
{
    if (!_gainButton) {
        _gainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainButton.backgroundColor = RGB(210, 210, 210, 1.0);
        [_gainButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_gainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _gainButton.titleLabel.font = Font(14);
        [_gainButton addTarget:self action:@selector(gainButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gainButton;
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
