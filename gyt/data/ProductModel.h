//
//  ProductModel.h
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface ProductModel : NSObject

//产品id
@property (assign, nonatomic) int pid;

//名称
@property (copy, nonatomic) NSString *name;

//最新价格
@property (assign, nonatomic) float recentPrice;

//涨跌价格
@property (assign, nonatomic) float updownPrice;

//涨跌幅率
@property (assign, nonatomic) float updownPercent;

//是否上涨
@property (assign, nonatomic) BOOL isUp;

//持仓量
@property (copy, nonatomic) NSString *inventory;

//日增仓
@property (copy, nonatomic) NSString *dailyInventory;

//成交量
@property (copy, nonatomic) NSString *dealInventory;

//是否加入自选合约
@property (assign, nonatomic) BOOL isMyContract;

//是否被选中状态
@property (assign , nonatomic) BOOL isSelect;

//是否是删除布局
@property (assign , nonatomic) BOOL isDelete;

//交易所id
@property (assign , nonatomic) long eid;

//交易所名称
@property (copy, nonatomic) NSString *exchangeName;





//用户信息
@property (strong, nonatomic)UserInfoModel *m_strAccountID;

// 交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

// 交易所名称
@property (copy, nonatomic) NSString *m_strExchangeName;

// 品种ID
@property (copy, nonatomic) NSString *m_strProductID;

// 品种名称代码
@property (copy, nonatomic) NSString *m_strProductName;

//合约ID
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合约名称
@property (copy, nonatomic) NSString *m_strInstrumentName;

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

@end
