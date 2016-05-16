//
//  TitleContentModel.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyDetailModel.h"
#import "TitleContentModel.h"
@implementation MoneyDetailModel

+(NSMutableArray *)getData
{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[TitleContentModel buildData:@"日期" content:@"2016-05-14"]];
    [datas addObject:[TitleContentModel buildData:@"账号编号" content:@"80012314"]];
    [datas addObject:[TitleContentModel buildData:@"账号状态" content:@"正常"]];
    [datas addObject:[TitleContentModel buildData:@"客户姓名" content:@"程集宏"]];
    [datas addObject:[TitleContentModel buildData:@"币种" content:@"RMB"]];
    [datas addObject:[TitleContentModel buildData:@"动态权益" content:@"10000002"]];
    [datas addObject:[TitleContentModel buildData:@"静态权益" content:@"10000023"]];
    [datas addObject:[TitleContentModel buildData:@"优先资金" content:@"10003242"]];
    [datas addObject:[TitleContentModel buildData:@"可用资金" content:@"9992342"]];
    [datas addObject:[TitleContentModel buildData:@"持仓盈亏" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"平仓盈亏" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"入金" content:@"1000000"]];
    [datas addObject:[TitleContentModel buildData:@"出金" content:@"500000"]];
    [datas addObject:[TitleContentModel buildData:@"暂用保证金" content:@"5000"]];
    [datas addObject:[TitleContentModel buildData:@"冻结保证金" content:@"5000"]];
    [datas addObject:[TitleContentModel buildData:@"手续费" content:@"840"]];
    [datas addObject:[TitleContentModel buildData:@"冻结手续费率" content:@"5%"]];
    [datas addObject:[TitleContentModel buildData:@"合约价值" content:@"2323"]];

    return datas;
}

@end
