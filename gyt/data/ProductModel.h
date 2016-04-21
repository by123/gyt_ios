//
//  ProductModel.h
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, InventoryType) {
    Inventory,
    DailyInventory,
    DealInventory,
};

typedef NS_ENUM(NSInteger, UpdownType) {
    UpdownPrice,
    UpdownPercent,
};

@interface ProductModel : NSObject

//产品id
@property (assign, nonatomic) int pid;

//名称
@property (copy, nonatomic) NSString *name;

//最新价格
@property (assign, nonatomic) float recentPrice;

//涨跌价格
@property (assign, nonatomic) float updownPrice;

//涨跌幅率
@property (assign, nonatomic) float updownPercent;

//是否上涨
@property (assign, nonatomic) BOOL isUp;

//持仓量
@property (copy, nonatomic) NSString *inventory;

//日增仓
@property (copy, nonatomic) NSString *dailyInventory;

//成交量
@property (copy, nonatomic) NSString *dealInventory;

//是否加入自选合约
@property (assign, nonatomic) BOOL isMyContract;

@end
