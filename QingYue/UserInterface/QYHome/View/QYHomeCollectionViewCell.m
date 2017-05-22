//
//  QYHomeCollectionViewCell.m
//  QingYue
//
//  Created by 崔明燃 on 2017/3/27.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYHomeCollectionViewCell.h"

@implementation QYHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.thumbImgView.frame = (CGRect){0, 0, self.contentView.width, self.contentView.bottom - 20};
        [self.contentView addSubview:self.thumbImgView];
        self.titileLabel.frame = (CGRect){0, self.contentView.bottom - 20, self.contentView.width, 20};
        [self.contentView addSubview:self.titileLabel];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

#pragma mark - lazy loading

- (UIImageView *)thumbImgView {
    if (!_thumbImgView) {
        _thumbImgView = [[UIImageView alloc] init];
        [_thumbImgView setImage:[UIImage imageNamed:@"图书占位2"]];
    }
    
    return _thumbImgView;
}

- (UILabel *)titileLabel {
    if (!_titileLabel) {
        _titileLabel = [[UILabel alloc] init];
        _titileLabel.font = Font(12);
        _titileLabel.numberOfLines = 0;
        _titileLabel.textAlignment = NSTextAlignmentCenter;
        _titileLabel.text = @"我们内心的冲突";
    }
    
    return _titileLabel;
}

@end
