//
//  HandicapDetailModel.h
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandicapDetailModel : NSObject

//交易时间
@property (copy, nonatomic) NSString *timeStamp;

//价位
@property (copy, nonatomic) NSString *price;

//现手
@property (copy, nonatomic) NSString *handNow;

//增仓
@property (copy, nonatomic) NSString *hold;

//开平
@property (copy, nonatomic) NSString *kaiping;

@end
