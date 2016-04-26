//
//  MenuModel.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+(NSMutableArray *)buildModel1
{
    NSArray *titles = @[@"浏览记录列表",@"预警合约列表",@"自选合约列表"];
    return [self bulid:titles];
}

+(NSMutableArray *)buildModel2
{
    NSArray *titles = @[@"主力合约",@"郑州商品交易所",@"大连商品交易所",@"上海期货交易所",@"中国金融期货交易所",@"夜市",@"上海黄金交易所"];
    return [self bulid:titles];
}

+(NSMutableArray *)buildModel3
{
    NSArray *titles = @[@"外盘纵览",@"纽约NYMEX",@"纽约COMEX",@"纽约ICE",@"芝加哥CBOT",@"伦敦LME",@"伦敦ICE",@"欧美期指",@"外汇期货",@"CME",@"香港HKEx",@"新加坡SGX",@"东京TOCOM",@"马来西亚BMD",@"商品指数",@"全球股票指数",@"外汇与美金"];
    return [self bulid:titles];
 
}

+(NSMutableArray *)buildModel4
{
    NSArray *titles = @[@"上证A股",@"深证A股",@"中小板块",@"创业板块",@"指数基金",@"其他LOF基金",@"封闭式基金",@"黄金ETF",@"国债ETF"];
    return [self bulid:titles];
}


+(NSMutableArray *)bulid : (NSArray *)array
{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(NSString *title in array)
    {
        MenuModel *model = [[MenuModel alloc]init];
        model.title = title;
        model.isSelected = NO;
        [datas addObject:model];
    }
    return datas;
}

@end
