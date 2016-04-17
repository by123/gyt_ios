//
//  HandicapModel.m
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HandicapModel.h"

@implementation HandicapModel


+(HandicapModel *)build : (NSString *)title1
                 value1 : (NSString *)value1
                 title2 : (NSString *)title2
                  value2: (NSString *)value2
{
    HandicapModel *model = [[HandicapModel alloc]init];
    model.model1 = [HandicapBaseModel build:title1 value:value1];
    model.model2 = [HandicapBaseModel build:title2 value:value2];
    return model;
}

+(HandicapModel *)buildDetail : (NSString *)timeStamp
                             price : (NSString *)price
                           handnow : (NSString *)handNow
                              hold : (NSString *)hold
                           kaiping : (NSString *)kaiping
{
    HandicapDetailModel *detailModel = [[HandicapDetailModel alloc]init];
    detailModel.timeStamp = timeStamp;
    detailModel.price = price;
    detailModel.handNow = handNow;
    detailModel.hold = hold;
    detailModel.kaiping = kaiping;

    HandicapModel *model = [[HandicapModel alloc]init];
    model.detailModel = detailModel;
    return model;
}



@end
