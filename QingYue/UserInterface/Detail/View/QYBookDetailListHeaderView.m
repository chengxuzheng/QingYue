//
//  QYBookDetailListHeaderView.m
//  QingYue
//
//  Created by 崔明燃 on 2017/3/29.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYBookDetailListHeaderView.h"

@implementation QYBookDetailListHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.thumbView];
        [self addSubview:self.titleLable];
        [self addSubview:self.infoLabel];
        [self subViewsLayouts];
    }
    return self;
}

#pragma mark - layout subview
- (void)subViewsLayouts {
    [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.equalTo(@140);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(50);
        make.left.equalTo(_thumbView.mas_right).offset(15);
        make.height.equalTo(@30);
        make.right.equalTo(self.mas_right).offset(- 10);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(5);
        make.left.equalTo(_thumbView.mas_right).offset(15);
        make.height.equalTo(@40);
        make.right.equalTo(self.mas_right).offset(- 10);
    }];
}

#pragma mark - lazy load
- (UIImageView *)thumbView {
    if (!_thumbView) {
        _thumbView = [[UIImageView alloc] init];
        _thumbView.backgroundColor = [UIColor orangeColor];
        [_thumbView setImage:[UIImage imageNamed:@"图书占位2"]];
    }
    
    return _thumbView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = Font(16);
        _titleLable.text = @"我们内心的冲突";
//        _titleLable.backgroundColor = [UIColor redColor];
    }
    
    return _titleLable;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        NSString * cLabelString =@"作者：【美】卡伦.霍尼 \n 出版：长江文艺出版社";
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
        [_infoLabel setAttributedText:attributedString1];
        [_infoLabel sizeToFit];
        _infoLabel.textColor = [UIColor lightGrayColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = Font(13);
//        _infoLabel.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _infoLabel;
}

@end
