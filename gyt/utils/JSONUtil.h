//
//  JSONUtil.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtil : NSObject


#pragma mark 基本格式，模型转json
+(NSString *)parse : (NSString *)name
              params: (NSMutableDictionary *)params;


#pragma mark 自定义模型转dic
+(NSMutableDictionary *)parseStr : (NSObject *)model;

@end
