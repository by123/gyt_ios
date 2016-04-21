//
//  DealHoldingModel.h
//  gyt
//
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealHoldingModel : NSObject

//商品名称
@property (copy, nonatomic) NSString *name;

//开平
@property (copy, nonatomic) NSString *kaiping;

//委托价
@property (copy, nonatomic) NSString *price;

//委托量
@property (copy, nonatomic) NSString *handby;

//挂单量
@property (copy, nonatomic) NSString *hand;


@end
