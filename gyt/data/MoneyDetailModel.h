//
//  MoneyModel.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyDetailModel : NSObject

//日期
@property (copy, nonatomic) NSString *date;

//币种
@property (copy, nonatomic) NSString *currency;

//权益
@property (copy, nonatomic) NSString *rights;

//可用资金
@property (copy, nonatomic) NSString *canuse;

//保证金
@property (copy, nonatomic) NSString *bond;

//手续费
@property (copy, nonatomic) NSString *counterFee;


+(NSMutableArray *)getData;

@end
