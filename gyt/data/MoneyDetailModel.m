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
    [datas addObject:[TitleContentModel buildData:@"资金账号" content:[[Account sharedAccount]getUid]]];
    [datas addObject:[TitleContentModel buildData:@"昨日权益" content:[NSString stringWithFormat:@"%.2f",model.m_dYesterdayBalance]]];
    [datas addObject:[TitleContentModel buildData:@"当前权益" content:[NSString stringWithFormat:@"%.2f",model.m_dCurBalance]]];
    [datas addObject:[TitleContentModel buildData:@"优先资金" content:[NSString stringWithFormat:@"%.2f",model.m_dCaptialMoney]]];
    [datas addObject:[TitleContentModel buildData:@"总权益" content:[NSString stringWithFormat:@"%.2f",model.m_dBalance]]];
    [datas addObject:[TitleContentModel buildData:@"持仓盈亏" content:[NSString stringWithFormat:@"%.2f",model.m_dPositionProfit]]];
    [datas addObject:[TitleContentModel buildData:@"平仓盈亏" content:[NSString stringWithFormat:@"%.2f",model.m_dCloseProfit]]];
    [datas addObject:[TitleContentModel buildData:@"入金" content:[NSString stringWithFormat:@"%.2f",model.m_dDeposit]]];
    [datas addObject:[TitleContentModel buildData:@"出金" content:[NSString stringWithFormat:@"%.2f",model.m_dWithdraw]]];
    [datas addObject:[TitleContentModel buildData:@"占用保证金" content:[NSString stringWithFormat:@"%.2f",model.m_dCurrMargin]]];
    [datas addObject:[TitleContentModel buildData:@"冻结保证金" content:[NSString stringWithFormat:@"%.2f",model.m_dFrozenMargin]]];
    [datas addObject:[TitleContentModel buildData:@"手续费" content:[NSString stringWithFormat:@"%.2f",model.m_dCommission]]];
    [datas addObject:[TitleContentModel buildData:@"冻结手续费" content:[NSString stringWithFormat:@"%.2f",model.m_dFrozenCommission]]];
    [datas addObject:[TitleContentModel buildData:@"合约价值" content:[NSString stringWithFormat:@"%.2f",model.m_dInstrumentValue]]];
    [datas addObject:[TitleContentModel buildData:@"币种" content:[Constant getMoneyType : model.m_moneyType]]];
    
    return datas;
}

@end
