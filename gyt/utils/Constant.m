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
            return More;
        case ENTRUST_SELL:
            return Less;
        default:
            break;
    }
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
}

@end