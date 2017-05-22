//
//  AccountManager.m
//  YCIphone
//
//  Created by ChengxuZheng on 15/10/27.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

/*
 单例 初始化方法
 */
+ (instancetype)sharedManager {
    static AccountManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AccountManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - NSCoding delegate mothod

/*
 保存数据
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (_phoneNumber) {
        [aCoder encodeObject:_phoneNumber forKey:@"phoneNumber"];
        [aCoder encodeObject:_password forKey:@"password"];
    }
}

/*
 读取数据
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
        _password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}


@end
