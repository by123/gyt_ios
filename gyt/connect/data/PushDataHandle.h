//
//  PushDataHandle.h
//  gyt
//
//  Created by by.huang on 16/6/7.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushDataHandleDelegate

//处理完成后结果
@optional -(void)pushResult : (id)data;

@end

@interface PushDataHandle : NSObject

SINGLETON_DECLARATION(PushDataHandle)

@property (strong, nonatomic) id delegate;

-(void)handlePushData : (NSString *)jsonStr;

-(void)handlePushData : (NSString *)jsonStr
             delegate : (id)delegate;
@end
