//
//  GetCashModel.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AccessGoldModel.h"
#import "TitleContentModel.h"
@implementation AccessGoldModel

+(NSMutableArray *)getData
{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
//    [datas addObject:[TitleContentModel buildData:@"账户编号" content:@""]];
//    [datas addObject:[TitleContentModel buildData:@"客户名称" content:@""]];
//    [datas addObject:[TitleContentModel buildData:@"申请类型" content:@""]];
    [datas addObject:[TitleContentModel buildData:@" 币种  " content:@"" canList:YES]];
    [datas addObject:[TitleContentModel buildData:@"转出金额" content:@""]];
//    [datas addObject:[TitleContentModel buildData:@"支付方式" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"收款姓名" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"提交机构" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"提交备注" content:@""]];
    return datas;
}


+(NSString *)getCashType : (CashType)type
{
    switch (type) {
        case CashType_In:
            return @"入金";
        case CashType_Out:
            return @"出金";
        default:
            break;
    }
}

+(NSString *)getPayType : (PayType)type
{
    switch (type) {
        case PayType_ON_LINE:
            return @"线上";
        case PayType_OFF_LINE:
            return @"线下";
    }
}



+(NSString *)getMoneyType : (MoneyType)type
{
    switch (type) {
        case MoneyType_RMB:
            return @"人民币";
        case MoneyType_USD:
            return @"美元";
        case MoneyType_HKD:
            return @"港币";
        case MoneyType_CHF:
            return @"瑞士法郎";
        case MoneyType_JPY:
            return @"日元";
        case MoneyType_KRW:
            return @"韩元";
        case MoneyType_GBP:
            return @"英镑";
        case MoneyType_RUB:
            return @"卢布";
        case MoneyType_AUD:
            return @"澳大利亚元";
        case MoneyType_SGD:
            return @"新币";
        case MoneyType_EUR:
            return @"欧元";
        case MoneyType_CAD:
            return @"加拿大元";
        case MoneyType_NZD:
            return @"新西兰元";
        default:
            return @"人民币";
    }
}

+(NSString *)getCashApplicationStatus : (CashApplicationStatus)type
{
    switch (type) {
        case CashApplicationStatus_Submit:
            return @"等待审核";
        case CashApplicationStatus_Accepted:
            return @"审核通过";
        case CashApplicationStatus_ForBidden:
            return @"审核拒绝";
        case CashApplicationStatus_Auto:
            return @"自动审核";
        default:
            break;
    }
}



+(NSMutableArray *)getTitleContentData : (AccessGoldModel *)model
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    [data addObject:[TitleContentModel buildData:@"出入金对象ID" content:model.m_strTargetId]];
    [data addObject:[TitleContentModel buildData:@"出入金对象名" content:@"黄成实"]];
    [data addObject:[TitleContentModel buildData:@"出入金类型" content:[AccessGoldModel getCashType:model.m_nCashType]]];
    [data addObject:[TitleContentModel buildData:@"币种" content:[AccessGoldModel getMoneyType:model.m_nMoneyType]]];
    [data addObject:[TitleContentModel buildData:@"金额" content:[NSString stringWithFormat:@"%f",model.m_dCashValue]]];
    [data addObject:[TitleContentModel buildData:@"流水号" content:model.m_strSerialNo]];
    [data addObject:[TitleContentModel buildData:@"支付方式" content:[AccessGoldModel getPayType:model.m_nPayType]]];
    [data addObject:[TitleContentModel buildData:@"申请状态" content:[AccessGoldModel getCashApplicationStatus:model.m_nStatus]]];
    [data addObject:[TitleContentModel buildData:@"收款人" content:model.m_strReceiver]];
    [data addObject:[TitleContentModel buildData:@"申请提交人" content:model.m_strSubmitter]];
    [data addObject:[TitleContentModel buildData:@"申请日期" content:[NSString stringWithFormat:@"%@ %@",model.m_applyDate,model.m_applyTime]]];
    [data addObject:[TitleContentModel buildData:@"审核人" content:model.m_strChecker]];
    [data addObject:[TitleContentModel buildData:@"审核日期" content:[NSString stringWithFormat:@"%@ %@",model.m_checkDate,model.m_checkTime]]];
    [data addObject:[TitleContentModel buildData:@"审核备注" content:model.m_strCheckMemo]];
    
    return data;
}



@end
