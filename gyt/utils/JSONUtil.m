//
//  JSONUtil.m
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "JSONUtil.h"

@implementation JSONUtil


+(NSString *)parse : (NSString *)name
        params: (NSMutableDictionary *)params
{    
    BaseRequestModel *model = [[BaseRequestModel alloc]init];
    model.rpcname = name;
    model.rpcparams = params;
    
    NSMutableDictionary *dict = model.mj_keyValues;
    
    NSLog(@"--------------------发送请求数据--------------------\n%@",dict.mj_JSONString);
    return dict.mj_JSONString;
}

+(NSString *)parseStr : (NSObject *)model
{
    return model.mj_keyValues.mj_JSONString;
}

+(NSMutableDictionary *)parseDic: (NSObject *)model
{
    return model.mj_keyValues;
}

@end
