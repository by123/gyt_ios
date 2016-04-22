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
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = BACKGROUND_COLOR;
    
    MainViewController *mainViewController =[[MainViewController alloc]init];
    
    SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:mainViewController];
   
    LeftMenuViewContriller *leftMenu = [[LeftMenuViewContriller alloc]init];
    leftMenu.view.backgroundColor = SUB_COLOR;
    
    RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
    rightMenu.view.backgroundColor = SUB_COLOR;
    rightMenu.controller = controller;
    
    controller.leftMenu = leftMenu;
    controller.righMenu = rightMenu;
    
    _window.rootViewController = controller;
    [_window makeKeyAndVisible];


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
//-(void)launchViewController
//{
//    UINavigationController *controller;
//
//    MainViewController *mainViewController= [[MainViewController alloc]init];
//    controller= [[UINavigationController alloc]initWithRootViewController:mainViewController];
//    _window.rootViewController = controller;
//    [_window makeKeyAndVisible];
//}



@end
