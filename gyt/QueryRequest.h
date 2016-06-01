//
//  Request.h
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryRequestModel.h"
#import "QueryRespondsModel.h"

@interface QueryRequest : NSObject


#pragma mark 组装基本json字符串
+(NSString *)buildRequestJson : (NSString *)account
                      structId: (int)structId;

#pragma mark 请求查询信息
+(NSString *)buildQueryInfo : (RequestType)type;

@end
