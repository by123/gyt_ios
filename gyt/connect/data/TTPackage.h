//
//  TTPackage.h
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import <Foundation/Foundation.h>

const static int NET_CMD_UNKOWN              = 0;
const static int NET_CMD_KEEPALIVE           = 1;
const static int NET_CMD_QUOTER              = 2;
const static int NET_CMD_RPC                 = 3;
const static int NET_CMD_NOTIFICATION        = 4;
const static int NET_CMD_VSS_MARKET_STATUS   = 5;
const static int NET_CMD_VSS_QUOTE           = 6;
const static int NET_CMD_COMMODITY_FUTURE    = 7;
const static int NET_CMD_KEEPALIVE_RESPONSE  = 8;


@interface TTPackage : NSObject

@property (nonatomic, assign) uint32_t  len;
@property (nonatomic, assign) int64_t   seq;
@property (nonatomic, assign) uint16_t  cmd;

//for json package
@property (nonatomic, strong) NSDictionary *dict;

//for bson package
@property (nonatomic, strong) NSData* data;

+ (instancetype)initPackage;
+ (instancetype)packageWithCmd:(uint16_t)cmd;

- (NSString *)decodeJSON:(NSData*)data;
- (NSData*)encodeJSON  : (NSData *)data;

//+ (instancetype)decodeBSON:(NSData *)data;
//- (NSData*)encodeBSON;

@end
