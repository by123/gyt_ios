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


+(void)requestQueryInfo  : (UIView *)view
             requestType : (RequestType)type
                 success : (SuccessCallback)success
                    fail : (FailCallback)fail
{
    
    QueryRequestModel *model = [[QueryRequestModel alloc]init];
    model.structId = type;
    model.strSessionID = [[Account sharedAccount]getSessionId];
    
    NSMutableDictionary *dic =[JSONUtil parseDic:model];
    NSString *result = [JSONUtil parse:@"queryData" params:dic];

    NSLog(@"%@",result);

    [[HttpRequest sharedHttpRequest]post:result view:view success:^(id responseObject) {
        NSLog(@"返回->%@",responseObject);
        success(responseObject);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

@end
