//
//  NSData+XTAMData.h
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XTAMData)

- (int8_t)readByte:(int32_t)position;
- (int16_t)readShort:(int32_t)position;
- (uint16_t)readUShort:(int32_t)position;
- (int32_t)readInt:(int32_t)position;
- (uint32_t)readUInt:(int32_t)position;
- (int64_t)readLong:(int32_t)position;
- (NSString*)readUTF8String:(int32_t)position length:(NSNumber**)length;
- (NSData*)zlibDecompressed;

@end
