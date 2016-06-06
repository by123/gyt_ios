//
//  OrderModel.h
//  gyt
//
//  Created by by.huang on 16/5/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderTagModel.h"
#import "OrderRespondModel.h"

@interface OrderModel : NSObject


//账号信息
@property (strong , nonatomic) UserInfoModel *m_accountInfo;

//交易所ID
@property (copy, nonatomic) NSString *m_strExchangeID;

//品种代码
@property (copy, nonatomic) NSString *m_strProductID;

//合约代码1
@property (copy, nonatomic) NSString *m_strInstrumentID;

//下单时间
@property (assign , nonatomic) long m_dOrderTime;

//撤单时间
@property (assign , nonatomic) long m_dCancelTime;

//完成时间
@property (assign , nonatomic) long m_dCompleteTime;

//委托价格1
@property (assign, nonatomic) double m_dOrderPrice;

//委托数量1
@property (assign , nonatomic) int m_nOrderNum;

//已成数量
@property (assign , nonatomic) int m_nBusinessNum;

//成交金额
@property (assign , nonatomic) double m_dDealMoney;

//买卖1
@property (assign, nonatomic) EEntrustBS m_nDirection;

//开平1
@property (assign, nonatomic) EOffset_Flag_Type m_nOffsetFlag;

//委托属性（市价or限价）
@property (assign, nonatomic) EBrokerPriceType m_eBrokerPriceType;

//投机
@property (assign, nonatomic) EHedge_Flag_Type m_nHedgeFlag;

//预冻结保证金(orderinfo预冻结的保证金 默认是非法值，如果使用的时候遇到，可以做计算，如果是0，说明委托已经拿到detail了，这样就有冻结而不是预冻结)
@property (assign, nonatomic) double m_dFrozenMargin;

//委托附加信息
@property (strong, nonatomic) OrderTagModel *m_tag;


+(OrderModel *)buildOrderModel : (NSString *)m_strInstrumentID
                    orderPrice : (double)m_dOrderPrice
                      orderNum : (int)m_nOrderNum
                     direction : (EEntrustBS)m_nDirection
                    offsetFlag : (EOffset_Flag_Type)m_nOffsetFlag;


@end
