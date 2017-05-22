//
//  QYFeedbackTextView.m
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import "QYFeedbackTextView.h"

@implementation QYFeedbackTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark - 获取占位符内容
-(void)setPlaceholder:(NSString *)placeholder{
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        [self.placeHolderLabel removeFromSuperview];
        self.placeHolderLabel = nil;
        //走划线方法drawRect
        [self setNeedsDisplay];
    }
    
}
#pragma mark - 当输入框文字发生改变的时候
- (void)textChanged:(NSNotification *)notification{
    if ([[self placeholder] length] == 0) {
        return;
    }
    if ([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
    else{
        [[self viewWithTag:999] setAlpha:0];
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - 重画view中的子类
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([self.placeholder length] > 0) {
        if (_placeHolderLabel == nil) {
            _placeHolderLabel = [[UILabel alloc] init];
//            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = Font(14);;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = [UIColor lightGrayColor];
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] >0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }

}

@end
