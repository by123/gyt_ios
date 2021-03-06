
//
//  AppUtil.m
//  haihua
//
//  Created by by.huang on 16/3/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AppUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AppUtil

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 手机号码验证
+ (BOOL)checkTel:(NSString *)str

{
    if ([str length] == 0) {
        [ByToast showWarnToast:@"手机号码不能为空"];
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        [ByToast showWarnToast:@"请输入正确的手机号码"];
        return NO;
    }
    return YES;
}


#pragma 身份证号码验证
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma mark 获取文件md5
+(NSString*)fileMD5:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

#pragma mark 获取image的md5
+(NSString*)imageMD5:(UIImage*)image
{
 
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    NSData *fileData = UIImagePNGRepresentation(image);
    CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

+(NSTimeInterval)getCurrentTime
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    return [date timeIntervalSince1970]*1000;
}



+ (NSString*) sha1 : (NSString *)content
{
    const char *cstr = [content cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:content.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//普通字符串转换为十六进制的。

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

#pragma mark 改变image大小
+(UIImage*)transformImage : (UIImage *)image
                   width  : (CGFloat)width
                   height : (CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = image.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (CGFloat)pointValue:(CGFloat)pixel
{
    CGFloat deviceWidth = [[UIScreen mainScreen] bounds].size.width;
    
    if (deviceWidth == 320.0f) {
        return pixel;
    }
    else {
        return roundf(pixel * deviceWidth / 320.0f);
    }
}

+(NSString *)getFormatDate : (int)date
{
 
    NSString *dateStr = [NSString stringWithFormat:@"%d",date];
    if(dateStr.length == 8)
    {
        NSRange range;
        range.location = 0;
        range.length = 4;
        NSString *yearStr = [dateStr substringWithRange:range];
        
        range.location = 4;
        range.length = 2;
        NSString *monthStr = [dateStr substringWithRange:range];
        
        range.location = 6;
        range.length = 2;
        NSString *dayStr = [dateStr substringWithRange:range];
        
        return [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];

    }
    return @"错误日期格式";
}

+(NSString *)getFormatTime : (int)time
{
    NSString *timeStr = [NSString stringWithFormat:@"%d",time];
    while (true) {
        if(timeStr.length < 6)
        {
            timeStr = [@"0" stringByAppendingString:timeStr];
        }
        else
        {
            break;
        }
    }
    
    if(timeStr.length == 6)
    {
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *hourStr = [timeStr substringWithRange:range];
        
        range.location = 2;
        range.length = 2;
        NSString *minuteStr = [timeStr substringWithRange:range];
       
        range.location = 4;
        range.length = 2;
        NSString *secondStr = [timeStr substringWithRange:range];
        
        return [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];

    }
    
    return @"错误时间格式";
}

+(int)getFormatNow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *formatStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    if(IS_NS_STRING_EMPTY(formatStr))
    {
        NSLog(@"错误时间格式");
        return 0;
    }    
    return [formatStr integerValue];
}

+(NSString *)getNowStr
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}

+(NSString *)getNowTimeStr
{
    NSDate *currentDate = [NSDate date];//获取当前时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return  dateString;
}

+(NSString *)formateDate:(NSString *)dateStr
{
    if([dateStr length] == 10)
    {
        NSRange range = NSMakeRange(0, 4);
        NSString *year = [dateStr substringWithRange:range];
        range = NSMakeRange(5, 2);
        NSString *month = [dateStr substringWithRange:range];
        range = NSMakeRange(8, 2);
        NSString *day = [dateStr substringWithRange:range];
        NSString *dateStr = [NSString stringWithFormat:@"%@%@%@",year,month,day];
        
        return dateStr;
    }
    return nil;
}



//截取字符串中的一段汉字
+(NSString *)getChineseStringWithString:(NSString *)string
{
    int start = -1;
    int end = -1;
    //(unicode中文编码范围是0x4e00~0x9fa5)
    for (int i = 0; i < string.length; i++) {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange(i, 1);
        
        BOOL b = [string getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        
        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)) {
            if(start == -1)
            {
                start = i;
                end = start;
            }
            end++;
        }
    }
    if(end > start)
    {
        NSRange range = NSMakeRange(start, end-start+1);
        return [string substringWithRange:range];
    }
    return nil;
}

@end
