//
//  YCRequestDataService.h
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 15/11/25.
//  Copyright © 2015年 Lei_Zhong_Xun. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *IntranetAPI = @"http://192.168.11.248:8889/dayoshop/";  // 内网

typedef enum : NSUInteger {
    RequestHostTypeStyleOfficial,
    RequestHostTypeStyleIntranet,
    RequestHostTypeStyleqingHangAPI
} RequestHostTypeStyle;

typedef void(^ResponseBlock)(id response);
typedef void(^FailureBlock)();
typedef void(^NetStateBlock)(NSString *state);

@interface YCRequestDataService : AFHTTPSessionManager <MBProgressHUDDelegate> {
    FMDatabase *_db;        //数据库
    NSString *_tableName;   //表名
    MBProgressHUD *_HUD;
    NSString *_requestAPI;
}

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *netState;
@property (nonatomic, strong) NSMutableDictionary *paramDic;
@property (nonatomic, assign) RequestHostTypeStyle requestHostTypeStyle;

/**
 * manager管理请求
 */
+ (instancetype)sharedManager;

/**
 * 网络判断
 */
- (void)currentNetState:(NetStateBlock)state;

/**
 * GET请求
 */
- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response;

- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure;

- (void)Get:(NSString *)api parameters:(NSDictionary *)dic withTableName:(NSString *)name success:(ResponseBlock)response;

/**
 * POST请求
 */
- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response;

- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure;

- (void)Post:(NSString *)api parameters:(NSDictionary *)dic withTableName:(NSString *)name success:(ResponseBlock)response;

#pragma mark 即时通讯请求
- (void)PostWithIM:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure;


/**
 * 进度
 */
- (void)showHUD:(UIViewController *)vc withTitle:(NSString *)title;

- (void)hideHUD;

- (void)showAnimatedHUD:(UIViewController *)vc withTitle:(NSString *)title;

/**
 * 时间戳转时间 - 年月日时分秒
 */
- (NSString *)timeintervalFormatYMDHMS:(NSNumber *)interval;

/**
 * 缓存JSON数据的数据库管家
 * 依赖库如下:
 * 系统类库 sqlite3
 * 第三方类库 FMDB,JSONKit
 */

/**
 * 使用方法
 * 初始化manager
 * 打开数据库
 * 缓存数据/访问缓存数据(数据类型:数据,字典)
 * 关闭数据库
 */

- (void)cacheDataWithName:(NSString *)name withData:(id)data;
- (id)accessCacheDataWithName:(NSString *)name;
- (void)openDatabaseWithTableName:(NSString *)name;
- (void)closeDatabase;
- (void)cacheData:(id)data;
- (id)accessCacheData;
- (BOOL)isTableOK:(NSString *)tableName;

@end
