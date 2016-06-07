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

+(NSMutableArray *)getData : (MoneyDetailModel *)model
{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[TitleContentModel buildData:@"资金账号" content:model.m_strAccountID]];
    [datas addObject:[TitleContentModel buildData:@"权益" content:[NSString stringWithFormat:@"%.2f",model.m_dCurBalance]]];
    [datas addObject:[TitleContentModel buildData:@"可用资金" content:[NSString stringWithFormat:@"%.2f",model.m_dAvailable]]];
    [datas addObject:[TitleContentModel buildData:@"币种" content:[Constant getMoneyType:model.m_nMoneyType]]];
    [datas addObject:[TitleContentModel buildData:@"初始权益" content:[NSString stringWithFormat:@"%.2f",model.m_dInitBalance]]];
    [datas addObject:[TitleContentModel buildData:@"出入金" content:[NSString stringWithFormat:@"%.2f",model.m_dDeposit]]];
    [datas addObject:[TitleContentModel buildData:@"手续费" content:[NSString stringWithFormat:@"%.2f",model.m_dCommission]]];
    [datas addObject:[TitleContentModel buildData:@"平仓盈亏" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"平仓盈亏率" content:@"0.00%"]];
    [datas addObject:[TitleContentModel buildData:@"逐笔浮赢" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"逐笔浮赢率" content:@"0.00%"]];
    [datas addObject:[TitleContentModel buildData:@"保证金" content:[NSString stringWithFormat:@"%.2f",model.m_dUsedMargin]]];
    [datas addObject:[TitleContentModel buildData:@"挂单保证金" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"挂单手续费" content:@"0.00"]];
    [datas addObject:[TitleContentModel buildData:@"资金使用率" content:@"0.00%"]];
    
    return datas;
}

@end
