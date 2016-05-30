//
//  MoneyModel.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccessGoldModel.h"

@interface MoneyDetailModel : NSObject

//资金账号
@property (copy, nonatomic) NSString *m_strAccountID;

//权益
@property (assign, nonatomic) double m_dCurBalance;

//可用资金
@property (assign, nonatomic) double m_dAvailable;

//币种
@property (assign, nonatomic) MoneyType m_nMoneyType;

//初始权益
@property (assign, nonatomic) double m_dInitBalance;

//出入金
@property (assign, nonatomic) double m_dDeposit;

//手续费
@property (assign, nonatomic) double m_dCommission;

//平仓盈亏
@property (assign, nonatomic) double m_dCloseProfit;

//平仓盈亏率
@property (assign, nonatomic) double a1;

//逐笔浮赢
@property (assign, nonatomic) double a2;

//逐笔浮赢率
@property (assign, nonatomic) double a3;

//保证金
@property (assign, nonatomic) double m_dUsedMargin;

//挂单保证金
@property (assign, nonatomic) double a4;

//挂单手续费
@property (assign, nonatomic) double *a5;

//资金使用率
@property (assign, nonatomic) double *a6;



+(NSMutableArray *)getData : (MoneyDetailModel *)model;

@end
