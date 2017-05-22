//
//  DYLimitLengthTextField.h
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 17/3/15.
//  Copyright © 2017年 Lei_Zhong_Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYLimitLengthTextField : UITextField

@property (nonatomic, assign) NSInteger limitLength;

- (void)limitLength:(NSInteger)length;
@end
