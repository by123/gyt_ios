//
//  NSMutableData+XTAMData.m
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import "NSMutableData+XTAMData.h"

@implementation NSMutableData (XTAMData)

- (BOOL)appendByte:(int8_t)value {
    int8_t data[1];
    data[0] = value & 0xff;
    
    [self appendBytes:data length:1];
    return YES;
}

- (BOOL)appendUShort:(uint16_t)value {
    int8_t data[2];
    data[0] = (value & 0xff00) >> 8;
    data[1] = value & 0x00ff;
    
    [self appendBytes:data length:2];
    return YES;
}

- (BOOL)appendShort:(int16_t)value {
    int8_t data[2];
    data[0] = (value & 0xff00) >> 8;
    data[1] = value & 0x00ff;
    
    [self appendBytes:data length:2];
    return YES;
}

- (BOOL)appendUInt:(uint32_t)value {
    int8_t data[4];
    int currentpos = 0;
    data[currentpos++] = (int8_t)((value & 0xFF000000)>>24);
    data[currentpos++] = (int8_t)((value & 0x00FF0000)>>16);
    data[currentpos++] = (int8_t)((value & 0x0000FF00)>>8);
    data[currentpos++] = (int8_t)((value & 0x000000FF));
    
    [self appendBytes:data length:4];
    return YES;
}


- (BOOL)appendInt:(int32_t)value
{
    int8_t data[4];
    int currentpos = 0;
    data[currentpos++] = (int8_t)((value & 0xFF000000)>>24);
    data[currentpos++] = (int8_t)((value & 0x00FF0000)>>16);
    data[currentpos++] = (int8_t)((value & 0x0000FF00)>>8);
    data[currentpos++] = (int8_t)((value & 0x000000FF));
    
    [self appendBytes:data length:4];
    return YES;
}

- (BOOL)appendLong:(int64_t)value
{
    int8_t data[8];
    int currentpos = 0;
    
    data[currentpos++] = (int8_t)((value & 0xFF00000000000000LL)>>56);
    data[currentpos++] = (int8_t)((value & 0x00FF000000000000LL)>>48);
    data[currentpos++] = (int8_t)((value & 0x0000FF0000000000LL)>>40);
    data[currentpos++] = (int8_t)((value & 0x000000FF00000000LL)>>32);
    data[currentpos++] = (int8_t)((value & 0x00000000FF000000LL)>>24);
    data[currentpos++] = (int8_t)((value & 0x0000000000FF0000LL)>>16);
    data[currentpos++] = (int8_t)((value & 0x000000000000FF00LL)>>8);
    data[currentpos++] = (int8_t)((value & 0x00000000000000FFLL));
    
    [self appendBytes:data length:8];
    return YES;
}

- (BOOL)appendUTF8String:(NSString*)string {
    if ( string.length > 0) {
        NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
        [self appendShort:data.length];
        [self appendData:data];
    }
    else
    {
        [self appendShort:0];
    }
    return YES;
}


@end
