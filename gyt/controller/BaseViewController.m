//
//  BaseViewController.m
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "RightMenuViewController.h"
#import "AppDelegate.h"


@interface BaseViewController ()

@end


@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OnConnectFail) name:ConnectFail object:nil];
//    [[SocketConnect sharedSocketConnect]setDelegate:self];
//    [[SocketConnect sharedSocketConnect]setController:self];

    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ConnectFail object:nil];
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

-(void)OnConnectFail
{
    NSLog(@"连接失败!");
    [self connectInterrupt];
}


#pragma mark - 断开弹出提示
-(void)connectInterrupt
{
    NSLog(@"连接被断开");
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"连接失败" message:@"您已经与服务器断开连接，请点击确定重新连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[SocketConnect sharedSocketConnect] connect];
        NSLog(@"重新连接");
        
        if(self && ![self isKindOfClass:[LoginViewController class]])
        {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            LoginViewController *loginViewController = [[LoginViewController alloc]init];
            SlideNavigationController *controller = (SlideNavigationController *)appDelegate.window.rootViewController;
            [controller switchToViewController:loginViewController withCompletion:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        
        }

    }
    
}





@end
