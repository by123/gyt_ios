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

//昨日权益
@property (assign, nonatomic) double m_dYesterdayBalance;

//当前权益
@property (assign, nonatomic) double m_dCurBalance;

//优先资金
@property (assign, nonatomic) double m_dCaptialMoney;

//总权益
@property (assign, nonatomic) double m_dBalance;

//持仓盈亏
@property (assign, nonatomic) double m_dPositionProfit;

//平仓盈亏
@property (assign, nonatomic) double m_dCloseProfit;

//入金
@property (assign, nonatomic) double m_dDeposit;

//出金
@property (assign, nonatomic) double m_dWithdraw;

//占用保证金
@property (assign, nonatomic) double m_dCurrMargin;

//冻结保证金
@property (assign, nonatomic) double m_dFrozenMargin;

//手续费
@property (assign, nonatomic) double m_dCommission;

//冻结手续费
@property (assign, nonatomic) double m_dFrozenCommission;

//合约价值
@property (assign, nonatomic) double m_dInstrumentValue;

//币种
@property (assign, nonatomic) EMoneyType m_moneyType;

//可用
@property (assign, nonatomic) double m_dAvailable;


+(NSMutableArray *)getData : (MoneyDetailModel *)model;

@end
