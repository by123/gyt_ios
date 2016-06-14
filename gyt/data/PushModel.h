//
//  PushModel.h
//  gyt
//
//  Created by by.huang on 16/6/6.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushModel : NSObject

//交易日
@property (copy, nonatomic) NSString *m_strTradingDay;

//交易所代码
@property (copy, nonatomic) NSString *m_strExchangeID;

//合约代码
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

//合约在交易所的代码
@property (copy, nonatomic) NSString *m_strExchangeInstID;

//最新价
@property (assign, nonatomic) double m_dLastPrice;

//涨跌
@property (assign, nonatomic) double m_dUpDown;

//涨幅
@property (assign, nonatomic) double m_dUpDownRate;

//当日均价
@property (assign, nonatomic) double m_dAveragePrice;

//数量
@property (assign, nonatomic) int m_nVolume;

//成交金额
@property (assign, nonatomic) double m_dTurnover;

//昨收盘
@property (assign, nonatomic) double m_dPreClosePrice;

//上次结算价
@property (assign, nonatomic) double m_dPreSettlementPrice;

//昨持仓量
@property (assign, nonatomic) double m_dPreOpenInterest;

//持仓量
@property (assign, nonatomic) double m_dOpenInterest;

//本次结算价
@property (assign, nonatomic) double m_dSettlementPrice;

//今开盘
@property (assign, nonatomic) double m_dOpenPrice;

//最高价
@property (assign, nonatomic) double m_dHighestPrice;

//最低价
@property (assign, nonatomic) double m_dLowestPrice;

//今收盘
@property (assign, nonatomic) double m_dClosePrice;

//涨停板价
@property (assign, nonatomic) double m_dUpperLimitPrice;

//跌停板价
@property (assign, nonatomic) double m_dLowerLimitPrice;

@property (assign, nonatomic) double m_dPreDelta;

@property (assign, nonatomic) double m_dCurrDelta;

@property (assign, nonatomic) int m_nPlatformId;

//最后修改时间
@property (copy, nonatomic) NSString *m_strUpdateTime;

//最后修改毫秒
@property (assign, nonatomic) int m_nUpdateMillisec;

//申买价一
@property (assign, nonatomic) double m_dBidPrice1;//(卖出)
//申买量一
@property (assign, nonatomic) int m_nBidVolume1;
//申卖价一
@property (assign, nonatomic) double m_dAskPrice1;//(买入)
//申卖量一
@property (assign, nonatomic) int m_nAskVolume1;


//申买价二
@property (assign, nonatomic) double m_dBidPrice2;
//申买量二
@property (assign, nonatomic) int m_nBidVolume2;
//申卖价二
@property (assign, nonatomic) double m_dAskPrice2;
//申卖量二
@property (assign, nonatomic) int m_nAskVolume2;


//申买价三
@property (assign, nonatomic) double m_dBidPrice3;
//申买量三
@property (assign, nonatomic) int m_nBidVolume3;
//申卖价三
@property (assign, nonatomic) double m_dAskPrice3;
//申卖量三
@property (assign, nonatomic) int m_nAskVolume3;

//申买价四
@property (assign, nonatomic) double m_dBidPrice4;
//申买量四
@property (assign, nonatomic) int m_nBidVolume4;
//申卖价四
@property (assign, nonatomic) double m_dAskPrice4;
//申卖量四
@property (assign, nonatomic) int m_nAskVolume4;

//申买价五
@property (assign, nonatomic) double m_dBidPrice5;
//申买量五
@property (assign, nonatomic) int m_nBidVolume5;
//申卖价五
@property (assign, nonatomic) double m_dAskPrice5;
//申卖量五
@property (assign, nonatomic) int m_nAskVolume5;

//前一次的价格
@property (assign, nonatomic) double m_dPrePrice;



//交易所名称
@property (copy, nonatomic) NSString *m_strExchangeName;

//品种ID
@property (copy, nonatomic) NSString *m_strProductID;

//品种名称代码
@property (copy, nonatomic) NSString *m_strProductName;

//到期日
@property (copy, nonatomic) NSString *m_strExpireDate;

//是否可交易
@property (assign, nonatomic) BOOL m_bAllowTrade;

//合约乘数 股票为1
@property (assign, nonatomic) int m_volumeMultiple;

//前收盘价
@property (assign, nonatomic) double m_preClose;

//币种
@property (assign, nonatomic) EMoneyType m_moneyType;

//前结算价
@property (assign, nonatomic) double m_dLastSettlementPrice;

//涨停价
@property (assign, nonatomic) double m_dUpStopPrice;

//跌停价
@property (assign, nonatomic) double m_dDownStopPrice;

//是否主力合约
@property (assign, nonatomic) int m_nIsMain;

//成交量
@property (assign, nonatomic) long m_lDealVolum;

//最小波动
@property (assign, nonatomic) double m_dPriceTick;

//是否上涨
@property (assign, nonatomic) BOOL isUp;


//是否加入自选合约
@property (assign, nonatomic) int isMyContract;


@end
