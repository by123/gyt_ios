//
//  StopValueTag.h
//  gyt
//
//  Created by by.huang on 16/9/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopValueTag : NSObject

//止盈价
@property (assign, nonatomic) double m_dStopProfitValue;

//止损价
@property (assign, nonatomic) double m_dStopLossValue;

//是否启动止盈
@property (assign, nonatomic) bool m_bEnableStopProfit;

//是否启动止损
@property (assign, nonatomic) bool m_bEnableStopLoss;

////止盈运行状态
//@property (assign, nonatomic) EStopValueStatus m_eStopProfitStatus;
//
////止损运行状态
//@property (assign, nonatomic) EStopValueStatus m_eStopLossStatus;

@end
