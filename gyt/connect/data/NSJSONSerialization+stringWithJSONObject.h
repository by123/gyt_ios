//
//  NSJSONSerialization+dataWithJSONObject.h
//  AssetsManagement
//
//  Created by 刘昆鹏 on 9/22/15.
//  Copyright © 2015 thinktrader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (stringWithJSONObject)

+ (nullable NSString *)stringWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error;

@end
