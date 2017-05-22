//
//  QYMoreRecommendBuyButtonViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreRecommendBuyButtonViewController.h"
#import "DYLimitLengthTextField.h"

@interface QYMoreRecommendBuyButtonViewController ()
/** 第一个textfield*/
@property (nonatomic, strong) DYLimitLengthTextField *firstTextField;
/** 第二个textfield*/
@property (nonatomic, strong) DYLimitLengthTextField *secondTextField;
/** 第三个textfield*/
@property (nonatomic, strong) DYLimitLengthTextField *thirdTextField;
/** 第四个textfield*/
@property (nonatomic, strong) DYLimitLengthTextField *fouthTextField;
/** 第五个textfield*/
@property (nonatomic, strong) DYLimitLengthTextField *fifthTextField;
/** 提交按钮*/
@property (nonatomic, strong) UIButton *completeButton;
/** 提示框*/
@property (nonatomic, strong) UILabel *messageLabel;
/** 小绿点*/
@property (nonatomic, strong) UILabel *greenLabel;
@end

@implementation QYMoreRecommendBuyButtonViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_firstTextField resignFirstResponder];
    [_secondTextField resignFirstResponder];
    [_thirdTextField resignFirstResponder];
    [_fouthTextField resignFirstResponder];
    [_fifthTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstTextField];
    [self.view addSubview:self.secondTextField];
    [self.view addSubview:self.thirdTextField];
    [self.view addSubview:self.fouthTextField];
    [self.view addSubview:self.fifthTextField];
    [self.view addSubview:self.completeButton];
    [self.view addSubview:self.greenLabel];
    [self.view addSubview:self.messageLabel];
}

#pragma mark - 按钮实现方法
- (void)completeButtonAction
{
    _greenLabel.hidden = NO;
    _messageLabel.hidden = NO;
}

#pragma mark - 触摸时候,收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_firstTextField resignFirstResponder];
    [_secondTextField resignFirstResponder];
    [_thirdTextField resignFirstResponder];
    [_fouthTextField resignFirstResponder];
    [_fifthTextField resignFirstResponder];
}

#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_firstTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.height.equalTo(@(50));
    }];
    [_secondTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_firstTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [_thirdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_secondTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [_fouthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_thirdTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [_fifthTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_fouthTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_fifthTextField.mas_bottom).offset(40);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_fifthTextField.mas_bottom).offset(10);
        make.bottom.equalTo(_completeButton.mas_top).offset(- 10);
    }];
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageLabel.mas_centerY);
        make.right.equalTo(_messageLabel.mas_left).offset(- 3);
        make.width.equalTo(@(5));
        make.height.equalTo(@(5));
    }];

}
#pragma mark - lazy load
- (DYLimitLengthTextField *)firstTextField
{
    if (!_firstTextField) {
        _firstTextField = [[DYLimitLengthTextField alloc] init];
        _firstTextField.backgroundColor = [UIColor clearColor];
        _firstTextField.layer.borderWidth = 0.7;
        _firstTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _firstTextField.placeholder = @" 请输入书名";
        _firstTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _firstTextField.font = [UIFont systemFontOfSize:17];
        _firstTextField.borderStyle = UITextBorderStyleNone;
        _firstTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_firstTextField becomeFirstResponder];
        _firstTextField.limitLength = 20;
        _firstTextField.layer.cornerRadius = 5;
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"啥也没有"];
        leftIcon.width = 15;
        leftIcon.height = 20;
        _firstTextField.leftView = leftIcon;
        _firstTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _firstTextField;
}

- (DYLimitLengthTextField *)secondTextField
{
    if (!_secondTextField) {
        _secondTextField = [[DYLimitLengthTextField alloc] init];
        _secondTextField.backgroundColor = [UIColor clearColor];
        _secondTextField.layer.borderWidth = 0.7;
        _secondTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _secondTextField.placeholder = @" 请输入ISBN";
        _secondTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _secondTextField.font = [UIFont systemFontOfSize:17];
        _secondTextField.borderStyle = UITextBorderStyleNone;
        _secondTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_secondTextField becomeFirstResponder];
        _secondTextField.limitLength = 20;
        _secondTextField.layer.cornerRadius = 5;
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"啥也没有"];
        leftIcon.width = 15;
        leftIcon.height = 20;
        _secondTextField.leftView = leftIcon;
        _secondTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _secondTextField;
}

- (DYLimitLengthTextField *)thirdTextField
{
    if (!_thirdTextField) {
        _thirdTextField = [[DYLimitLengthTextField alloc] init];
        _thirdTextField.backgroundColor = [UIColor clearColor];
        _thirdTextField.layer.borderWidth = 0.7;
        _thirdTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _thirdTextField.placeholder = @" 请输入作者";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"啥也没有"];
        leftIcon.width = 15;
        leftIcon.height = 20;
        _thirdTextField.leftView = leftIcon;
        _thirdTextField.leftViewMode = UITextFieldViewModeAlways;
        _thirdTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _thirdTextField.font = [UIFont systemFontOfSize:17];
        _thirdTextField.borderStyle = UITextBorderStyleNone;
        _thirdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_thirdTextField becomeFirstResponder];
        _thirdTextField.limitLength = 20;
        _thirdTextField.layer.cornerRadius = 5;
    }
    return _thirdTextField;
}

- (DYLimitLengthTextField *)fouthTextField
{
    if (!_fouthTextField) {
        _fouthTextField = [[DYLimitLengthTextField alloc] init];
        _fouthTextField.backgroundColor = [UIColor clearColor];
        _fouthTextField.layer.borderWidth = 0.7;
        _fouthTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _fouthTextField.placeholder = @" 请输入出版社";
        _fouthTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _fouthTextField.font = [UIFont systemFontOfSize:17];
        _fouthTextField.borderStyle = UITextBorderStyleNone;
        _fouthTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_fouthTextField becomeFirstResponder];
        _fouthTextField.limitLength = 20;
        _fouthTextField.layer.cornerRadius = 5;
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"啥也没有"];
        leftIcon.width = 15;
        leftIcon.height = 20;
        _fouthTextField.leftView = leftIcon;
        _fouthTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _fouthTextField;
}

- (DYLimitLengthTextField *)fifthTextField
{
    if (!_fifthTextField) {
        _fifthTextField = [[DYLimitLengthTextField alloc] init];
        _fifthTextField.backgroundColor = [UIColor clearColor];
        _fifthTextField.layer.borderWidth = 0.7;
        _fifthTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _fifthTextField.placeholder = @" 请输入出版社";
        _fifthTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _fifthTextField.font = [UIFont systemFontOfSize:17];
        _fifthTextField.borderStyle = UITextBorderStyleNone;
        _fifthTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_fifthTextField becomeFirstResponder];
        _fifthTextField.limitLength = 20;
        _fifthTextField.layer.cornerRadius = 5;
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"啥也没有"];
        leftIcon.width = 15;
        leftIcon.height = 20;
        _fifthTextField.leftView = leftIcon;
        _fifthTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _fifthTextField;
}
- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeButton.backgroundColor = RGB(38, 203, 100, 1.0);
        _completeButton.layer.cornerRadius = 5;
        [_completeButton setTitle:@"提交" forState:UIControlStateNormal];
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
        _messageLabel.text = @"这是什么鬼密码, 打的也不对,还想怎么输入";
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
