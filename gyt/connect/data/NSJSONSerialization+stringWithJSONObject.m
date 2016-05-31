//
//  NSJSONSerialization+dataWithJSONObject.m
//  AssetsManagement
//
//  Created by 刘昆鹏 on 9/22/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import "NSJSONSerialization+stringWithJSONObject.h"

@implementation NSJSONSerialization (stringWithJSONObject)

+ (nullable NSString *)stringWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error {
    NSData* data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:error];
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

@end
