//
//  QYFeedbackViewController.m
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYFeedbackViewController.h"
#import "QYFeedbackTextView.h"

@interface QYFeedbackViewController ()<UITextViewDelegate>
//反馈输入框
@property (nonatomic, strong) QYFeedbackTextView * textView;
/** 完成按钮*/
@property (nonatomic, strong) UIButton *completeButton;
/** 提示框*/
@property (nonatomic, strong) UILabel *messageLabel;
/** 小绿点*/
@property (nonatomic, strong) UILabel *greenLabel;
/** 自定义保存弹窗*/
@property (nonatomic,strong) DYSaveShotView* ensureShotView;
/** 自定义保存弹窗遮罩层 */
@property (nonatomic,strong) GKCover* saveShopCover;

@end

@implementation QYFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"信息反馈";
    [self.view addSubview:self.textView];
    [self.view addSubview:self.completeButton];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.greenLabel];
}

#pragma mark - 按钮实现方法
- (void)completeButtonAction
{
    [_textView resignFirstResponder];
    if ([_textView.text length] == 0) {
        //输入错误
        _messageLabel.hidden = NO;
        _greenLabel.hidden = NO;
    } else {
        _messageLabel.hidden = YES;
        _greenLabel.hidden = YES;
        //输入正确
        GKCover *cover = [GKCover translucentCoverWithTarget:self action:nil];
        cover.alpha = 0.3;
        cover.frame = [UIScreen mainScreen].bounds;
        [self.view.window addSubview:cover];
        self.saveShopCover = cover;
        self.ensureShotView.frame = CGRectMake(30, MSSize_Height / 2 - 150, MSSize_Width - 60, 160);
        [self.view.window addSubview:self.ensureShotView];
        _ensureShotView.contentLabel.text = @"反馈成功";
    }
}
/**
 *  隐藏保存按钮提示框
 */
- (void)hiddenSaveShotViewClick
{
    [_saveShopCover removeFromSuperview];
    [_ensureShotView removeFromSuperview];
}

#pragma mark - 点击空白处取消编辑状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}
#pragma mark - 布局
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.height.equalTo(@(160));

    }];
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(- 15);
        make.height.equalTo(@(50));
        make.top.equalTo(_textView.mas_bottom).offset(45);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textView.mas_bottom).offset(15);
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
-(QYFeedbackTextView *)textView{
    
    if (!_textView) {
        _textView = [[QYFeedbackTextView alloc] init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = [UIColor lightGrayColor];
        _textView.placeholder = @"请输入要反馈的内容";
    }
    return _textView;
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
        _messageLabel.text = @"无法提交空评论";
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

- (DYSaveShotView *)ensureShotView
{
    if (!_ensureShotView) {
        _ensureShotView = [[DYSaveShotView alloc] init];
        _ensureShotView.layer.cornerRadius = 11.f;
        [_ensureShotView.sureButton addTarget:self action:@selector(hiddenSaveShotViewClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ensureShotView;
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
