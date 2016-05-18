//
//  Request.h
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryRequest : NSObject

typedef NS_ENUM(NSInteger, RequestType) {
    XT_121_START = 121 * 100,
    XT_CAccountBaseInfo,
    XT_CLoginParam,
    XT_CTradeLoginParam,
    XT_CLoginResponse,
    XT_CUserInfo,
    XT_CAccountInfo,
    XT_CCashInfo,
    XT_CCashApplyInfo,
    XT_CInstrumentDetail,
    XT_CInstrumentMarginRate,
    XT_CInstrumentCommissionRate,
    XT_CInstrumentFee,
    XT_CQueryDataReq,
    XT_CQueryHistoryDataReq,
    XT_CAccountDetail,//
    XT_CFundFlow,
    XT_COrderDetail,
    XT_CDealDetail,
    XT_CPositionDetail,
    XT_CPositionStatics,
    XT_CLoginInfoLog,
    XT_CProductInfo,
    XT_CTradeTimePair,
    XT_CInstrumentSettlementInfo,
    XT_CQueryMarginInfo,
    XT_CQueryFeeInfo,
    XT_COrderTag,
    XT_COrderInfo,
    XT_COrderResponse,
    XT_CBrokerInfo,
    XT_CQueryBaseSettingReq,
    XT_CPriceData,
    XT_CProxyProfit,
    XT_CWithCapitalInfo,
    XT_CMobileLoginResponse,
    XT_CDealStatics,
    XT_CSettingTemplateInfo,
    XT_TransferResp,
    XT_CancelResp,
    XT_QueryAccountResp,
    XT_QueryInvestorResp,
    XT_QueryBankAmountResp,
    XT_QueryExchangeResp,
    XT_QueryInstrumentResp,
    XT_QueryOrderResp,
    XT_QueryInstrumentMarginRateResp,
    XT_QuerySettlementInfoResp,
    XT_QueryBusinessResp,
    XT_QueryInstrumentCommissionRateResp,
    XT_QueryPositionResp,
    XT_QueryBankResp,
    XT_COrderError,
    XT_CCancelError,
    
};


#pragma mark 组装基本json字符串
+(NSString *)buildRequestJson : (NSString *)account
                      structId: (int)structId;

#pragma mark 请求用户基本信息
+(void)requestAcountInfo : (UIView *)view
                 success : (SuccessCallback)success
                    fail : (FailCallback)fail;

@end
