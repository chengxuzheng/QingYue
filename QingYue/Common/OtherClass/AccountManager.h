//
//  AccountManager.h
//  YCIphone
//
//  Created by ChengxuZheng on 15/10/27.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

/*
 单例模式
 账号管家
 负责存储需要的账号信息
 通过 NSUserDefaults和 NSCoder 存储
 */

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject <NSCoding>

@property (nonatomic, copy) NSString *phoneNumber;    //手机号
@property (nonatomic, copy) NSString *password;       //密码

/**
 * 初始化管家的方法
 */
+ (instancetype)sharedManager;










@end
