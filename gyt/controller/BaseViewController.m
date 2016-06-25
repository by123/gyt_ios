//
//  BaseViewController.m
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()<SocketConnectDelegate>

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[SocketConnect sharedSocketConnect]setDelegate:self];
    [[SocketConnect sharedSocketConnect]setController:self];

    
}

-(void)showNavigationBar
{
    _navBar = [[ByNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, StatuBar_HEIGHT +NavigationBar_HEIGHT)];
    _navBar.delegate = self;
    [self.view addSubview:_navBar];
}

-(void)OnTitleClick
{
}

-(void)OnConnectSuccess
{
    NSLog(@"连接成功！");
}

-(void)OnConnectFail
{
    NSLog(@"连接失败!");
}



@end
