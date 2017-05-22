//
//  QYBookShelfCollecionHeaderReusableView.m
//  QingYue
//
//  Created by Lei_Zhong_Xun on 2017/3/31.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookShelfCollecionHeaderReusableView.h"

@implementation QYBookShelfCollecionHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.searchTextField];
        [self addSubview:self.searchButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
        make.right.equalTo(self.mas_right).offset(- 60);
    }];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
        make.left.equalTo(_searchTextField.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(- 5);
    }];
}

#pragma mark - lazy load
- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = RGB(237, 238, 239, 1.0);
        _searchTextField.font = [UIFont systemFontOfSize:15];
        _searchTextField.placeholder = @"请输入搜索的图书";
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        // 设置左边的放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"bookShelfSearch"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        _searchTextField.leftView = searchIcon;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchTextField;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.titleLabel.font = Font(15);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:UIColorFromRGB(0x22cb64) forState:UIControlStateNormal];
    }
    return _searchButton;
}

@end
