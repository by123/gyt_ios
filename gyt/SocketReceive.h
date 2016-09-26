//
//  SocketReceive.h
//  gyt
//  处理全局主推数据
//  Created by by.huang on 16/7/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PushQuoteData @"pushQuoteData"
#define PushData @"pushData"
#define LoginData @"loginData"
#define UserDetailData @"userDetailData"
#define AccountDetailData @"accountDetailData"
#define InstrumentDetailData @"instrumentDetailData"
#define CommitCashApplyInfoData @"commitCashApplyInfoData"
#define CashApplyInfoData @"cashApplyInfoData"
#define KLineData @"kLineData"

#define PositionStaticsData @"positionStaticsData"
#define OrderDetailData @"orderDetailData"
#define DealDetailData @"dealDetailData"
#define OrderData @"orderData"
#define CancelData @"cancelData"
#define HistoryData @"historyData"
#define LossData @"lossData"


#define ConnectSuccess @"connectSuccess"
#define ConnectFail @"connectFail"

@interface SocketReceive : NSObject


@end
