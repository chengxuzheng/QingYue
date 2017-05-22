//
//  QYMoreAttentionButtonTableViewCell.m
//  QingYue
//
//  Created by leilei on 2017/4/8.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreAttentionButtonTableViewCell.h"

@implementation QYMoreAttentionButtonTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.cancelButton];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(- 20);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@20);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(_cancelButton.mas_left).offset(- 20);
        make.height.equalTo(@15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.height.equalTo(@15);
    }];
}
#pragma mark - lazy load
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = Font(14);
        _titleLabel.text = @"三生三世十里桃花";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = Font(12);
        _contentLabel.text = @"作者: 唐七(原笔名:唐七公子)";
    }
    return _contentLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitle:@"取消关注" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = Font(15);
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        _cancelButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    }
    return _cancelButton;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
