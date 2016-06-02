//
//  DealProfitModel.h
//  gyt
//  成交
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealProfitModel : NSObject


//商品名称
@property (copy, nonatomic) NSString *name;

//开平
@property (copy, nonatomic) NSString *kaiping;

//成交价
@property (copy, nonatomic) NSString *price;

//成交量
@property (copy, nonatomic) NSString *hand;

//成交时间
@property (copy, nonatomic) NSString *time;

@end
