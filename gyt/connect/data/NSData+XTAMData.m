//
//  NSData+XTAMData.m
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import "NSData+XTAMData.h"

#import "zlib.h"

@implementation NSData (XTAMData)



- (int8_t)readByte:(int32_t)position {
    int8_t value = 0;
    
    int8_t data[1];
    [self getBytes:data range:NSMakeRange(position, 1)];
    
    value |= (data[0] & 0xFF);
    
    return value;
}

- (int16_t)readShort:(int32_t)position {
    int16_t value = 0;
    
    int8_t data[2];
    [self getBytes:data range:NSMakeRange(position, 2)];
    
    int currentpos = 0;
    
    value |= (data[currentpos++] & 0xFF) << 8;
    value |= (data[currentpos++] & 0xFF);
    
    return value;
}

- (int32_t)readInt:(int32_t)position {
    int32_t value = 0;
    
    int8_t data[4];
    [self getBytes:data range:NSMakeRange(position, 4)];
    
    int currentpos = 0;
    
    value |= (data[currentpos++] & 0xFF) << 24;
    value |= (data[currentpos++] & 0xFF) << 16;
    value |= (data[currentpos++] & 0xFF) << 8;
    value |= (data[currentpos++] & 0xFF);
    
    return value;
}
- (uint16_t)readUShort:(int32_t)position {
    uint16_t value = 0;
    
    int8_t data[2];
    [self getBytes:data range:NSMakeRange(position, 2)];
    
    int currentpos = 0;
    
    value |= (data[currentpos++] & 0xFF) << 8;
    value |= (data[currentpos++] & 0xFF);
    
    return value;
}

- (uint32_t)readUInt:(int32_t)position {
    uint32_t value = 0;
    
    int8_t data[4];
    [self getBytes:data range:NSMakeRange(position, 4)];
    
    int currentpos = 0;
    
    value |= (data[currentpos++] & 0xFF) << 24;
    value |= (data[currentpos++] & 0xFF) << 16;
    value |= (data[currentpos++] & 0xFF) << 8;
    value |= (data[currentpos++] & 0xFF);
    
    return value;
}

- (int64_t)readLong:(int32_t)position {
    int64_t value = 0;
    
    int8_t data[8];
    [self getBytes:data range:NSMakeRange(position, 8)];
    
    int currentpos = 0;
    int64_t tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 56;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 48;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 40;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 32;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 24;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 16;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF) << 8;
    tmp = data[currentpos++];
    value |= (tmp & 0xFF);
    
    return value;
}
- (NSString*)readUTF8String:(int32_t)position length:(NSNumber**)length {
    int16_t _length = [self readShort:position];
    *length = [NSNumber numberWithInt:_length + 2];
    NSData *data = [self subdataWithRange:NSMakeRange(position + 2, _length)];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *) zlibDecompressed {
    if ([self length] == 0) return self;
    
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = [self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit (&strm) != Z_OK) return nil;
    
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    } else {
        return nil;
    }
}

@end
