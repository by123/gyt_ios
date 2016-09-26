//
//  OrderStopLossModel.h
//  gyt
//
//  Created by by.huang on 16/9/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStopLossModel : NSObject

//账号ID
@property(copy, nonatomic) NSString *m_strAccountID;

//下单引用
@property(copy, nonatomic) NSString *m_strOrderRef;

//时间
@property(assign, nonatomic) int m_nTime;

//运行状态
@property(assign, nonatomic) EStopValueStatus m_eStatus;

//类别
@property(assign, nonatomic) EStopType m_eStopType;

//合约ID
@property(copy, nonatomic) NSString *m_strInstrumentID;

//下单方式
@property(assign, nonatomic) EBrokerPriceType m_nOrderPriceType;

//触发价
@property(assign, nonatomic) double m_dStopValue;

//手数
@property(assign, nonatomic) int m_nVolume;

//买卖
@property(assign, nonatomic) EEntrustBS m_nDirection;

//是否启动操作
@property(assign, nonatomic) Boolean m_bEnableStopValue;


@end
