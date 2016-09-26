//
//  StopLossModel.h
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopLossModel : NSObject

@property (assign, nonatomic) Boolean isStart;

//合约id
@property (copy, nonatomic) NSString *m_strInstrumentID;

//下单引用
@property (copy, nonatomic) NSString *m_strOrderRef;

//运行状态
@property (assign, nonatomic)  EStopValueStatus m_eStatus;

//触发价
@property (assign, nonatomic) double m_dStopValue;

//下单方式
@property (assign, nonatomic) EBrokerPriceType m_nOrderPriceType;

//买卖方向
@property (assign, nonatomic) EEntrustBS m_nDirection;

//手数
@property (assign, nonatomic) int m_nVolume;

//止盈or止损
@property (assign, nonatomic) EStopType m_eStopType;

//用户id
@property (copy, nonatomic) NSString *m_strAccountID;

//时间
@property (assign, nonatomic) int m_nTime;

//是否启动操作
@property (assign, nonatomic) Boolean m_bEnableStopValue;

@end
