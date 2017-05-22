//
//  DYLimitLengthTextField.m
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 17/3/15.
//  Copyright © 2017年 Lei_Zhong_Xun. All rights reserved.
//

#import "DYLimitLengthTextField.h"

@implementation DYLimitLengthTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(textLengthDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)limitLength:(NSInteger)length
{
    _limitLength = length;
}
- (void)textLengthDidChange {
    if (self.text.length > _limitLength) {
        self.text = [self.text substringToIndex:_limitLength];
    }
}
@end
