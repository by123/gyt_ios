//
//  SocketConnect.m
//  gyt
//
//  Created by by.huang on 16/5/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SocketConnect.h"

@implementation SocketConnect

SINGLETON_IMPLEMENTION(SocketConnect);

-(instancetype)init
{
    if(self == [super init])
    {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
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
        NSLog(@"socket连接失败");
    }
    else{
        NSLog(@"socket连接成功");
    }
}

#pragma mark - 判断与服务器是否正确链接
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    //监听读取数据
    [sock readDataWithTimeout:-1 tag:0];
    NSLog(@"连接成功。。。。");
    if(self.delegate)
    {
        [self.delegate OnConnectSuccess];
    }
}


#pragma mark - 连接被断开
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"断开连接。。。");
}


#pragma mark - 接收服务端的数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    PackageModel *model =[[GYTPackage sharedGYTPackage] decodeJSON:data];
    NSLog(@"接收到数据tag:%lld->%@",model.seq,model.result);
    [sock readDataWithTimeout:-1 tag:tag];
    if(self.delegate)
    {
        [self.delegate OnReceiveSuccess:model];
    }
}


-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
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




//
//-(void)netstate;
//{
//    NSLog(@"开启网络检测");
//    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reachabilityChanged:)
//                                                 name:kReachabilityChangedNotification
//                                               object:nil];
//    [reach startNotifier];
//
//}
//
//- (void)reachabilityChanged: (NSNotification*)note {
//    Reachability * reach = [note object];
//
//    if(![reach isReachable])
//    {
//        [DialogHelper showTips:@"网络不可以用"];
//        TcpClient *tcp = [TcpClient sharedInstance];
//        [tcp setDelegate_ITcpClient:self];
//        [tcp.asyncSocket disconnect];
//        return;
//    }
//
//    if (reach.isReachableViaWiFi) {
//        NSLog(@"当前通过wifi连接");
//    }
//    else if (reach.isReachableViaWWAN) {
//        NSLog(@"当前通过2g/3g连接");
//    }
//}
//
//
////连接
//- (void)connect{
//    TcpClient *tcp = [TcpClient sharedInstance];
//    [tcp setDelegate_ITcpClient:self];
//    if(tcp.asyncSocket.isConnected)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络已经连接好啦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//    else
//    {
//        [tcp openTcpConnection:Host port:Port];
//    }
//}
//
////发送消息
//- (void)sendData:(NSString *)content{
//
//    TcpClient *tcp = [TcpClient sharedInstance];
//    TTPackage *package = [TTPackage initPackage];
//    NSData *data = [package encodeJSON : [content dataUsingEncoding:NSUTF8StringEncoding]];
//    if(tcp.asyncSocket.isDisconnected){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络不通" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    else if(tcp.asyncSocket.isConnected){
//
//        [tcp writeData:data];
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"TCP链接没有建立" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//
//}
//
///**发送到服务器端的数据*/
//-(void)OnSendDataSuccess:(NSString*)sendedTxt;
//{
//    NSLog(@"发送到服务端的数据成功->%@",sendedTxt);
//}
//
///**收到服务器端发送的数据*/
//-(void)OnReciveData:(NSString*)recivedTxt;
//{
//    NSLog(@"收到到服务端的数据成功->%@",recivedTxt);
//}
//
///**socket连接出现错误*/
//-(void)OnConnectionError:(NSError *)err;
//{
//    NSLog(@"连接出现错误");
//}

@end
