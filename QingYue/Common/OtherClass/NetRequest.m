//
//  NetRequest.m
//  Yuncang
//
//  Created by ChengxuZheng on 16/3/31.
//  Copyright © 2016年 ChengxuZheng. All rights reserved.
//



static NSString *lyqHost = @"https://www.andiff.wang/";

#import "NetRequest.h"

@implementation NetRequest

+ (instancetype)defaultNetRequest {
    static NetRequest *request = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        request = [[NetRequest alloc] init];
    });
    return request;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (void)PostWithRequestStyle:(NetRequestHostTypeStyle)style withAPI:(NSString *)api param:(id)param success:(RequestSuccessBlock)response error:(RequestErrorBlock)failue {
    
    __block NSMutableDictionary *paramDic;
    __block NSString *fApi;
    
    [NetRequest ShowNetWorking];
    
    paramDic = [NSMutableDictionary dictionaryWithDictionary:[NetRequest SettingParamWithParam:param]];
    
    fApi = [NetRequest GetFullAPIWithNetStyle:style withAPI:api];
    
    [NetRequest StartRequestWithFullAPI:fApi withParam:paramDic withSuccess:response withError:failue];
}

+ (void)StartRequestWithFullAPI:(NSString *)fApi withParam:(NSMutableDictionary *)paramDic withSuccess:(RequestSuccessBlock)response withError:(RequestErrorBlock)failue {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];

    
    __block NSString *urlStr = @"";
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
    }];

    NSLog(@"========网络请求参数:%@",paramDic);
    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    [manager POST:fApi parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetRequest hideNetWorking];
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [NetRequest hideNetWorking];
        failue(error);
    }];
}

+ (NSString *)SettingHostWithHostStyle:(NetRequestHostTypeStyle)style {
    return lyqHost;
}

+ (NSMutableDictionary *)SettingParamWithParam:(id)param {
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [paramDic setValue:access_token forKey:@"access_token"];
    return paramDic;
}

+ (NSString *)GetFullAPIWithNetStyle:(NetRequestHostTypeStyle)style withAPI:(NSString *)api {
    NSString *host = [NetRequest SettingHostWithHostStyle:style];
    NSMutableString *fullAPI = [NSMutableString stringWithFormat:@"%@%@?",host,api];
    return fullAPI;
}

+ (void)CurrentNetState:(NetStateBlock)netBlock {
    
   [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    __block NSString *netStatus;
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netStatus = @"WWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netStatus = @"WIFI";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netStatus = @"NotReachable";
                break;
            default:
                break;
        }
        netBlock(netStatus);
    }];
    
    [reachabilityManager startMonitoring];
}

+ (void)ShowNetWorking {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)hideNetWorking {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//GET请求
+ (void)GetWithRequestStyle:(NetRequestHostTypeStyle)style withAPI:(NSString *)api param:(id)param success:(RequestSuccessBlock)response error:(RequestErrorBlock)failue {
    
    __block NSMutableDictionary *paramDic;
    __block NSString *fApi;
    
    [NetRequest ShowNetWorking];
    
    paramDic = [NSMutableDictionary dictionaryWithDictionary:[NetRequest SettingParamWithParam:param]];
    
    fApi = [NetRequest GetFullAPIWithNetStyle:style withAPI:api];
    
    [NetRequest StartGETRequestWithFullAPI:fApi withParam:paramDic withSuccess:response withError:failue];
    
}

+ (void)StartGETRequestWithFullAPI:(NSString *)fApi withParam:(NSMutableDictionary *)paramDic withSuccess:(RequestSuccessBlock)response withError:(RequestErrorBlock)failue {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    __block NSString *urlStr = @"";
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
    }];
    
    NSLog(@"========网络请求参数:%@",paramDic);
    NSLog(@"========网络请求地址:%@%@",fApi,urlStr);
    
    [manager GET:fApi parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetRequest hideNetWorking];
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [NetRequest hideNetWorking];
        failue(error);
    }];
    
}





@end
