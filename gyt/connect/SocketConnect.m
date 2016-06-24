//
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


@interface SocketConnect ()


@end


@implementation SocketConnect
{
    __weak MBProgressHUD *hua;
    NSMutableData *_curFrameData;
    int32_t _curFrameLength;
    dispatch_queue_t _processQueue;
    Boolean initiative;
}


SINGLETON_IMPLEMENTION(SocketConnect);

-(instancetype)init
{
    if(self == [super init])
    {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _processQueue =  dispatch_queue_create("XTAMSocketClient.processQueue", NULL);

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
        NSLog(@"发起tcp成功");
    }
}


#pragma mark 主动断开连接
-(void)disconnect
{
    if(_clientSocket)
    {
        [_clientSocket disconnect];
        [self connectInterrupt];
    }
}


#pragma mark - 判断与服务器是否正确链接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [sock readDataWithTimeout:-1 tag:0];
    NSLog(@"已连接上");
    if(self.delegate)
    {
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate OnConnectSuccess];
//        });
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
        [DialogHelper showTips:@"连接被强制断开"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.delegate OnConnectFail];
//        });
    }
    [self connectInterrupt];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self connect];
        NSLog(@"重新连接");
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIWindow *window = delegate.window;
        LoginViewController *mainViewController =[[LoginViewController alloc]init];
        SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:mainViewController];
        RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
        rightMenu.view.backgroundColor = BACKGROUND_COLOR;
        rightMenu.controller = controller;
        
        controller.leftMenu = rightMenu;
        window.rootViewController = controller;
        [window makeKeyAndVisible];
    }

}

#pragma mark - 接收服务端的数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (_curFrameData == nil) {
        _curFrameData = [NSMutableData dataWithData:data];
        _curFrameLength = INT_MAX;
    } else {
        [_curFrameData appendData:data];
    }
    if (_curFrameLength == INT_MAX && _curFrameData.length > 3) {
        _curFrameLength = [_curFrameData readInt:0];
    }
    
    while ( _curFrameData.length >= _curFrameLength) {
        NSData *tmp = [_curFrameData subdataWithRange:NSMakeRange(0, _curFrameLength)];
        dispatch_async(_processQueue, ^{
            PackageModel *model = [[GYTPackage sharedGYTPackage]decodeJSON:tmp];
            if (model && (model.cmd == NET_CMD_RPC || model.cmd == NET_CMD_NOTIFICATION)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate OnReceiveSuccess:model];
                });
            }
        });
        if (_curFrameData.length == _curFrameLength) {
            _curFrameData = nil;
            _curFrameLength = INT_MAX;
        } else {
            _curFrameData = [NSMutableData dataWithData:[_curFrameData subdataWithRange:NSMakeRange(_curFrameLength, _curFrameData.length - _curFrameLength)]];
            if (_curFrameData.length > 3) {
                _curFrameLength = [_curFrameData readInt:0];
            } else {
                _curFrameLength = INT_MAX;
            }
        }
    }
    
    [sock readDataWithTimeout:-1 tag:0];

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
    NSData *data =[[GYTPackage sharedGYTPackage]encodeJSON:[content dataUsingEncoding:NSUTF8StringEncoding] requestid:seq];
    [_clientSocket writeData:data withTimeout:-1 tag:0];
}

#pragma mark - 断开弹出提示
-(void)connectInterrupt
{
    NSLog(@"连接被断开");
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"连接失败" message:@"您已经与服务器断开连接，请点击确定重新连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    });
}


@end
