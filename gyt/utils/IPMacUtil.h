//
//  IPMacUtil.h
//  gyt
//
//  Created by by.huang on 16/5/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPMacUtil : NSObject

+ (NSString *)getIPAddress;


//已弃用
+ (NSString *) getMacAddress;


@end
