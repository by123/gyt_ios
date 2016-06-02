#import "Constant.h"

//
//  Constant.m
//
//  Created by mark.zhang on 6/5/15.
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

@implementation Constant

+(NSString *)EEntrustBSStr : (EEntrustBS) entrust
{
    switch (entrust) {
        case ENTRUST_BUY:
            return Buy;
        case ENTRUST_SELL:
            return Sell;
        default:
            break;
    }
    return @"";
}


+(NSString *)EHedge_Flag_TypeStr:(EHedge_Flag_Type)flagType
{
    switch (flagType) {
        case HEDGE_FLAG_SPECULATION:
            return @"投机";
        case HEDGE_FLAG_ARBITRAGE:
            return @"套利";
        case HEDGE_FLAG_HEDGE:
            return @"套保";
        default:
            break;
    }
    return @"";
}


+(NSString *)EEntrustStatusStr : (EEntrustStatus)statu
{
    switch (statu) {
            case ENTRUST_STATUS_WAIT_END:
             //委托状态已经在ENTRUST_STATUS_CANCELED或以上，但是成交数额还不够，等成交回报来
            return @"";
        case ENTRUST_STATUS_UNREPORTED:
            return @"未报";
        case ENTRUST_STATUS_WAIT_REPORTING:
            return @"待报";
        case ENTRUST_STATUS_REPORTED:
            return @"已报";
        case ENTRUST_STATUS_REPORTED_CANCEL:
            return @"已报待撤";
        case ENTRUST_STATUS_PARTSUCC_CANCEL:
            return @"部成待撤";
        case ENTRUST_STATUS_PART_CANCEL:
            return @"部撤";
        case ENTRUST_STATUS_CANCELED:
            return @"已撤";
        case ENTRUST_STATUS_PART_SUCC:
            return @"部成";
        case ENTRUST_STATUS_SUCCEEDED:
            return @"已成";
        case ENTRUST_STATUS_JUNK:
            return @"废单";
        case ENTRUST_STATUS_UNKNOWN:
            return @"未知";
    }
    return @"未知";
}

@end