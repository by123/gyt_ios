//
//  DealHoldModel.h
//  gyt
//
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface DealHoldModel : NSObject

//账号信息
@property (strong, nonatomic) UserInfoModel *m_accountInfo;

//成交号(最初开仓位的成交)
@property (copy, nonatomic) NSString *m_strTradeID;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//品种名称
@property (copy, nonatomic) NSString *m_strProductName;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//上日持仓
@property (assign, nonatomic) double m_nYesterdayVolume;

//持仓量
@property (assign, nonatomic) double m_nVolume;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//使用的保证金 历史的直接用ctp的，新的自己用成本价*存量*系数算
@property (assign, nonatomic) double m_dMargin;

//最新价
@property (assign, nonatomic) double m_dLastPrice;

//结算价
@property (assign, nonatomic) double m_dSettlementPrice;

//昨结算
@property (assign, nonatomic) double m_dLastSettlementPrice;

//合约价值
@property (assign, nonatomic) double m_dInstrumentValue;

//开仓成本
@property (assign, nonatomic) double m_dOpenCost;

//开仓价格
@property (assign, nonatomic) double m_dOpenPrice;

//持仓成本
@property (assign, nonatomic) double m_dPositionCost;

//是否今仓
@property (assign, nonatomic) Boolean m_bIsToday;

//投保标记
@property (assign, nonatomic) EHedge_Flag_Type m_nHedgeFlag;

//开仓日期
@property (copy, nonatomic) NSString *m_strOpenDate;

//持仓盈亏
@property (assign, nonatomic) double m_dPositionProfit;

//浮动盈亏
@property (assign, nonatomic) double m_dFloatProfit;

//平仓盈亏 平仓额 - 开仓价*平仓量*合约乘数（股票为1） 股票不需要
@property (assign, nonatomic) double m_dCloseProfit;

//盈亏比例
@property (assign, nonatomic) double m_dProfitRate;

//交易日
@property (copy, nonatomic) NSString *m_strTradingDay;

//平仓额 等于股票每次卖出的量*卖出价*合约乘数（股票为1）的累加 股票不需要
@property (assign, nonatomic) double m_dCloseAmount;

//平仓量 等于股票已经卖掉的 股票不需要
@property (assign, nonatomic) double m_nCloseVolume;

//成交类型
@property (assign, nonatomic) EFutureTradeType m_eFutureTradeType;

//市值 合约价值
@property (assign, nonatomic) double m_dMarketValue;


@end
