//
//  HistoryTradeCell.h
//  gyt
//
//  Created by by.huang on 16/8/25.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryTradeModel : NSObject

//合约
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合同编号
@property (copy, nonatomic) NSString *m_strOrderSysID;

//成交日期
@property (assign, nonatomic) int m_strTradeDate;

//成交时间
@property (assign, nonatomic) int m_strTradeTime;

//平仓盈亏
@property (assign, nonatomic) double m_dCloseProfit;

//手续费
@property (assign, nonatomic) double m_dComssion;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//币种
@property (assign, nonatomic) int m_nMoneyType;

//成交均价
@property (assign, nonatomic) double m_dPrice;

//成交量
@property (assign, nonatomic) int m_nVolume;



@end
