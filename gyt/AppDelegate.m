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
#import "MainViewController.h"
#import "ProductModel.h"
#import "ContractDB.h"
#import "SplashViewController.h"
#import "GCDAsyncSocket.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

#define First_Launch @"first_launch"
#define USE_SECURE_CONNECTION 0
#define ENABLE_BACKGROUNDING  0

#if USE_SECURE_CONNECTION
#define HOST @"www.paypal.com"
#define PORT 443
#else
#define HOST @"192.168.1.111"
#define PORT @"64350"
#endif

static const int ddLogLevel = LOG_LEVEL_INFO;

@interface AppDelegate ()

@end

@implementation AppDelegate



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
        SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:splashViewController];
        
        LeftMenuViewContriller *leftMenu = [[LeftMenuViewContriller alloc]init];
        leftMenu.view.backgroundColor = BACKGROUND_COLOR;
        
        RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
        rightMenu.view.backgroundColor = BACKGROUND_COLOR;
        rightMenu.controller = controller;
        
        controller.leftMenu = leftMenu;
        controller.righMenu = rightMenu;
        
        _window.rootViewController = controller;
        [_window makeKeyAndVisible];
    }
    
    else
    {
        MainViewController *mainViewController =[[MainViewController alloc]init];
        SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:mainViewController];
        
        LeftMenuViewContriller *leftMenu = [[LeftMenuViewContriller alloc]init];
        leftMenu.view.backgroundColor = BACKGROUND_COLOR;
        
        RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
        rightMenu.view.backgroundColor = BACKGROUND_COLOR;
        rightMenu.controller = controller;
        
        controller.leftMenu = leftMenu;
        controller.righMenu = rightMenu;
        _window.rootViewController = controller;
        [_window makeKeyAndVisible];
    }

    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [self initDB];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

-(void)initDB
{
    [[ContractDB sharedContractDB] createDB];
}


#pragma mark Socket Delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    DDLogInfo(@"socket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    
#if USE_SECURE_CONNECTION
    {
        
#if ENABLE_BACKGROUNDING && !TARGET_IPHONE_SIMULATOR
        {
            [sock performBlock:^{
                if ([sock enableBackgroundingOnSocket])
                    DDLogInfo(@"Enabled backgrounding on socket");
                else
                    DDLogWarn(@"Enabling backgrounding failed!");
            }];
        }
#endif
        
        NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:3];
        [settings setObject:@"www.paypal.com"
                     forKey:(NSString *)kCFStreamSSLPeerName];
        DDLogInfo(@"Starting TLS with settings:\n%@", settings);
        [sock startTLS:settings];
    }
#else
    {
#if ENABLE_BACKGROUNDING && !TARGET_IPHONE_SIMULATOR
        {
            [sock performBlock:^{
                if ([sock enableBackgroundingOnSocket])
                    DDLogInfo(@"Enabled backgrounding on socket");
                else
                    DDLogWarn(@"Enabling backgrounding failed!");
            }];
        }
#endif
    }
#endif
    
    //模拟发送一条数据
    NSString *requestStr = [NSString stringWithFormat:@"GET / HTTP/1.1\r\nHost: %@\r\n\r\n", HOST];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [sock writeData:requestData withTimeout:20. tag:1];
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
    DDLogInfo(@"socketDidSecure:%p", sock);
    NSString *requestStr = [NSString stringWithFormat:@"GET / HTTP/1.1\r\nHost: %@\r\n\r\n", HOST];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:requestData withTimeout:-1 tag:0];
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DDLogInfo(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    DDLogInfo(@"socket:%p didReadData:withTag:%ld", sock, tag);
    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    DDLogInfo(@"HTTP Response:\n%@", httpResponse);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    DDLogInfo(@"socketDidDisconnect:%p withError: %@", sock, err);
}



@end
