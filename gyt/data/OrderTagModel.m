//
//  OrderTagModel.m
//  gyt
//
//  Created by by.huang on 16/5/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "OrderTagModel.h"
#import "AppUtil.h"
@implementation OrderTagModel

+(NSString *)generateRequestID
{
    NSString *uid = [[Account sharedAccount]getUid];
    NSString *currentTime = [NSString stringWithFormat:@"%.f",[AppUtil getCurrentTime]];
    NSString *result = [uid stringByAppendingString:currentTime];
    return result;
}

@end
