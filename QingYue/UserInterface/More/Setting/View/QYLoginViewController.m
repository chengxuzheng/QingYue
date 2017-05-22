//
//  QYLoginViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYLoginViewController.h"
#import "QYMainTabBarViewController.h"
#import "DYLimitLengthTextField.h"
#import "QYforgetPassWordViewController.h"
#import "QYHomeViewController.h"

@interface QYLoginViewController ()<UITextFieldDelegate>
/** 头像图片*/
@property (nonatomic, strong) UIImageView *HeaderImageView;
/** 读书证输入框*/
@property (nonatomic, strong) DYLimitLengthTextField *cardTextField;
/** 密码输入框*/
@property (nonatomic,strong) DYLimitLengthTextField* passwordTextField;
/** 图书馆输入框*/
@property (nonatomic, strong) DYLimitLengthTextField *libraryTextField;
/** 登录按钮*/
@property (nonatomic, strong) UIButton *loginButton;
/** 提示框*/
@property (nonatomic, strong) UILabel *messageLabel;
/** 小绿点*/
@property (nonatomic, strong) UILabel *greenLabel;
/** 忘记密码*/
@property (nonatomic, strong) UIButton *forgetButton;


@end

@implementation QYLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [_cardTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_libraryTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250, 1.0);
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    [kUserDefaults removeObjectForKey:@"username"];
    [kUserDefaults synchronize];
    
    [self.view addSubview:self.cardTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.libraryTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.greenLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.HeaderImageView];
    [self.view addSubview:self.forgetButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 点击空白处收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_cardTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_libraryTextField resignFirstResponder];
}

#pragma mark - 按钮实现方法
//登录按钮实现方法
- (void)completeButtonAction
{
    
    [_cardTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    if ([_cardTextField.text length] == 0 || [_passwordTextField.text length] == 0) {
        _greenLabel.hidden = NO;
        _messageLabel.hidden = NO;
        return;
    }
    
    NSDictionary *param = @{@"Username":_cardTextField.text,
                            @"Password":_passwordTextField.text};
    
    [[YCRequestDataService sharedManager] Post:@"account/loginEx" parameters:param success:^(id response) {
        
        kShowNet(@"正在登录");
        
        if ([response[@"Code"] isEqualToString:@"成功"]) {
            
            UIGraphicsBeginImageContext(self.view.bounds.size);
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSData *data = UIImagePNGRepresentation(image);
            [kUserDefaults setObject:data forKey:@"tztImage"];
            
            [kUserDefaults setObject:_cardTextField.text forKey:@"username"];
            [kUserDefaults synchronize];
            
            kTimeAfter(1, ^{kShowNet(@"成功登录");});
            
            kTimeAfter(1.5, ^{
                QYMainTabBarViewController *mtbVC = [[QYMainTabBarViewController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = mtbVC;
            })
        } else {
            kTimeAfter(1, ^{kShowNet(response[@"Exception"]);});
        }
        
    } failure:^{

    }];
    
    
    
}

//忘记密码实现方法
- (void)forgetButtonClick
{
    QYforgetPassWordViewController *forgetVC = [[QYforgetPassWordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_HeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
        make.top.equalTo(self.view.mas_top).offset(90);
    }];
    [_cardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_HeaderImageView.mas_bottom).offset(30);
        make.height.equalTo(@(50));
    }];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(_cardTextField.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    
//    [_libraryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.right.equalTo(self.view.mas_right).offset(- 15);
//        make.height.equalTo(@(50));
//        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
//    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(45);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_libraryTextField.mas_bottom).offset(15);
        make.bottom.equalTo(_loginButton.mas_top).offset(- 15);
    }];
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageLabel.mas_centerY);
        make.right.equalTo(_messageLabel.mas_left).offset(- 3);
        make.width.equalTo(@(5));
        make.height.equalTo(@(5));
    }];
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_loginButton.mas_right);
        make.width.equalTo(@(80));
        make.top.equalTo(_loginButton.mas_bottom).offset(15);
        make.height.equalTo(@(20));
    }];

}

#pragma mark - lazy load


- (DYLimitLengthTextField *)cardTextField
{
    if (!_cardTextField) {
        _cardTextField = [[DYLimitLengthTextField alloc] init];
        _cardTextField.backgroundColor = [UIColor clearColor];
        _cardTextField.delegate = self;
        _cardTextField.layer.borderWidth = 0.7;
        _cardTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _cardTextField.placeholder = @" 请输入读者账号";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"zhengjianhao"];
        leftIcon.width = 30;
        leftIcon.height = 40;
        leftIcon.contentMode = UIViewContentModeCenter;
        _cardTextField.leftView = leftIcon;
        _cardTextField.leftViewMode = UITextFieldViewModeAlways;
//        _cardTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _cardTextField.font = [UIFont systemFontOfSize:17];
        _cardTextField.borderStyle = UITextBorderStyleNone;
        _cardTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_cardTextField becomeFirstResponder];
        _cardTextField.limitLength = 20;
        _cardTextField.layer.cornerRadius = 5;
//        [_cardTextField addTarget:self action:@selector(oldPasswordTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _cardTextField;
}
- (DYLimitLengthTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[DYLimitLengthTextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor clearColor];
        _passwordTextField.delegate = self;
        _passwordTextField.layer.borderWidth = 0.7;
        _passwordTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _passwordTextField.placeholder = @" 请输入密码";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"mima"];
        leftIcon.width = 30;
        leftIcon.height = 40;
        leftIcon.contentMode = UIViewContentModeCenter;
        _passwordTextField.leftView = leftIcon;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
//        _passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _passwordTextField.font = [UIFont systemFontOfSize:17];
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordTextField becomeFirstResponder];
        _passwordTextField.limitLength = 20;
        _passwordTextField.layer.cornerRadius = 5;
        _passwordTextField.secureTextEntry = YES;
//        [_passwordTextField addTarget:self action:@selector(passwordTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}
- (DYLimitLengthTextField *)libraryTextField
{
    if (!_libraryTextField) {
        _libraryTextField = [[DYLimitLengthTextField alloc] init];
        _libraryTextField.backgroundColor = [UIColor clearColor];
        _libraryTextField.delegate = self;
        _libraryTextField.layer.borderWidth = 0.7;
        _libraryTextField.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;
        _libraryTextField.placeholder = @" 请选择图书馆";
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = [UIImage imageNamed:@"tushuguan"];
        leftIcon.width = 30;
        leftIcon.height = 40;
        leftIcon.contentMode = UIViewContentModeCenter;
        _libraryTextField.leftView = leftIcon;
        _libraryTextField.leftViewMode = UITextFieldViewModeAlways;
        _libraryTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _libraryTextField.font = [UIFont systemFontOfSize:17];
        _libraryTextField.borderStyle = UITextBorderStyleNone;
        _libraryTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_libraryTextField becomeFirstResponder];
        _libraryTextField.limitLength = 20;
        _libraryTextField.layer.cornerRadius = 5;
        _libraryTextField.hidden = YES;
//        [_libraryTextField addTarget:self action:@selector(confirmTextFieldClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _libraryTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = RGB(38, 203, 100, 1.0);
        _loginButton.layer.cornerRadius = 5;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
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

- (UIImageView *)HeaderImageView
{
    if (!_HeaderImageView) {
        _HeaderImageView = [[UIImageView alloc] init];
        _HeaderImageView.image = [UIImage imageNamed:@"图书占位2"];
        _HeaderImageView.layer.borderWidth = 0.7;
        _HeaderImageView.layer.borderColor = RGB(224, 224, 224, 1.0).CGColor;

    }
    return _HeaderImageView;
}

- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.backgroundColor = [UIColor clearColor];
        [_forgetButton setTitle:@"忘记密码了?" forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _forgetButton.titleLabel.font = Font(14);
        [_forgetButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _forgetButton.titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _forgetButton;
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
