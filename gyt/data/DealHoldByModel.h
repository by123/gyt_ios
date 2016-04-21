//
//  DealByModel.h
//  gyt
//
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealHoldByModel : NSObject

//商品名称
@property (copy, nonatomic) NSString *name;

//状态
@property (copy, nonatomic) NSString *statu;

//开平
@property (copy, nonatomic) NSString *kaiping;

//委托价
@property (copy, nonatomic) NSString *price;

//委托量
@property (copy, nonatomic) NSString *handby;

//已成交
@property (copy, nonatomic) NSString *handDeal;

//已撤单
@property (copy, nonatomic) NSString *handCancel;

//委托时间
@property (copy, nonatomic) NSString *time;

@end
