//
//  Request.m
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "QueryRequest.h"
#import "QueryRequestModel.h"

@implementation QueryRequest


+(NSString *)buildRequestJson : (NSString *)account
                      structId: (int)structId
{

    QueryRequestModel *model = [[QueryRequestModel alloc]init];
    model.structId = structId;
    
    NSMutableDictionary *dict = model.mj_keyValues;
    
    return dict.mj_JSONString;
}


+(NSString *)buildQueryInfo : (RequestType)type;
{
    
    QueryRequestModel *model = [[QueryRequestModel alloc]init];
    model.structId = type;
    model.strSessionID = [[Account sharedAccount]getSessionId];
    
    NSMutableDictionary *dic =[JSONUtil parseDic:model];
    NSString *result = [JSONUtil parse:@"queryData" params:dic];

    return result;
}

@end
