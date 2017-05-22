//
//  QYBaseRecordView.m
//  QingYue
//
//  Created by leilei on 2017/4/9.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBaseRecordView.h"

@implementation QYBaseRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.bookNameLabel];
        [self addSubview:self.bookStateLabel];
        [self addSubview:self.grayBGView];
        [self.grayBGView addSubview:self.firstTitleLabel];
        [self.grayBGView addSubview:self.secondTitleLabel];
        [self.grayBGView addSubview:self.thirdTitleLabel];
        [self.grayBGView addSubview:self.firstContentLabel];
        [self.grayBGView addSubview:self.secondContentLabel];
        [self.grayBGView addSubview:self.thirdContentLabel];
        [self.grayBGView addSubview:self.grayView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    [_bookStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bookNameLabel.mas_right).offset(10);
        make.width.equalTo(@50);
        make.bottom.equalTo(_bookNameLabel.mas_bottom);
        make.height.equalTo(@15);
    }];
    
    [_grayBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(30);
    }];
    
    [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_grayBGView.mas_top).offset(1);
        make.height.equalTo(@35);
        make.left.equalTo(_grayBGView.mas_left).offset(1);
        make.width.equalTo(@110);
    }];
    
    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.left.equalTo(_firstTitleLabel.mas_right);
        make.top.equalTo(_grayBGView.mas_top);
        make.bottom.equalTo(_grayBGView.mas_bottom);
    }];
    
    [_firstContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_grayView.mas_right);
        make.right.equalTo(_grayBGView.mas_right);
    }];
}

#pragma mark - lazy load
- (UILabel *)bookNameLabel
{
    if (!_bookNameLabel) {
        _bookNameLabel = [[UILabel alloc] init];
        _bookNameLabel.font = Font(16);
        _bookNameLabel.text = @"<红楼梦>";
        _bookNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        CGSize maximumLabelSize = CGSizeMake(100, 9999);
        //关键语句
        CGSize expectSize = [_bookNameLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        _bookNameLabel.frame = CGRectMake(0, 0, expectSize.width, expectSize.height);
    }
    return _bookNameLabel;
}
- (UILabel *)bookStateLabel
{
    if (!_bookStateLabel) {
        _bookStateLabel = [[UILabel alloc] init];
        _bookStateLabel.font = Font(12);
        _bookStateLabel.text = @"已上架";
    }
    return _bookNameLabel;
}
- (UIView *)grayBGView
{
    if (!_grayBGView) {
        _grayBGView = [[UIView alloc] init];
        _grayBGView.backgroundColor = [UIColor whiteColor];
        _grayBGView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _grayBGView.layer.borderWidth = 0.7;
    }
    return _grayBGView;
}
- (UILabel *)firstTitleLabel
{
    if (!_firstTitleLabel) {
        _firstTitleLabel = [[UILabel alloc] init];
        _firstTitleLabel.font = Font(14);
        _firstTitleLabel.text = @"条形码";
    }
    return _firstTitleLabel;
}
- (UILabel *)secondTitleLabel
{
    if (!_secondTitleLabel) {
        _secondTitleLabel = [[UILabel alloc] init];
        _secondTitleLabel.font = Font(14);
        _secondTitleLabel.text = @"荐购日期";
    }
    return _secondTitleLabel;
}
- (UILabel *)thirdTitleLabel
{
    if (!_thirdTitleLabel) {
        _thirdTitleLabel = [[UILabel alloc] init];
        _thirdTitleLabel.font = Font(14);
        _thirdTitleLabel.text = @"购买日期";
    }
    return _thirdTitleLabel;
}
- (UILabel *)firstContentLabel
{
    if (!_firstContentLabel) {
        _firstContentLabel = [[UILabel alloc] init];
        _firstContentLabel.font = Font(14);
        _firstContentLabel.text = @"条形码";
    }
    return _firstContentLabel;
}
- (UILabel *)secondContentLabel
{
    if (!_secondContentLabel) {
        _secondContentLabel = [[UILabel alloc] init];
        _secondContentLabel.font = Font(14);
        _secondContentLabel.text = @"荐购日期";
    }
    return _secondContentLabel;
}
- (UILabel *)thirdContentLabel
{
    if (!_thirdContentLabel) {
        _thirdContentLabel = [[UILabel alloc] init];
        _thirdContentLabel.font = Font(14);
        _thirdContentLabel.text = @"购买日期";
    }
    return _thirdContentLabel;
}
- (UIView *)grayView
{
    if (!_grayView) {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayView;
}

@end
