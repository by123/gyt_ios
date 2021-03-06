//
//  OrderModel.m
//  gyt
//
//  Created by by.huang on 16/5/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+(OrderModel *)buildOrderModel : (NSString *)m_strProductID
                  instrumentID : (NSString *)m_strInstrumentID
                    orderPrice : (double)m_dOrderPrice
                      orderNum : (int)m_nOrderNum
                     direction : (EEntrustBS)m_nDirection
                    offsetFlag : (EOffset_Flag_Type)m_nOffsetFlag
                     priceType : (EBrokerPriceType)m_eBrokerPriceType
{
    OrderTagModel *tagModel = [[OrderTagModel alloc]init];
    tagModel.m_strRequestId = [OrderTagModel generateRequestID];
    
    OrderModel *model = [[OrderModel alloc]init];
    model.m_strProductID = m_strProductID;
    model.m_strInstrumentID = m_strInstrumentID;
    model.m_dOrderPrice = m_dOrderPrice;
    model.m_nOrderNum = m_nOrderNum;
    model.m_nDirection = m_nDirection;
    model.m_nOffsetFlag = m_nOffsetFlag;
    model.m_eBrokerPriceType = BROKER_PRICE_LIMIT;
    model.m_nHedgeFlag = HEDGE_FLAG_SPECULATION;
    model.m_eBrokerPriceType = m_eBrokerPriceType;
    
    model.m_tag = tagModel;
    
    return model;
}


+(OrderModel *)buildOrderModel : (NSString *)m_strProductID
                  instrumentID : (NSString *)m_strInstrumentID
                    orderPrice : (double)m_dOrderPrice
                      orderNum : (int)m_nOrderNum
                     direction : (EEntrustBS)m_nDirection
                    offsetFlag : (EOffset_Flag_Type)m_nOffsetFlag
                     priceType : (EBrokerPriceType)m_eBrokerPriceType
                        stopTag: (StopValueTag *)m_stopTag
{
    OrderTagModel *tagModel = [[OrderTagModel alloc]init];
    tagModel.m_strRequestId = [OrderTagModel generateRequestID];
    
    OrderModel *model = [[OrderModel alloc]init];
    model.m_strProductID = m_strProductID;
    model.m_strInstrumentID = m_strInstrumentID;
    model.m_dOrderPrice = m_dOrderPrice;
    model.m_nOrderNum = m_nOrderNum;
    model.m_nDirection = m_nDirection;
    model.m_nOffsetFlag = m_nOffsetFlag;
    model.m_eBrokerPriceType = BROKER_PRICE_LIMIT;
    model.m_nHedgeFlag = HEDGE_FLAG_SPECULATION;
    model.m_eBrokerPriceType = m_eBrokerPriceType;
    model.m_stopTag = m_stopTag;
    
    model.m_tag = tagModel;
    
    return model;
}
@end
