//
//  TestingTool.m
//  YCIphone
//
//  Created by ChengxuZheng on 15/10/23.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import "TestingTool.h"

@implementation TestingTool

+ (BOOL)isPhoneNumbers:(NSString *)str {
    BOOL isPhoneNumber = YES;
    if (str.length == 11) {
        for (int i = 0; i < 11; i++) {
            if (!(([str characterAtIndex:i]<='9')&&([str characterAtIndex:i]>='0'))) {
                return NO;
            }
        }
        if (isPhoneNumber) {
            return YES;
        }
    }
    return NO;
}


+ (BOOL)isPassword:(NSString *)str {
    return YES;
}


@end
