//
//  AppDelegate.m
//  gyt
//
//  Created by by.huang on 16/4/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AppDelegate.h"
#import "kLinePage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = BACKGROUND_COLOR;
    
    [self launchViewController];
    
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


-(void)launchViewController
{
    UINavigationController *controller;

    kLinePage *mainViewController= [[kLinePage alloc]init];
    controller= [[UINavigationController alloc]initWithRootViewController:mainViewController];
    _window.rootViewController = controller;
    [_window makeKeyAndVisible];
}



@end
