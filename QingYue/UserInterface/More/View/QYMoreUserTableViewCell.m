//
//  QYMoreUserTableViewCell.m
//  QingYue
//
//  Created by leilei on 2017/3/28.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreUserTableViewCell.h"

@implementation QYMoreUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.arrowImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(70));
        make.left.equalTo(self.mas_left).offset(15);
        make.width.equalTo(@(70));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(20));
        make.left.equalTo(_headerImageView.mas_right).offset(15);
        make.width.equalTo(@(100));
    }];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(8));
        make.left.equalTo(_nameLabel.mas_right).offset(5);
        make.width.equalTo(@(8));

    }];
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"默认用户头像"];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font(14);
        _nameLabel.text = @"会飞的小猪猪";
    }
    return _nameLabel;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"go"];
    }
    return _arrowImageView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
