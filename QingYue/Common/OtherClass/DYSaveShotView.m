//
//  DYSaveShotView.m
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 17/2/28.
//  Copyright © 2017年 Lei_Zhong_Xun. All rights reserved.
//

#import "DYSaveShotView.h"


@implementation DYSaveShotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.greenView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.dividerView];
        [self addSubview:self.sureButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 5.5);
        make.left.equalTo(self.mas_left).offset(5.5);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(5));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_greenView.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(20));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(18);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@10);
    }];
    
    [_dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(- 50);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@1);
        
    }];
    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dividerView.mas_bottom).offset(7.5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@35);
    }];

}

#pragma mark - lazy loading
-(UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitleColor:RGB(38, 203, 100, 1.0) forState:UIControlStateNormal];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius = 5.f;
        [_sureButton setBackgroundColor:[UIColor whiteColor]];
        _sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    
    return _sureButton;
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = Font(14);
    }
    
    return _contentLabel;
}

-(UIView *)dividerView {
    if (!_dividerView) {
        _dividerView = [[UIView alloc]init];
        _dividerView.backgroundColor = RGB(232, 232, 232, 1);
    }
    return _dividerView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"提示";
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLabel;
}
- (UIView *)greenView
{
    if (!_greenView) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = RGB(38, 203, 100, 1.0);
    }
    return _greenView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
