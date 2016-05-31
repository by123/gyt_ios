//
//  TTPackage.m
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import "TTPackage.h"
#import "NSData+XTAMData.h"
#import "NSMutableData+XTAMData.h"
#import "NSJSONSerialization+stringWithJSONObject.h"

@implementation TTPackage

+ (instancetype)initPackage {
    TTPackage *package = [[TTPackage alloc] init];
    package.cmd = NET_CMD_RPC;
    return package;
}

+ (instancetype)packageWithCmd:(uint16_t)cmd {
    TTPackage *package = [[TTPackage alloc] init];
    package.cmd = cmd;
    return package;
}

- (NSString *)decodeJSON:(NSData *)data {
    uint32_t len = [data readUInt:0];
    int64_t seq = [data readUInt:4];
    uint16_t cmd = [data readUShort:8];
    uint16_t tag = [data readUShort:10];
    
    NSData *jsondata = [data subdataWithRange:NSMakeRange(12, data.length - 12)];
    if ( cmd == NET_CMD_RPC || cmd == NET_CMD_NOTIFICATION) {
        seq = ((int64_t)(tag >> 8) & 0x0f) << 32 | seq;
        
        NSData *udata = [jsondata zlibDecompressed];
        if (udata != nil) {
            jsondata = udata;
        }
        //<<log
        NSString *string;
        string = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        if (!IS_NS_STRING_EMPTY(string)) {
            return string;
        }
//        if (cmd == NET_CMD_NOTIFICATION) {
////            NSLog(@"decodeJSON:[push] seq[%lld] %@", seq, string);
//        } else {
////            NSLog(@"decodeJSON:seq[%lld] %@", seq, string);
//        }
//        //>>
//        NSError* error;
//        NSDictionary *dict = [jsondata mj_keyValues];
//
////        NSDictionary *dict = ([jsondata objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&error]);
//        if (error != nil) {
////            NSLog(@"error 1 - dict - %@ jsondata - %@", dict, jsondata);
//            NSLog(@"TTPackage decodeJSON error 1:%@", error);
//        }
//        if (dict == nil) {
//            error = nil;
//            dict = [string mj_keyValues];
////            dict = [string objectFromJSONStringWithParseOptions:JKParseOptionStrict error:&error];
////            dict = ([[string dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&error]);
//            if (error != nil) {
//                NSLog(@"TTPackage decodeJSON error 2:%@", error);
//            }
//        }
//        TTPackage *package = [[TTPackage alloc] init];
//        package.seq = seq;
//        package.cmd = cmd;
//        package.dict = dict;
//        return package;
//    } else if (cmd == NET_CMD_KEEPALIVE_RESPONSE) {
//        NSLog(@"keep alive response");
//        seq = ((int64_t)(tag >> 8) & 0x0f) << 32 | seq;
//        TTPackage *package = [[TTPackage alloc] init];
//        package.seq = seq;
//        package.cmd = cmd;
//        return package;
//    }
    }
    return nil;
}

- (NSData*)encodeJSON  : (NSData *)data{
//    NSLog(@"encodeJSON: seq[%lld] %@", self.seq, self.dict);
    if (self.cmd == NET_CMD_KEEPALIVE) {
        data = [NSMutableData dataWithLength:4];
    } else {
//        data = [NSJSONSerialization dataWithJSONObject:self.dict options:kNilOptions error:nil];
    }
    NSMutableData* mData = [NSMutableData dataWithCapacity:data.length + 12];
    [mData appendUInt:(uint32_t)data.length + 12];
    
    int flagSeq = (int)((self.seq >> 32) & 0x0f) << 8;
    int tag = flagSeq;
    
    [mData appendUInt:(self.seq & 0xffffffff)];
    
    [mData appendUShort:self.cmd];
    [mData appendUShort:tag];
    [mData appendData:data];
    
    return mData;
}
//
//- (NSData*)encodeBSON {
//    
//    if (self.cmd == NET_CMD_KEEPALIVE) {
//        NSData* data = [NSMutableData dataWithLength:4];
//        NSMutableData* mData = [NSMutableData dataWithCapacity:data.length + 12];
//        [mData appendUInt:(uint32_t)data.length + 12];
//        
//        int flagSeq = (int)((self.seq >> 32) & 0x0f) << 8;
//        int tag = flagSeq;
//        
//        [mData appendUInt:(self.seq & 0xffffffff)];
//        
//        [mData appendUShort:self.cmd];
//        [mData appendUShort:tag];
//        [mData appendData:data];
//        
//        return mData;
//    } else {
//        NSString* jsonString = [NSJSONSerialization stringWithJSONObject:self.dict options:kNilOptions error:nil];
//        NSData* boData = [XTBsonHelper json2bson:jsonString];
//        
////        NSLog(@"%@", [XTBsonHelper bson2json:[boData bytes]] );
//        NSMutableData* mData = [NSMutableData dataWithCapacity:boData.length + 12];
//        [mData appendUInt:(uint32_t)boData.length + 12];
//        
//        int flagSeq = (int)((self.seq >> 32) & 0x0f) << 8;
//        int tag = flagSeq;
//        
//        [mData appendUInt:(self.seq & 0xffffffff)];
//        
//        [mData appendUShort:self.cmd];
//        [mData appendUShort:tag];
//        [mData appendData:boData];
//        
//        return mData;
//    }
//    
//}
//
//
//+ (instancetype)decodeBSON:(NSData *)data {
//    uint32_t len = [data readUInt:0];
//    int64_t seq = [data readUInt:4];
//    uint16_t cmd = [data readUShort:8];
//    uint16_t tag = [data readUShort:10];
//    
//    if ( cmd == NET_CMD_RPC || cmd == NET_CMD_NOTIFICATION) {
//        seq = ((int64_t)(tag >> 8) & 0x0f) << 32 | seq;
//        
//        NSData *boData = [data subdataWithRange:NSMakeRange(12, data.length - 12)];
//        //        bson::bo bo((char*)[boData bytes]);
//        //        NSLog(@"%s", bo.jsonString().c_str());
//        //
//        //
//        //        bson::bo res = p4delta::p4deltaDecompress(bo.getObjectField("params"));
//        //        NSLog(@"%s", res.jsonString().c_str());
//        //
//        //        vector<quoter::QuoterBasePtr> vNewData;
//        //        bool bret = p4delta::p4deltaDecompressNew("SH", "600000", 3001, bo.getObjectField("params"), vNewData, 0.01);
//        
//        NSError* error;
//        TTPackage *package = [[TTPackage alloc] init];
//        package.seq = seq;
//        package.cmd = cmd;
//        //        package.dict = dict;
//        package.data = boData;
//        return package;
//    } else if (cmd == NET_CMD_KEEPALIVE_RESPONSE) {
//        NSLog(@"keep alive response");
//        seq = ((int64_t)(tag >> 8) & 0x0f) << 32 | seq;
//        TTPackage *package = [[TTPackage alloc] init];
//        package.seq = seq;
//        package.cmd = cmd;
//        return package;
//    }
//    return nil;
//}


@end
