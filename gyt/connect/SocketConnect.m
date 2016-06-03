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
    [_clientSocket connectToHost:Host onPort:Port error:&error];
    if(error)
    {
        NSLog(@"发起tpc失败");
    }
    else{
        NSLog(@"发起tpc连接成功");
    }
}


#pragma mark 主动断开连接
-(void)disconnect
{
    if(_clientSocket)
    {
        [_clientSocket disconnect];
    }
}

#pragma mark - 判断与服务器是否正确链接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [sock readDataWithTimeout:-1 tag:0];
    NSLog(@"已连接上");
//    if(self.delegate)
//    {
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [self.delegate OnConnectSuccess];
//        }];
//    }
    if(hua)
    {
        [hua hide:YES];
    }
}


#pragma mark - 连接被断开
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"连接被断开");
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您的网络有问题" message:@"是否重新连接？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
//        UIApplication *application = [UIApplication sharedApplication];
//        hua = [MBProgressHUD showHUDAddedTo: animated:YES];
        [NSThread sleepForTimeInterval:3.0f];
        [self connect];
        NSLog(@"重新连接");
    }
    else{
        NSLog(@"放弃重连");
    }
}


#pragma mark - 接收服务端的数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
//    if(tag == HEAD_TAG)
//    {
//        model = [[GYTPackage sharedGYTPackage] decodeHeader:data];
//        NSMutableData *buffer = [NSMutableData data];
//        [sock readDataToLength:model.len withTimeout:-1 buffer:buffer bufferOffset:0 tag:BODY_TAG];
//    }
//    else if(tag == BODY_TAG)
//    {
//        model = [[GYTPackage sharedGYTPackage] decodeBody:model data:data];
//        if(model.seq == 0)
//        {
//            NSLog(@"接收到主推数据->%@",model.result);
//        }
//        else
//        {
//            NSLog(@"接收到请求数据->%@",model.result);
//        }
//        if(self.delegate)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.delegate OnReceiveSuccess:model];
//                model = nil;
//            });
//        }
//        
//    }
    
    
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
            if (model && (model.cmd == NET_CMD_RPC)) {
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
    NSLog(@"发送数据成功");
}

#pragma mark - 发送数据给服务端
-(void)sendData : (NSString *)content
       delegate : (id)delegate
            seq : (int)seq
{
    self.delegate = delegate;
    NSData *data =[[GYTPackage sharedGYTPackage]encodeJSON:[content dataUsingEncoding:NSUTF8StringEncoding] requestid:seq];
    [_clientSocket writeData:data withTimeout:-1 tag:0];
}


@end
