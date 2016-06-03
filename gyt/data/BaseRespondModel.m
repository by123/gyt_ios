//
//  BaseRespondModel.m
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseRespondModel.h"

@implementation BaseRespondModel

+(BaseRespondModel *) buildModel : (id)respondObject
{
    PackageModel *packageModel = respondObject;
    NSLog(@"by666->%@",packageModel.result);
    BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:packageModel.result];
    id params = model.params;
    model.response = [params objectForKey:@"response"];
    model.error = [ErrorModel mj_objectWithKeyValues:params];
    return model;
}

@end
