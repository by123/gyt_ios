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
    [datas addObject:[TitleContentModel buildData:@"币种" content:@"" canList:YES]];
    [datas addObject:[TitleContentModel buildData:@"转出金额" content:@""]];
//    [datas addObject:[TitleContentModel buildData:@"支付方式" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"收款姓名" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"提交机构" content:@""]];
    [datas addObject:[TitleContentModel buildData:@"提交备注" content:@""]];
    return datas;
}



+(NSMutableArray *)getTitleContentData : (AccessGoldModel *)model
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    [data addObject:[TitleContentModel buildData:@"出入金对象ID" content:model.m_strTargetId]];
    [data addObject:[TitleContentModel buildData:@"出入金对象名" content:model.m_strTargetName]];
    [data addObject:[TitleContentModel buildData:@"出入金类型" content:[Constant getCashType:model.m_nCashType]]];
    [data addObject:[TitleContentModel buildData:@"币种" content:[Constant getMoneyType:model.m_nMoneyType]]];
    [data addObject:[TitleContentModel buildData:@"金额" content:[NSString stringWithFormat:@"%f",model.m_dCashValue]]];
    [data addObject:[TitleContentModel buildData:@"流水号" content:model.m_strSerialNo]];
    [data addObject:[TitleContentModel buildData:@"支付方式" content:[Constant getPayType:model.m_nPayType]]];
    [data addObject:[TitleContentModel buildData:@"申请状态" content:[Constant getCashApplicationStatus:model.m_nStatus]]];
    [data addObject:[TitleContentModel buildData:@"收款人" content:model.m_strReceiver]];
    [data addObject:[TitleContentModel buildData:@"申请提交人" content:model.m_strSubmitter]];
    [data addObject:[TitleContentModel buildData:@"申请日期" content:[NSString stringWithFormat:@"%@ %@",[AppUtil getFormatDate:model.m_applyDate], [AppUtil getFormatTime:model.m_applyTime]]]];
    [data addObject:[TitleContentModel buildData:@"审核人" content:model.m_strChecker]];
    [data addObject:[TitleContentModel buildData:@"审核日期" content:[NSString stringWithFormat:@"%@ %@",[AppUtil getFormatDate:model.m_checkDate], [AppUtil getFormatTime:model.m_checkTime]]]];
    [data addObject:[TitleContentModel buildData:@"审核备注" content:model.m_strCheckMemo]];
    

    return data;
}



@end
