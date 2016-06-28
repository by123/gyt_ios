//
//  NSString+Contains.m
//  gyt
//
//  Created by by.huang on 16/6/28.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

@end