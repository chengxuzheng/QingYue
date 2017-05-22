
//
//  QYSearchView.m
//  QingYue
//
//  Created by Zheng on 2017/4/11.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYSearchView.h"

@implementation QYSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subviewsInView];
    }
    return self;
}

#pragma mark - subviews
- (void)subviewsInView {
    [self addSubview:self.searchImgv];
    [_searchImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(17);
    }];
    
    [self addSubview:self.searchTfx];
    [_searchTfx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchImgv.mas_right).offset(8);
        make.right.mas_equalTo(-10);
        make.height.centerY.equalTo(self);
    }];
}

- (UIImageView *)searchImgv {
    if (!_searchImgv) {
        _searchImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bookShelfSearch"]];
    }
    return _searchImgv;
}

- (UITextField *)searchTfx {
    if (!_searchTfx) {
        _searchTfx = [UITextField new];
        _searchTfx.font = Font(15);
        _searchTfx.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTfx.placeholder = @"请输入要搜索的图书";
    }
    return _searchTfx;
}


@end
