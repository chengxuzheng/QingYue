//
//  QYMoreButtonTableViewCell.m
//  QingYue
//
//  Created by leilei on 2017/3/28.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYMoreButtonTableViewCell.h"

@implementation QYMoreButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGB(230, 230, 230, 1.0);
        [self addSubview:self.attentionButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.recommentButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger buttonWidth = (MSSize_Width - 3) / 3;
    [_attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_attentionButton.mas_right).offset(1);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
    }];
    [_recommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentButton.mas_right).offset(1);
        make.width.equalTo(@(buttonWidth));
        make.height.equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);

    }];
}
- (UIButton *)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.backgroundColor = [UIColor whiteColor];
        [_attentionButton setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
    }
    return _attentionButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.backgroundColor = [UIColor whiteColor];
        [_commentButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];

    }
    return _commentButton;
}

- (UIButton *)recommentButton
{
    if (!_recommentButton) {
        _recommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recommentButton.backgroundColor = [UIColor whiteColor];
        [_recommentButton setImage:[UIImage imageNamed:@"tuijian"] forState:UIControlStateNormal];

    }
    return _recommentButton;
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
