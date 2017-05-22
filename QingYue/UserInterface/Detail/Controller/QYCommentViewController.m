//
//  QYCommentViewController.m
//  QingYue
//
//  Created by 崔明燃 on 2017/4/7.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYCommentViewController.h"

@interface QYCommentViewController ()

@property (strong, nonatomic) UIView *greenLineView; // 绿条
@property (strong, nonatomic) UILabel *titleLabel1;  // 评语
@property (strong, nonatomic) UITextView *commentTextView;   // 评论输入框
@property (strong, nonatomic) UIView *greenlineView2 ; // 第二个绿条
@property (strong, nonatomic) UILabel *titleLable2;  // 评分

@end

@implementation QYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.greenLineView];
    [self.view addSubview:self.titleLabel1];
    [self.view addSubview:self.commentTextView];
    [self.view addSubview:self.greenlineView2];
    [self.view addSubview:self.titleLable2];
    
    [self layoutSubviews];
    
}

#pragma mark - layout subviews
- (void)layoutSubviews {
    [_greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(@5);
        make.height.equalTo(@15);
    }];
    
    [_titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(16);
        make.left.equalTo(_greenLineView.mas_right).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel1.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@180);
    }];
    
    [_greenlineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentTextView.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(@5);
        make.height.equalTo(@16);
    }];
    
    [_titleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentTextView.mas_bottom).offset(16);
        make.left.equalTo(_greenlineView2.mas_left).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    
}

#pragma mark - lazy load 
- (UIView *)greenLineView {
    if (!_greenLineView) {
        _greenLineView = [[UIView alloc] init];
        _greenLineView.backgroundColor = MyGreenColor;
    }
    
    return _greenLineView;
}

- (UILabel *)titleLabel1 {
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc] init];
        _titleLabel1.font = Font(15);
        _titleLabel1.text = @"评语";
        
    }
    
    return _titleLabel1;
}

- (UITextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[UITextView alloc] init];
        _commentTextView.font = Font(15);
        _commentTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _commentTextView.layer.borderWidth = .5f;
    }
    
    return _commentTextView;
}

- (UIView *)greenlineView2 {
    if (!_greenlineView2) {
        _greenlineView2 = [[UILabel alloc] init];
        _greenlineView2.backgroundColor = MyGreenColor;
    }
    
    return _greenlineView2;
}

- (UILabel *)titleLable2 {
    if (!_titleLable2) {
        _titleLable2 = [[UILabel alloc] init];
        _titleLable2.font = Font(15);
        _titleLable2.text = @"评分";
    }
    
    return _titleLable2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
