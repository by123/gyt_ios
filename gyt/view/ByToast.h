//
//  ByToast.h
//  gyt
//
//  Created by by.huang on 16/7/6.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,Level)
{
    //绿色
    Normal = 0,
    //橙色
    Warn = 1,
    //红色
    Error = 2
};

@interface ByToast : UIView

+(void)showNormalToast : (NSString *)content;

+(void)showWarnToast : (NSString *)content;

+(void)showErrorToast : (NSString *)content;

+(void)showToast : (NSString *)content
           level : (Level)level
        interval : (long)timeInterval;

@end
