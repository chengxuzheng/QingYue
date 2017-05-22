//
//  QYFeedbackTextView.h
//  QingYue
//
//  Created by leilei on 2017/4/3.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYFeedbackTextView : UITextView
//占位label
@property (nonatomic, strong) UILabel * placeHolderLabel;
//占位符
@property (nonatomic, copy) NSString * placeholder;
//占位符颜色
@property (nonatomic, strong) UIColor * placeholderColor;
//当输入的时候
- (void)textChanged:(NSNotification * )notification;
@end
