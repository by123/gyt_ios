//
//  HistoryModel.h
//  gyt
//
//  Created by by.huang on 16/8/25.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryOrderModel : NSObject

//合约
@property (copy, nonatomic) NSString *m_strInstrumentID;

//合同编号
@property (copy, nonatomic) NSString *m_strOrderSysID;

//委托日期
@property (assign, nonatomic) int m_nInsertDate;

//委托时间
@property (assign, nonatomic) int m_nInsertTime;

//委托价
@property (assign, nonatomic) double m_dLimitPrice;

//委托量
@property (assign, nonatomic) int m_nVolumeTotalOriginal;

//剩余委托量
@property (assign, nonatomic) int m_nVolumeLeft;

//委托状态
@property (assign, nonatomic) EEntrustStatus m_nOrderStatus;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//币种
@property (assign, nonatomic) int m_nMoneyType;

//成交均价
@property (assign, nonatomic) double m_dTradedPrice;

//成交量
@property (assign, nonatomic) int m_nVolumeTraded;



@end
