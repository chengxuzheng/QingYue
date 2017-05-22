//
//  TestingTool.h
//  YCIphone
//
//  Created by ChengxuZheng on 15/10/23.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestingTool : NSObject

/**
 * 判断是否是由数字组成的11位号码
 */
+ (BOOL)isPhoneNumbers:(NSString *)str;

/**
 * 判断密码组成
 */
+ (BOOL)isPassword:(NSString *)str;


@end
