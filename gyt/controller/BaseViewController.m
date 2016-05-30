//
//  BaseViewController.m
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self netstate];
    
}

-(void)showNavigationBar
{
    _navBar = [[ByNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, StatuBar_HEIGHT +NavigationBar_HEIGHT)];
    _navBar.delegate = self;
    [self.view addSubview:_navBar];
}


-(void)netstate;
{
    NSLog(@"开启网络检测");
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
    
}

- (void)reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        [DialogHelper showTips:@"网络不可以用"];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        [tcp.asyncSocket disconnect];
        return;
    }

    if (reach.isReachableViaWiFi) {
        NSLog(@"当前通过wifi连接");
    }
    else if (reach.isReachableViaWWAN) {
        NSLog(@"当前通过2g/3g连接");
    }
}


//连接
- (void)connect{
    TcpClient *tcp = [TcpClient sharedInstance];
    [tcp setDelegate_ITcpClient:self];
    if(tcp.asyncSocket.isConnected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络已经连接好啦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [tcp openTcpConnection:Host port:Port];
    }
}

//发送消息
- (void)sendData:(NSString *)content{
    
    TcpClient *tcp = [TcpClient sharedInstance];
    if(tcp.asyncSocket.isDisconnected){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络不通" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if(tcp.asyncSocket.isConnected){
        
        [tcp writeString:content];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"TCP链接没有建立" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt;
{
    NSLog(@"发送到服务端的数据成功->%@",sendedTxt);
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSString*)recivedTxt;
{
    NSLog(@"收到到服务端的数据成功->%@",recivedTxt);
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err;
{
    NSLog(@"连接出现错误");
}

@end
