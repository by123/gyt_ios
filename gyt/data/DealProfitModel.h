//
//  DealProfitModel.h
//  gyt
//  成交
//  Created by by.huang on 16/4/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface DealProfitModel : NSObject

//账号信息
@property (strong, nonatomic) UserInfoModel *m_accountInfo;

//成交号(最初开仓位的成交)
@property (copy, nonatomic) NSString *m_strTradeID;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//交易所名称
@property (copy, nonatomic) NSString *m_strExchangeName;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//品种名称
@property (copy, nonatomic) NSString *m_strProductName;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//下单引用
@property (copy, nonatomic) NSString *m_strOrderRef;

//合同编号
@property (copy, nonatomic) NSString *m_strOrderSysID;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//成交日期
@property (assign, nonatomic) int m_strTradeDate;

//成交时间
@property (copy, nonatomic) NSString *m_strTradeTime;

//开平
@property (assign, nonatomic) EOffset_Flag_Type m_nOffsetFlag;

//成交均价
@property (assign, nonatomic) double m_dPrice;

//成交金额
@property (assign, nonatomic) double m_dTradeAmount;

//成交量
@property (assign, nonatomic) int m_nVolume;

//手续费
@property (assign, nonatomic) double m_dComssion;

//类型，例如市价单 限价单
@property (assign, nonatomic) EBrokerPriceType m_nOrderPriceType;

//展示委托属性的中文
@property (copy, nonatomic) NSString *m_strOptName;

//平仓盈亏
@property (assign, nonatomic) double m_dCloseProfit;

//投保
@property (assign, nonatomic) EHedge_Flag_Type m_nHedgeFlag;

//成交类型
@property (assign, nonatomic) EFutureTradeType m_eFutureTradeType;

//实际开平,主要是区分平今和平昨
@property (assign, nonatomic) EOffset_Flag_Type m_nRealOffsetFlag;

//平今量
@property (assign, nonatomic) int m_nCloseTodayVolume;

@end
