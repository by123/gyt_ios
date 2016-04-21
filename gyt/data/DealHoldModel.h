//
//  DealHoldModel.h
//  gyt
//
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealHoldModel : NSObject

//商品名称
@property (copy, nonatomic) NSString *name;

//多空
@property (copy, nonatomic) NSString *buySell;

//手数
@property (copy, nonatomic) NSString *hand;

//可用
@property (copy, nonatomic) NSString *canuse;

//开仓均价
@property (copy, nonatomic) NSString *averagePrice;

//逐笔浮盈
@property (copy, nonatomic) NSString *profit;

@end
