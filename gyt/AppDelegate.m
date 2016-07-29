//
//  AppDelegate.m
//  gyt
//
//  Created by by.huang on 16/4/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewContriller.h"
#import "RightMenuViewController.h"
#import "LoginViewController.h"
#import "PushModel.h"
#import "ContractDB.h"
#import "SplashViewController.h"
#import "GCDAsyncSocket.h"
#import "CheckUpdateUtil.h"
#import <Bugtags/Bugtags.h>


#define First_Launch @"first_launch"
#define TimeRepeat 5
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    int count;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = BACKGROUND_COLOR;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL firstLaunch = [userDefault boolForKey:First_Launch];
    
    if(!firstLaunch)
    {
        [userDefault setBool:YES forKey:First_Launch];
        SplashViewController *splashViewController = [[SplashViewController alloc]init];
        [_window setRootViewController:[[SlideNavigationController alloc]initWithRootViewController:splashViewController]];
    }
    else
    {
        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        [_window setRootViewController:[[SlideNavigationController alloc] initWithRootViewController:loginViewController]];
    }
    RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
    rightMenu.view.backgroundColor = BACKGROUND_COLOR;
    rightMenu.controller = (SlideNavigationController *)_window.rootViewController;
    [SlideNavigationController sharedInstance].leftMenu = rightMenu;
    
    [_window makeKeyAndVisible];

//    [self initBugTags];
    [self initUmengAnalysis];
    [self initDB];
    [self listenNetChange];
    [self handlePushData];
    [[CheckUpdateUtil sharedCheckUpdateUtil] check];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[SocketConnect sharedSocketConnect] disconnect];
    NSLog(@"进入后台，断开连接...");

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"回到前台，检查连接...");
    if([[SocketConnect sharedSocketConnect] isConnect]){
        NSLog(@"连接中...");
    }
    else{
        [self sendReciveData:nil name:ConnectFail];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark 初始数据库
-(void)initDB
{
    [[ContractDB sharedContractDB] createDB];
}

#pragma mark bug测试
-(void)initBugTags
{
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES;        // 是否收集闪退，联机 Debug 状态下默认 NO，其它情况默认 YES
    options.trackingUserSteps = YES;      // 是否跟踪用户操作步骤，默认 YES
    options.trackingConsoleLog = YES;     // 是否收集控制台日志，默认 YES
    options.trackingUserLocation = YES;   // 是否获取位置，默认 YES
    
    // 是否跟踪网络请求，只跟踪 HTTP / HTTPS 请求，默认 NO
    // 强烈建议同时设置 trackingNetworkURLFilter 对需要跟踪的网络请求进行过滤
    options.trackingNetwork = YES;
    
    // 设置需要跟踪的网络请求 URL，多个地址用 | 隔开，
    // 支持正则表达式，不设置则跟踪所有请求
    // 强烈建议设置为应用服务器接口的域名，如果接口是通过 IP 地址访问，则设置为 IP 地址
    // 如：设置为 bugtags.com，则网络请求跟踪只对 URL 中包含 bugtags.com 的请求有效
    options.trackingNetworkURLFilter = @"yourdomain.com";
    
    options.crashWithScreenshot = YES;    // 收集闪退是否附带截图，默认 YES
    options.ignorePIPESignalCrash = YES;  // 是否忽略 PIPE Signal (SIGPIPE) 闪退，默认 NO
    
    [Bugtags startWithAppKey:@"7ba0bda45aa019024ea1994412900ced" invocationEvent:BTGInvocationEventShake options:options];
}

#pragma mark 统计分析
-(void)initUmengAnalysis
{
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"57650721e0f55a6c68002b78";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];

    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
        
}

#pragma mark 监听网络变化
-(void)listenNetChange
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未识别的网络");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"不可达的网络(未连接)");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"2G,3G,4G...的网络");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"wifi的网络");
                    break;
                default:
                    break;
            }
        }];
        [manager startMonitoring];
}


#pragma mark 注册主推数据
-(void)handlePushData
{
    [[SocketConnect sharedSocketConnect]setDelegate:self];
    [[SocketConnect sharedSocketConnect] connect];
    [self startAlive];
}

#pragma mark 发送保活包
-(void)startAlive
{
//    NSLog(@"发送保活包");
    if([[SocketConnect sharedSocketConnect] isConnect])
    {
        NSLog(@"连接中......");
    }
    else
    {
        NSLog(@"连接有问题......");
    }
    [[SocketConnect sharedSocketConnect] sendAlive];
    [self performSelector:@selector(startAlive) withObject:nil afterDelay:TimeRepeat];
}


#pragma mark 接收数据
-(void)OnReceiveSuccess:(id)respondObject
{

    PackageModel *packageModel = respondObject;
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];

    if(packageModel.seq == GYT_LOGIN)
    {
        [self sendReciveData:respondModel name:LoginData];
        NSLog(@"-----reciver----接收到登录返回");
    }
    else if(packageModel.seq == XT_CAccountDetail)
    {
        [self sendReciveData:respondModel name:AccountDetailData];
        NSLog(@"-----reciver----接收到资金信息");
    }
    else if(packageModel.seq == XT_CInstrumentDetail)
    {
        [self sendReciveData:respondModel name:InstrumentDetailData];
        NSLog(@"-----reciver----接收到合约信息");
    }
    else if(packageModel.seq == GYT_CommitCashApplyInfo)
    {
        [self sendReciveData:respondObject name:CommitCashApplyInfoData];
        NSLog(@"-----reciver----接收出金返回");
    }
    else if(packageModel.seq == GYT_CashApplyInfo)
    {
        [self sendReciveData:respondModel name:CashApplyInfoData];
        NSLog(@"-----reciver----接收查询出入金详情");
    }
    else if(packageModel.seq == GYT_KLINE)
    {
        [self sendReciveData:respondModel name:KLineData];
        NSLog(@"-----reciver----接收k线信息");
    }
    else if(packageModel.seq == XT_CPositionStatics)
    {
        [self sendReciveData:respondModel name:PositionStaticsData];
        NSLog(@"-----reciver----接收持仓信息");
    }
    else if(packageModel.seq == XT_COrderDetail)
    {
        [self sendReciveData:respondModel name:OrderDetailData];
        NSLog(@"-----reciver----接收委托信息");
    }
    else if(packageModel.seq == XT_CDealDetail)
    {
        [self sendReciveData:respondModel name:DealDetailData];
        NSLog(@"-----reciver----接收成交信息");
    }
    else if(packageModel.seq == GYT_ORDER)
    {
        [self sendReciveData:respondModel name:OrderData];
        NSLog(@"-----reciver----接收下单信息");
    }
    else if(packageModel.seq == GYT_CANCEL)
    {
        [self sendReciveData:respondModel name:CancelData];
        NSLog(@"-----reciver----接收撤单信息");
    }

    else if(packageModel.cmd == NET_CMD_NOTIFICATION)
    {
        //行情主推
        if([respondModel.method isEqualToString:PushQuoteData])
        {
            BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];
            id params = respondModel.params;
            id data  = [params objectForKey:@"data"];
            PushModel *pushModel = [PushModel mj_objectWithKeyValues:data];
            
            if(!IS_NS_COLLECTION_EMPTY(_mainDatas))
            {
                for(PushModel *model in _mainDatas)
                {
                    if([model.m_strInstrumentID isEqualToString:pushModel.m_strInstrumentID])
                    {
                        //无数据变化不刷新
                        if(pushModel.m_dLastPrice == model.m_dLastPrice && pushModel.m_nVolume == model.m_nVolume)
                        {
                            return;
                        }
                        else
                        {
                            [self sendReciveData:respondObject name:PushQuoteData];
                            count ++ ;
                            NSLog(@"收到数据次数->%d",count);
                            break;
                        }
                    }
                }
            }
         
        }
        else if([respondModel.method isEqualToString:PushData])
        {
            [self sendReciveData:packageModel name:PushData];
            
        }
    }
    
}

-(void)OnReceiveFail:(NSError *)error
{
    NSLog(@"接收数据失败");
}

-(void)OnConnectSuccess
{
    NSLog(@"连接成功");
    [self sendReciveData:nil name:ConnectSuccess];
}

-(void)OnConnectFail
{
    [self sendReciveData:nil name:ConnectFail];
}


#pragma mark 分发数据
-(void)sendReciveData : (id)data
                 name : (NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:data];
}

@end
