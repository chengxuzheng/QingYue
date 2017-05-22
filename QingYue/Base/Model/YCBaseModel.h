//
//  YCBaseModel.h
//  YCIphone
//
//  Created by ChengxuZheng on 15/10/21.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCBaseModel : NSObject

- (id)initWithDataDic:(NSDictionary *)data;
- (NSDictionary *)attributeMapDictionary;
- (void)setAttributes:(NSDictionary *)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData *)getArchivedData;

- (NSString *)cleanString:(NSString *)str; //清除\n和\r的字符串

@end
