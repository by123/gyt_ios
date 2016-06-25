//
//  SocketConnect.h
//  gyt
//
//  Created by by.huang on 16/5/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "BaseViewController.h"

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

@interface SocketConnect : NSObject<GCDAsyncSocketDelegate,UIAlertViewDelegate>

SINGLETON_DECLARATION(SocketConnect);

@property (retain , nonatomic) GCDAsyncSocket *clientSocket;

@property (strong , nonatomic) id delegate;

@property (strong, nonatomic) BaseViewController *controller;

-(void)connect;

-(void)connect : (NSString *)host
          port : (int)port;

-(void)disconnect;

-(void)sendData : (NSString *)content
            seq : (int)seq;

@end
