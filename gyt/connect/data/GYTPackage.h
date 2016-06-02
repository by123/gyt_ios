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


const static int COMPRESS_NONE               = 0;
const static int COMPRESS_ZLIB               = 1;
const static int COMPRESS_DOUBLE_ZLIB        = 2;

@interface GYTPackage : NSObject

SINGLETON_DECLARATION(GYTPackage);

@property (strong, nonatomic)PackageModel *model;

- (PackageModel *)decodeJSON:(NSData*)data;

- (NSData*)encodeJSON  : (NSData *)data
              requestid: (int)requestid;


@end
