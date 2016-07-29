//
//  TTPackage.m
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import "GYTPackage.h"
#import "NSData+XTAMData.h"
#import "NSMutableData+XTAMData.h"

@implementation GYTPackage

SINGLETON_IMPLEMENTION(GYTPackage);

-(instancetype)init
{
    if(self == [super init])
    {
        self.model = [[PackageModel alloc]init];
        self.model.cmd = NET_CMD_RPC;
    }
    return self;
}


- (PackageModel *)decodeJSON:(NSData *)data
{
    PackageModel *model = [[PackageModel alloc]init];
    model.len = [data readUInt:0];
    model.seq = [data readUInt:4];
    model.cmd = [data readUShort:8];
    model.tag = [data readUShort:10];
    
    NSData *jsondata = [data subdataWithRange:NSMakeRange(12, data.length - 12)];
    
    int compree = model.tag & 7;
    if (compree == COMPRESS_ZLIB || compree == COMPRESS_DOUBLE_ZLIB)
    {
        jsondata = [jsondata zlibDecompressed];
    }

    if (model.cmd == NET_CMD_RPC || model.cmd == NET_CMD_NOTIFICATION) {
        model.seq = ((int64_t)(model.tag >> 8) & 0x0f) << 32 | model.seq;
        
        NSData *udata = [jsondata zlibDecompressed];
        if (udata != nil) {
            jsondata = udata;
        }
        NSString *resultStr;
        resultStr = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        if (resultStr == nil) {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            resultStr = [[NSString alloc] initWithData:jsondata encoding:enc];
            if (resultStr == nil) {
              resultStr = [[NSString alloc] initWithData:jsondata encoding:NSASCIIStringEncoding];
              
            }
        }
        //最大值处理
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"1.797693134862316e+308" withString:@"0"];
        resultStr  = [resultStr stringByReplacingOccurrencesOfString:@"4.197936507034086e-006" withString:@"0"];
        model.result = resultStr;
    }
    jsondata = nil;
    return model;
}

- (NSData*)encodeJSON  : (NSData *)data
              requestid: (int)requestid
{
    _model.seq = requestid;
    _model.cmd = NET_CMD_RPC;
    if (_model.cmd == NET_CMD_KEEPALIVE)
    {
        data = [NSMutableData dataWithLength:4];
    }
    NSMutableData* mData = [NSMutableData dataWithCapacity:data.length + 12];
    [mData appendUInt:(uint32_t)data.length + 12];
    
    int flagSeq = (int)((_model.seq >> 32) & 0x0f) << 8;
    int tag = flagSeq;
    
    [mData appendUInt:(_model.seq & 0xffffffff)];
    
    [mData appendUShort:_model.cmd];
    [mData appendUShort:tag];
    [mData appendData:data];
    
    return mData;
}


- (NSData*)encodeAliveJSON  : (NSData *)data
              requestid: (int)requestid
{
    _model.cmd = requestid;
    _model.seq = GYT_ALIVE;
    NSMutableData* mData = [NSMutableData dataWithCapacity:data.length + 12];
    [mData appendUInt:(uint32_t)data.length + 12];
    
    int flagSeq = (int)((_model.seq >> 32) & 0x0f) << 8;
    int tag = flagSeq;
    
    [mData appendUInt:(_model.seq & 0xffffffff)];
    [mData appendUShort:_model.cmd];
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
