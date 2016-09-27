//
//  PushDataHandle.m
//  gyt
//
//  Created by by.huang on 16/6/7.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "PushDataHandle.h"
#import "MoneyDetailModel.h"
#import "DealHoldByModel.h"
#import "DealProfitModel.h"
#import "DealHoldModel.h"
#import "PushModel.h"
#import "StopLossModel.h"

@implementation PushDataHandle

SINGLETON_IMPLEMENTION(PushDataHandle)

-(void)handlePushData : (NSString *)jsonStr
{
    [self handlePushData:jsonStr delegate:_delegate];
}

-(void)handlePushData : (NSString *)jsonStr
             delegate : (id)delegate
{
    BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:jsonStr];
    NSString *method = model.method;
    if([method isEqualToString:@"pushData"])
    {
        id params = model.params;
        id data = [params objectForKey:@"data"];
        long typeId = [[data objectForKey:@"_typeId"] longValue];
        id result;
        switch (typeId) {
            case XT_CAccountDetail:
                result = [self handleMoneyDetail:data];
                break;
            case XT_COrderDetail:
                result = [self handleDealHoldByModel:data];
                break;
            case XT_CDealDetail:
                result = [self handleDealProfitModel:data];
                break;
            case XT_CPositionStatics:
                result = [self handleDealModel:data];
                break;
            case XT_CStopProfitLossSInfo:
                result = [self handleStopLossModel:data];
                break;
                
            default:
                break;
        }
        if(delegate)
        {
            [delegate pushResult:result];
        }
    }
    else if([method isEqualToString:@"pushQuoteData"])
    {
        id params = model.params;
        id data  = [params objectForKey:@"data"];
        id result = [self handlePushModel:data];
        if(delegate)
        {
            [delegate pushResult:result];
        }

    }
    
}


-(MoneyDetailModel *)handleMoneyDetail : (id)data
{
    MoneyDetailModel *moneyDetaiModel =  [MoneyDetailModel mj_objectWithKeyValues:data];
    [[NSUserDefaults standardUserDefaults]setValue:moneyDetaiModel.mj_JSONString forKey:MoneyInfo];
    return moneyDetaiModel;
}


-(DealHoldByModel *)handleDealHoldByModel : (id)data
{
    DealHoldByModel *dealByModel = [DealHoldByModel mj_objectWithKeyValues:data];
    return dealByModel;
}

-(DealProfitModel *)handleDealProfitModel : (id)data
{
    DealProfitModel *dealProfitModel = [DealProfitModel mj_objectWithKeyValues:data];
    return dealProfitModel;
}

-(DealHoldModel *)handleDealModel : (id)data
{
    DealHoldModel *dealHoldModel = [DealHoldModel mj_objectWithKeyValues:data];
    return dealHoldModel;

}


-(StopLossModel *)handleStopLossModel : (id)data
{
    StopLossModel *lossModel = [StopLossModel mj_objectWithKeyValues:data];
    return lossModel;
    
}

-(PushModel *)handlePushModel : (id)data
{
    PushModel *pushModel = [PushModel mj_objectWithKeyValues:data];
    return pushModel;
}

@end
