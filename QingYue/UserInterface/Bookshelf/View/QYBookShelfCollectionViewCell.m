//
//  QYBookShelfCollectionViewCell.m
//  QingYue
//
//  Created by Lei_Zhong_Xun on 2017/3/31.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookShelfCollectionViewCell.h"

@implementation QYBookShelfCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.height.equalTo(@(130));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentImageView.mas_bottom).offset(10);
        make.left.equalTo(_contentImageView.mas_left);
        make.right.equalTo(_contentImageView.mas_right);
        make.height.equalTo(@(30));
    }];
}

- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.image = [UIImage imageNamed:@"图书占位.jpg"];
    }
    return _contentImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"会讲故事的人";
        _titleLabel.font = Font(14);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
@end
