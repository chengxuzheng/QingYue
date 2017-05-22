//
//  YCRequestDataService.m
//  DayoSoft_O2O
//
//  Created by Lei_Zhong_Xun on 15/11/25.
//  Copyright © 2016年 Lei_Zhong_Xun. All rights reserved.
//

#import "YCRequestDataService.h"
#import <AFNetworking.h>

@implementation YCRequestDataService


+ (instancetype)sharedManager {
    static YCRequestDataService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YCRequestDataService alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestAPI = IntranetAPI;
        [self database];
    }
    return self;
}

#pragma mark - 加载视图

- (void)showHUD:(UIViewController *)vc withTitle:(NSString *)title {
    _HUD = [[MBProgressHUD alloc] initWithView:vc.view];
    [vc.view bringSubviewToFront:_HUD];
    [vc.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = title;
    [_HUD show:YES];
}

- (void)hideHUD {
    [_HUD hide:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    [hud removeFromSuperview];
    hud = nil;
}


- (void)showAnimatedHUD:(UIViewController *)vc withTitle:(NSString *)title {
    _HUD = [[MBProgressHUD alloc] initWithView:vc.view];
    [vc.view bringSubviewToFront:_HUD];
    [vc.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = title;
    _HUD.mode = MBProgressHUDModeAnnularDeterminate;
    _HUD.animationType = MBProgressHUDAnimationZoom;
    [_HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress <= 1.f) {
            progress += 0.1f;
            _HUD.progress = progress;
            usleep(50000);
        }
    } completionBlock:^{
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
}

#pragma mark - 设置HostApi
- (void)setRequestHostTypeStyle:(RequestHostTypeStyle)requestHostTypeStyle {
    _requestHostTypeStyle = requestHostTypeStyle;
    switch (_requestHostTypeStyle) {
        case RequestHostTypeStyleIntranet:
            _requestAPI = IntranetAPI;
            break;
        default:
            break;
    }
}

#pragma mark - 当前网络类型
- (void)currentNetState:(NetStateBlock)state {
    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    __weak YCRequestDataService *weakSelf = self;
    [weakSelf.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _netState = @"WWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _netState = @"WiFi";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _netState = @"NotReachable";
                break;
            default:
                break;
        }
        state(_netState);
    }];
    [self.reachabilityManager startMonitoring];
}

#pragma mark - Get请求
- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response {
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    
//    __block NSString *urlStr = @"";
//    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
//    }];
//    
//    NSLog(@"========网络请求参数:%@",dic);
//    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager GET:fApi parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)Get:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure{
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager GET:fApi parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure();
    }];
}

- (void)Get:(NSString *)api parameters:(NSDictionary *)dic withTableName:(NSString *)name success:(ResponseBlock)response  {
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *public_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"public_token"];
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [_paramDic setValue:access_token forKey:@"access_token"];
    [_paramDic setValue:public_token forKey:@"public_token"];
    
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [self currentNetState:^(NSString *state) {
        if (![state isEqualToString:@"NotReachable"]) {
            [manager GET:fApi parameters:_paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                NSDictionary *response_data = [responseObject objectForKey:@"response_data"];
                [self openDatabaseWithTableName:name];
                [self cacheData:response_data];
                [self closeDatabase];
                response(response_data);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self openDatabaseWithTableName:name];
                NSDictionary *response_data = [self accessCacheData];
                [self closeDatabase];
                response(response_data);
            }];
        } else {
            if ([self isTableOK:name]) {
                NSLog(@"表存在");
                [self openDatabaseWithTableName:name];
                NSDictionary *response_data = [self accessCacheData];
                [self closeDatabase];
                response(response_data);
            } else {
                //TODO:没表怎么办.
                NSLog(@"不存在");
            }
        }
    }];
}

#pragma mark - Post请求
- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response {
    NSString *public_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"public_token"];
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [_paramDic setValue:public_token forKey:@"public_token"];
    [_paramDic setValue:_access_token forKey:@"access_token"];

    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    
    
//    __block NSString *urlStr = @"";
//    [_paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
//    }];
//    
//    NSLog(@"========网络请求参数:%@",_paramDic);
//    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:fApi parameters:_paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)Post:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *public_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"public_token"];
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [_paramDic setValue:public_token forKey:@"public_token"];
    [_paramDic setValue:_access_token forKey:@"access_token"];
    
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    
    
//    __block NSString *urlStr = @"";
//    [_paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
//    }];
//    
//    NSLog(@"========网络请求参数:%@",_paramDic);
//    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:fApi parameters:_paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure();
    }];
}

#pragma mark 即时通讯
- (void)PostWithIM:(NSString *)api parameters:(NSDictionary *)dic success:(ResponseBlock)response failure:(FailureBlock)failure{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //NSString *public_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"public_token"];
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //[_paramDic setValue:public_token forKey:@"public_token"];
    [_paramDic setValue:_access_token forKey:@"access_token"];
    
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",@"http://im.api.yuncangmall.com/rest/2.0/im/user",api];
    
    
//    __block NSString *urlStr = @"";
//    [_paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
//    }];
//    
//    NSLog(@"========网络请求参数:%@",_paramDic);
//    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager POST:fApi parameters:_paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure();
    }];
}

- (void)Post:(NSString *)api parameters:(NSDictionary *)dic withTableName:(NSString *)name success:(ResponseBlock)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *public_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"public_token"];
    
//    NSLog(@"%@, %@", access_token, public_token);
    _paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [_paramDic setValue:public_token forKey:@"public_token"];
    [_paramDic setValue:_access_token forKey:@"access_token"];
    
    NSMutableString *fApi = [NSMutableString stringWithFormat:@"%@%@?",_requestAPI,api];
    
//    __block NSString *urlStr = @"";
//    [_paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
//    }];
//    
//    NSLog(@"========网络请求参数:%@",_paramDic);
//    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [self currentNetState:^(NSString *state) {
        if (![state isEqualToString:@"NotReachable"]) {
            [manager POST:fApi parameters:_paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                id response_data = [responseObject objectForKey:@"response_data"];
                [self openDatabaseWithTableName:name];
                [self cacheData:response_data];
                [self closeDatabase];
                response(response_data);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",error);
                if ([self isTableOK:name]) {
                    [self openDatabaseWithTableName:name];
                    id response_data = [self accessCacheData];
                    [self closeDatabase];
                    response(response_data);
                }
            }];
        } else {
            if ([self isTableOK:name]) {
                NSLog(@"%@表存在",name);
                [self openDatabaseWithTableName:name];
                id response_data = [self accessCacheData];
                response(response_data);
                [self closeDatabase];
            } else {
                //TODO:没表怎么办.
                NSLog(@"%@不存在",name);
            }
        }
    }];
}

- (void)cacheDataWithName:(NSString *)name withData:(id)data {
    [self openDatabaseWithTableName:name];
    [self cacheData:data];
    [self closeDatabase];
}

- (id)accessCacheDataWithName:(NSString *)name {
    id data;
    if ([self isTableOK:name]) {
        [self openDatabaseWithTableName:name];
        data = [self accessCacheData];
        [self closeDatabase];
    }
    return data;
}

#pragma mark - 时间戳转时间
/**
 * 年月日时分秒
 */
- (NSString *)timeintervalFormatYMDHMS:(NSNumber *)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd  hh:mm"];
    return [format stringFromDate:date];
}


/*----------------------本地数据缓存--------------------------*/
/**
 * 数据库文件路径
 */
- (NSString *)databasePath {
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Cache.sqlite"];
}

/**
 * 创建数据库文件
 */
- (void)database {
    _db = [FMDatabase databaseWithPath:[self databasePath]];
}

/**
 * 打开数据库
 * 获取表名
 */
- (void)openDatabaseWithTableName:(NSString *)name {
    _tableName = name;
    [_db open];
}

/**
 * 关闭数据库
 */
- (void)closeDatabase {
    [_db close];
}

/**
 * 删除旧数据
 * 缓存新数据
 * data类型为数组或字典
 */
- (void)cacheData:(id)data {

    if ([self isTableOK:_tableName]) {
        [_db open];
        NSString *dropSqlStr = [NSString stringWithFormat:@"DROP TABLE %@",_tableName];
        [_db executeUpdate:dropSqlStr];
        [_db close];
    }
    
    if (data) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, jsonData text NOT NULL);",_tableName];
        [_db open];
        [_db executeUpdate:sqlStr];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *path = [NSString stringWithFormat:@"INSERT INTO %@ (jsonData) VALUES (?);",_tableName];
        [_db executeUpdate:path,dataStr];

    }
}

/**
 * 返回的数据类型(数据,字典)
 */
- (id)returnData {
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT jsonData FROM %@",_tableName];
    FMResultSet *set = [_db executeQuery:sqlStr];
    while ([set next]) {
        NSString *dataStr  = [set stringForColumn:@"jsonData"];
        return [dataStr objectFromJSONString];
    }
    return nil;
}

/**
 * 访问缓存数据
 */
- (id)accessCacheData {
    if ([[[self returnData] class] isSubclassOfClass:[NSArray class]]) {
        return (NSArray *)[self returnData];
    }
    if ([[[self returnData] class] isSubclassOfClass:[NSDictionary class]]) {
        return (NSDictionary *)[self returnData];
    }
    return nil;
}


/**
 * 判断表是否存在
 */
- (BOOL)isTableOK:(NSString *)tableName {
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count == 0) {
            [_db close];
            return NO;
        } else {
            [_db close];
            return YES;
        }
    }
    [_db close];
    return NO;
}



@end
