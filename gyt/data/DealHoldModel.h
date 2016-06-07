//
//  DealHoldModel.h
//  gyt
//  持仓
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface DealHoldModel : NSObject

//账号信息
@property (strong, nonatomic) UserInfoModel *m_accountInfo;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//交易市场名称
@property (copy, nonatomic) NSString *m_strExchangeName;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//昨仓
@property (assign, nonatomic) int m_nYesterdayVolume;

//
@property (assign, nonatomic) int m_nPosition;

//开仓成本
@property (assign, nonatomic) double m_dOpenCost;

//开仓价格
@property (assign, nonatomic) double m_dOpenPrice;

//是否今仓
@property (assign, nonatomic) BOOL m_bIsToday;

//投保标记
@property (assign, nonatomic) EHedge_Flag_Type m_nHedgeFlag;

//
@property (assign, nonatomic) int m_nOpenVolume;

//平仓量
@property (assign, nonatomic) int m_nCloseVolume;

//持仓成本
@property (assign, nonatomic) double m_dPositionCost;

//持仓盈亏
@property (assign, nonatomic) double m_dPositionProfit;

//浮动盈亏
@property (assign, nonatomic) double m_dFloatProfit;

//盈亏比例
@property (assign, nonatomic) double m_dProfitRate;

//均价
@property (assign, nonatomic) double m_dAvgPrice;

//合约价值
@property (assign, nonatomic) double m_dInstrumentValue;

//最新价
@property (assign, nonatomic) double m_dLastPrice;

//
@property (assign, nonatomic) double m_dUsedMargin;

//
@property (assign, nonatomic) double m_dUsedCommission;

//
@property (assign, nonatomic) double m_dFrozenMargin;

//
@property (assign, nonatomic) double m_dFrozenCommission;

//
@property (assign, nonatomic) int m_nFrozenVolume;

//
@property (assign, nonatomic) int m_nCanCloseVol;

//结算价
@property (assign, nonatomic) double m_dSettlementPrice;

//
@property (copy, nonatomic) NSString *m_strExpireDate;

//
@property (assign, nonatomic) double m_dExchangeRate;

//
@property (assign, nonatomic) EMoneyType m_nMoneyType;

//
@property (assign, nonatomic) int m_nYestoday;

//
@property (assign, nonatomic) int m_nTodayLong;

//
@property (assign, nonatomic) int m_nTodayShort;

//
@property (assign, nonatomic) int m_dPriceTick;


@end
