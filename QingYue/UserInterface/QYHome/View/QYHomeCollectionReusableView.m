//
//  QYHomeCollectionReusableView.m
//  QingYue
//
//  Created by 崔明燃 on 2017/3/28.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHomeCollectionReusableView.h"

@implementation QYHomeCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLbl];
        [self addSubview:self.moreButton];
    }
    return self;
}



- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = Font(15);
//        _titleLbl.backgroundColor = [UIColor orangeColor];
        
    }
    return _titleLbl;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"查看更多 >" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = Font(12);
        [_moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        _moreButton.backgroundColor = [UIColor redColor];
    }
    
    return _moreButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@160);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@80);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
