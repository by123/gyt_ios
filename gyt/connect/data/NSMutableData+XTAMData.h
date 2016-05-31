//
//  NSMutableData+XTAMData.h
//  AssetsManagement
//
//  Created by liukunpeng on 12/31/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (XTAMData)

- (BOOL)appendByte:(int8_t)value;
- (BOOL)appendShort:(int16_t)value;
- (BOOL)appendInt:(int32_t)value;
- (BOOL)appendLong:(int64_t)value;
- (BOOL)appendUTF8String:(NSString*)string;

- (BOOL)appendUInt:(uint32_t)value;
- (BOOL)appendUShort:(uint16_t)value;


@end
