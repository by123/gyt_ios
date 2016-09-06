//
//  AppUtil.h
//  haihua
//
//  Created by by.huang on 16/3/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (BOOL)checkTel:(NSString *)str;

+ (BOOL)checkUserIdCard: (NSString *) idCard;

+(NSString*)imageMD5:(UIImage*)image;

+(NSString*)fileMD5:(NSString*)path;

+(NSTimeInterval )getCurrentTime;

+ (NSString*) sha1 : (NSString *)content;

+(NSString *)hexStringFromString:(NSString *)string;


+(UIImage*)transformImage : (UIImage *)image
                   width  : (CGFloat)width
                   height : (CGFloat)height;

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (CGFloat)pointValue:(CGFloat)pixel;


+(NSString *)getFormatDate : (int)date;

+(NSString *)getFormatTime : (int)time;

+(NSString *)formateDate : (NSString *)dateStr;

+(int)getFormatNow;

+(NSString *)getNowStr;

+(NSString *)getNowTimeStr;

+(NSString *)getChineseStringWithString:(NSString *)string;

@end
