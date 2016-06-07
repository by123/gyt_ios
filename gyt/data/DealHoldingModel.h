//
//  DealHoldingModel.h
//  gyt
//
//  Created by by.huang on 16/6/7.
//  Copyright © 2016年 by.huang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "OrderTagModel.h"
@interface DealHoldingModel : NSObject

//-----------------------------------委托主推数据-------------------------------

//账号信息
@property (strong, nonatomic) UserInfoModel *m_accountInfo;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//交易市场名称
@property (copy, nonatomic) NSString *m_strExchangeName;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//品种名称
@property (copy, nonatomic) NSString *m_strProductName;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//sessionod
@property (assign, nonatomic) double m_nSessionID;

//前端id
@property (assign, nonatomic) double m_nFrontID;

//内部委托号
@property (assign, nonatomic) int m_strOrderRef;

//委托价格(限价单的限价，就是报价)
@property (assign, nonatomic) double m_dLimitPrice;

//最初委托量
@property (assign, nonatomic) double m_nVolumeTotalOriginal;

//委托号
@property (copy, nonatomic) NSString *m_strOrderSysID;

//委托状态
@property (assign, nonatomic) EEntrustStatus m_nOrderStatus;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//类型，例如市价单 限价单
@property (assign, nonatomic) EBrokerPriceType m_nOrderPriceType;

//委托属性
@property (copy, nonatomic) NSString *m_strOptName;

//已成交量
@property (assign, nonatomic) int m_nVolumeTraded;

//剩余委托量
@property (assign, nonatomic) int m_nVolumeLeft;

//总委托量
@property (assign, nonatomic) int m_nVolumeTotal;

//错误id
@property (assign, nonatomic) int m_nErrorID;

//错误状态信息
@property (copy, nonatomic) NSString *m_strErrorMsg;

//冻结保证金
@property (assign, nonatomic) double m_dFrozenMargin;

//冻结手续费
@property (assign, nonatomic) double m_dFrozenCommission;

//委托日期
@property (assign, nonatomic) int m_nInsertDate;

//委托时间
@property (assign, nonatomic) int m_nInsertTime;

//成交均价
@property (assign, nonatomic) double m_dTradedPrice;

//已撤数量
@property (assign, nonatomic) int m_dCancelAmount;

//成交金额
@property (assign, nonatomic) double m_dTradeAmount;

//开平
@property (assign, nonatomic) EOffset_Flag_Type m_nOffsetFlag;

//投保
@property (assign, nonatomic) EHedge_Flag_Type m_nHedgeFlag;

//报单状态
@property (assign, nonatomic) EEntrustSubmitStatus m_nOrderSubmitStatus;

//委托日期
@property (copy, nonatomic) NSString *m_strInsertDate;

//委托时间
@property (copy, nonatomic) NSString *m_strInsertTime;



//----------下单委托应答----------------

// 系统合同序号
@property (copy, nonatomic) NSString *m_strContractNum;

//委托数量
@property (assign, nonatomic) int m_nOrderNum;

//价格
@property (assign, nonatomic) double m_dOrderPrice;

//委托附加信息
@property (strong, nonatomic) OrderTagModel *m_tag;

@end
