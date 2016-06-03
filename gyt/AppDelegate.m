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
#import "ProductModel.h"
#import "ContractDB.h"
#import "SplashViewController.h"
#import "GCDAsyncSocket.h"

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
        LoginViewController *mainViewController =[[LoginViewController alloc]init];
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

    [self initDB];
    [[SocketConnect sharedSocketConnect] connect];
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
    
//    [[SocketConnect sharedSocketConnect] close];
}



-(void)initDB
{
    [[ContractDB sharedContractDB] createDB];
}



@end
