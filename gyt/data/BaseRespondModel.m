//
//  BaseRespondModel.m
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseRespondModel.h"

@implementation BaseRespondModel

+(BaseRespondModel *) buildModel : (id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.seq == XT_CPositionStatics)
    {
        NSString *temp = @"{ \"status\" : 0, \"params\" : { \"error\" : { \"ErrorID\" : 0, \"ErrorMsg\" : \"\" }, \"response\" : { \"datas\" : [ { \"_typeId\" : 12120, \"m_accountInfo\" : { \"_typeId\" : 12106, \"m_strAccountID\" : \"800001080\", \"m_nAccountType\" : 1, \"m_strPassword\" : \"1uEoFf0e\", \"m_nStatus\" : 2, \"m_bAllowTrade\" : true, \"m_bSubAccount\" : true, \"m_bSimAccount\" : true, \"m_strName\" : \"53434\", \"m_strUserID\" : \"admin\", \"m_nPlatformID\" : 0, \"m_strBrokerID\" : \"\", \"m_openDate\" : 2147483647, \"999999\" : \"\" }, \"m_strExchangeID\" : \"SGX-A\", \"m_strExchangeName\" : \"ÐÂ¼ÓÆÂ½»Ò×Ëù\", \"m_strProductID\" : \"CN\", \"m_strInstrumentID\" : \"CN 1606\", \"m_nDirection\" : 48, \"m_strInstrumentName\" : \"\", \"m_nYesterdayVolume\" : 0, \"m_nPosition\" : 3, \"m_dOpenCost\" : 28260, \"m_dOpenPrice\" : 9420, \"m_bIsToday\" : true, \"m_nHedgeFlag\" : 49, \"m_nOpenVolume\" : 3, \"m_nCloseVolume\" : 0, \"m_dPositionCost\" : 28260, \"m_dPositionProfit\" : 0, \"m_dAvgPrice\" : 9420, \"m_dFloatProfit\" : 0, \"m_dProfitRate\" : 0, \"m_dUsedMargin\" : 5100, \"m_dUsedCommission\" : 30, \"m_dFrozenMargin\" : 8500, \"m_dFrozenCommission\" : 50, \"m_nFrozenVolume\" : 0, \"m_nCanCloseVol\" : 3, \"m_dInstrumentValue\" : 28260, \"m_dLastPrice\" : 9420, \"m_dSettlementPrice\" : 1, \"m_strExpireDate\" : \"\", \"m_dExchangeRate\" : 1, \"m_nMoneyType\" : 1, \"m_nYestoday\" : 3, \"m_nTodayLong\" : 0, \"m_nTodayShort\" : 0, \"m_dPriceTick\" : 2.5, \"999999\" : \"\" }, { \"_typeId\" : 12120, \"m_accountInfo\" : { \"_typeId\" : 12106, \"m_strAccountID\" : \"800001080\", \"m_nAccountType\" : 1, \"m_strPassword\" : \"1uEoFf0e\", \"m_nStatus\" : 2, \"m_bAllowTrade\" : true, \"m_bSubAccount\" : true, \"m_bSimAccount\" : true, \"m_strName\" : \"53434\", \"m_strUserID\" : \"admin\", \"m_nPlatformID\" : 0, \"m_strBrokerID\" : \"\", \"m_openDate\" : 2147483647, \"999999\" : \"\" }, \"m_strExchangeID\" : \"SGX-A\", \"m_strExchangeName\" : \"ÐÂ¼ÓÆÂ½»Ò×Ëù\", \"m_strProductID\" : \"CN\", \"m_strInstrumentID\" : \"CN 1609\", \"m_nDirection\" : 49, \"m_strInstrumentName\" : \"\", \"m_nYesterdayVolume\" : 0, \"m_nPosition\" : 1, \"m_dOpenCost\" : 9140, \"m_dOpenPrice\" : 9140, \"m_bIsToday\" : true, \"m_nHedgeFlag\" : 49, \"m_nOpenVolume\" : 1, \"m_nCloseVolume\" : 0, \"m_dPositionCost\" : 9140, \"m_dPositionProfit\" : 0, \"m_dAvgPrice\" : 9140, \"m_dFloatProfit\" : 0, \"m_dProfitRate\" : 0, \"m_dUsedMargin\" : 1700, \"m_dUsedCommission\" : 10, \"m_dFrozenMargin\" : 0, \"m_dFrozenCommission\" : 0, \"m_nFrozenVolume\" : 0, \"m_nCanCloseVol\" : 1, \"m_dInstrumentValue\" : 9140, \"m_dLastPrice\" : 9140, \"m_dSettlementPrice\" : 1, \"m_strExpireDate\" : \"\", \"m_dExchangeRate\" : 1, \"m_nMoneyType\" : 1, \"m_nYestoday\" : -1, \"m_nTodayLong\" : 0, \"m_nTodayShort\" : 0, \"m_dPriceTick\" : 2.5, \"999999\" : \"\" } ] } } }";
        packageModel.result = temp;
    }
    BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:packageModel.result];
    id params = model.params;
    model.response = [params objectForKey:@"response"];
    model.error = [ErrorModel mj_objectWithKeyValues:params];
    return model;
}

@end
