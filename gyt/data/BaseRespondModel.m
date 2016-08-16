//
//  BaseRespondModel.m
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseRespondModel.h"

@implementation BaseRespondModel

#pragma mark 解数据包
+(BaseRespondModel *) buildModel : (id)respondObject
{
    PackageModel *packageModel = respondObject;
//        NSLog(@"--------------------接收到数据--------------------\n%@",packageModel.result);
    BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:packageModel.result];
    id params = model.params;
    model.response = [params objectForKey:@"response"];
    model.error = [self handleError:params];
    
    if(model.error.ErrorID == 0)
    {
//        NSLog(@"--------------------请求成功--------------------\nseq=%lld",packageModel.seq);
    }
    else
    {
       model.errorMsg = model.error.ErrorMsg;
       [ByToast showErrorToast: model.errorMsg];
    }
    return model;
}

+(Boolean)isSuccess : (id)respondObject
{
    PackageModel *packageModel = respondObject;
    BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:packageModel.result];
    id params = model.params;
    model.response = [params objectForKey:@"response"];
    model.error = [self handleError:params];
    
    if(model.error.ErrorID == 0)
    {
        return  YES;
    }
    else
    {
        return NO;
    }

}

#pragma mark 处理错误请求
+(ErrorModel *)handleError : (id)data
{
    id error = [data objectForKey:@"error"];
    ErrorModel *errorModel = [[ErrorModel alloc]init];
    errorModel.ErrorID = [[error objectForKey:@"ErrorID"] intValue];
    errorModel.ErrorMsg = [error objectForKey:@"ErrorMsg"];;
    
    return errorModel;
}

@end
