//
//  MenuModel.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isSelected;


//构建自选合约数据
+(NSMutableArray *)buildModel1;

//构建国内交易所数据
+(NSMutableArray *)buildModel2;

//构建国际交易所数据
+(NSMutableArray *)buildModel3;

//构建股票基金数据
+(NSMutableArray *)buildModel4;

@end
