//
//  HandicapModel.h
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandicapBaseModel.h"
#import "HandicapDetailModel.h"
@interface HandicapModel : NSObject

@property (strong, nonatomic) HandicapBaseModel *model1;

@property (strong, nonatomic) HandicapBaseModel *model2;

@property (strong, nonatomic) HandicapDetailModel *detailModel;


+(HandicapModel *)build : (NSString *)title1
                 value1 : (NSString *)value1
                 title2 : (NSString *)title2
                  value2: (NSString *)value2;

+(HandicapModel *)buildDetail : (NSString *)timeStamp
                             price : (NSString *)price
                           handnow : (NSString *)handNow
                              hold : (NSString *)hold
                           kaiping : (NSString *)kaiping;

@end
