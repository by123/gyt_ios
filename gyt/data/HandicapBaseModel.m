//
//  HandicapBaseModel.m
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HandicapBaseModel.h"

@implementation HandicapBaseModel

+(HandicapBaseModel *) build : (NSString *)title
                   value : (NSString *)value
{
    HandicapBaseModel *model = [[HandicapBaseModel alloc]init];
    model.title = title;
    model.value = value;
    return model;
}
@end
