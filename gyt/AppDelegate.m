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
        
//        LeftMenuViewContriller *leftMenu = [[LeftMenuViewContriller alloc]init];
//        leftMenu.view.backgroundColor = BACKGROUND_COLOR;
        
        RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
        rightMenu.view.backgroundColor = BACKGROUND_COLOR;
        rightMenu.controller = controller;
        
        controller.leftMenu = rightMenu;
//        controller.righMenu = rightMenu;
        
        _window.rootViewController = controller;
        [_window makeKeyAndVisible];
    }
    else
    {
       
        LoginViewController *mainViewController =[[LoginViewController alloc]init];
        SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:mainViewController];
        RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
        rightMenu.view.backgroundColor = BACKGROUND_COLOR;
        rightMenu.controller = controller;
        
        controller.leftMenu = rightMenu;
        _window.rootViewController = controller;
        [_window makeKeyAndVisible];
    }
    
//    [self initBugTags];
    [self initUmengAnalysis];
    [self initDB];
    [[SocketConnect sharedSocketConnect] connect];
 

//    [[CheckUpdateUtil sharedCheckUpdateUtil] check];
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

-(void)initUmengAnalysis
{
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"57650721e0f55a6c68002b78";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];

    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
        
}

@end
