//
//  NetRequest.h
//  Yuncang
//
//  Created by ChengxuZheng on 16/3/31.
//  Copyright © 2016年 ChengxuZheng. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetRequestHostTypeStyleDefault,
} NetRequestHostTypeStyle;

typedef void(^RequestErrorBlock)(NSError *error);
typedef void(^RequestSuccessBlock)(id response);
typedef void(^NetStateBlock)(NSString *statusCode);

@interface NetRequest : NSObject 

+ (instancetype)defaultNetRequest;

+ (void)PostWithRequestStyle:(NetRequestHostTypeStyle)style withAPI:(NSString *)api param:(id)param  success:(RequestSuccessBlock)response error:(RequestErrorBlock)failue;

+ (void)GetWithRequestStyle:(NetRequestHostTypeStyle)style withAPI:(NSString *)api param:(id)param success:(RequestSuccessBlock)response error:(RequestErrorBlock)failue;

+ (void)CurrentNetState:(NetStateBlock)netBlock;

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *publicToken;


@end
