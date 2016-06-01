//
//  SocketConnect.h
//  gyt
//
//  Created by by.huang on 16/5/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@protocol SocketConnectDelegate

//接收数据成功
@optional -(void)OnReceiveSuccess : (id)respondObject;

//接收数据失败
@optional -(void)OnReceiveFail : (NSError *)error;

//连接成功
@optional -(void)OnConnectSuccess;

//断开连接
@optional -(void)OnConnectFail;


@end

@interface SocketConnect : NSObject<GCDAsyncSocketDelegate>

SINGLETON_DECLARATION(SocketConnect);

@property (retain , nonatomic) GCDAsyncSocket *clientSocket;

@property (strong , nonatomic) id delegate;

-(void)connect;

-(void)sendData : (NSString *)content
       delegate : (id)delegate
            seq : (int)seq;

@end
