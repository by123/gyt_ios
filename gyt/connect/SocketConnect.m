;//
//  SocketConnect.m
//  gyt
//
//  Created by by.huang on 16/5/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SocketConnect.h"
#import "NSData+XTAMData.h"
#import "NSMutableData+XTAMData.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RightMenuViewController.h"
#import "Test.h"


#define HEAD_TAG      666
#define BODY_TAG      667
#define HEAD_LENGTH   12
#define TimeOut  (-1)


@interface SocketConnect ()


@end


@implementation SocketConnect
{
    __weak MBProgressHUD *hua;
    NSMutableData *curFrameData;
    int32_t curFrameLength;
    dispatch_queue_t processQueue;
    Boolean initiative;
}


SINGLETON_IMPLEMENTION(SocketConnect);

-(instancetype)init
{
    if(self == [super init])
    {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        processQueue =  dispatch_queue_create("GYTSocket_processQueue", NULL);

    }
    return self;
}

#pragma mark - 连接到服务器
-(void)connect
{
    NSError *error = nil;
    NSString *host = [[Test sharedTest] host];
    int port = [[Test sharedTest] port];
    if(_clientSocket == nil)
    {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    [_clientSocket connectToHost:host onPort:port error:&error];
    if(error)
    {
        NSLog(@"发起tcp失败");
    }
    else{
        NSLog(@"发起tcp成功->host:%@->port:%d",host,port);
    }
}

#pragma mark - 连接到服务器
-(void)connect : (NSString *)host
          port : (int)port
{
    NSError *error = nil;
    [_clientSocket connectToHost:host onPort:port error:&error];
    if(error)
    {
        NSLog(@"发起tcp失败");
    }
    else{
        NSLog(@"发起tcp成功->host:%@->port:%d",host,port);
    }
}


#pragma mark 主动断开连接
-(void)disconnect
{
    if(_clientSocket)
    {
        [_clientSocket disconnect];
        if(self.delegate)
        {
            @try {
                [self.delegate OnConnectFail];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    }
}


#pragma mark - 判断与服务器是否正确链接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [sock readDataWithTimeout:TimeOut tag:0];
    if(self.delegate)
    {
        [self.delegate OnConnectSuccess];
    }
    if(hua)
    {
        [hua hide:YES];
    }
}


#pragma mark - 连接被断开
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if(self.delegate)
    {
        @try {
            if(![self isConnect])
            {
                curFrameLength = INT_MAX;
                curFrameData = nil;
                [self.delegate OnConnectFail];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}


#pragma mark - 接收服务端的数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (curFrameData == nil) {
        curFrameData = [NSMutableData dataWithData:data];
        curFrameLength = INT_MAX;
    } else {
        [curFrameData appendData:data];
    }
    if (curFrameLength == INT_MAX && curFrameData.length > 3) {
        curFrameLength = [curFrameData readInt:0];
    }
    
    while ( curFrameData.length >= curFrameLength) {
        NSData *tmp = [curFrameData subdataWithRange:NSMakeRange(0, curFrameLength)];
        dispatch_async(processQueue, ^{
            PackageModel *model = [[GYTPackage sharedGYTPackage]decodeJSON:tmp];
            if(model)
            {
                if (model.cmd == NET_CMD_RPC || model.cmd == NET_CMD_NOTIFICATION)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate OnReceiveSuccess:model];
                    });
                }
                else if(model.cmd == NET_CMD_KEEPALIVE_RESPONSE)
                {
                    NSLog(@"保活包接收成功");
                }
            }

        });
        if (curFrameData.length == curFrameLength) {
            curFrameData = nil;
            curFrameLength = INT_MAX;
        } else {
            curFrameData = [NSMutableData dataWithData:[curFrameData subdataWithRange:NSMakeRange(curFrameLength, curFrameData.length - curFrameLength)]];
            if (curFrameData.length > 3) {
                curFrameLength = [curFrameData readInt:0];
            } else {
                curFrameLength = INT_MAX;
            }
        }
    }
    
    [sock readDataWithTimeout:TimeOut tag:0];
    

}


-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
//    NSLog(@"长度－>%d",partialLength);
}


-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
//    NSLog(@"发送数据成功");
}

#pragma mark - 发送数据给服务端
-(void)sendData : (NSString *)content
            seq : (int)seq
{
    if(_clientSocket.isConnected)
    {
        NSData *data =[[GYTPackage sharedGYTPackage]encodeJSON:[content dataUsingEncoding:NSUTF8StringEncoding] requestid:seq];
        [_clientSocket writeData:data withTimeout:TimeOut tag:0];
    }
    else
    {
        if(_delegate)
        {
            [_delegate OnConnectFail];
        }
    }

}

#pragma mark - 发送保活包
-(void)sendAlive
{
    NSData *data =[[GYTPackage sharedGYTPackage]encodeAliveJSON:nil requestid:NET_CMD_KEEPALIVE];
    [_clientSocket writeData:data withTimeout:TimeOut tag:100];
}


#pragma mark - 检测是否连接上
-(BOOL)isConnect
{
    if(_clientSocket)
    {
        return _clientSocket.isConnected;
    }
    return NO;
}


@end
