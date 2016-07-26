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
#import "LoginModel.h"
#import "IPMacUtil.h"
#import "UUID.h"


@interface BaseViewController ()

@property (assign, nonatomic) Boolean isShowDialog;

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OnConnectFail) name:ConnectFail object:nil];
//  [[SocketConnect sharedSocketConnect]setDelegate:self];
//  [[SocketConnect sharedSocketConnect]setController:self];
    
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
    if(![[SocketConnect sharedSocketConnect] isConnect])
    {
        [self connectInterrupt];
    }
}


#pragma mark - 断开弹出提示
-(void)connectInterrupt
{
    NSLog(@"连接被断开");
    if(!_isShowDialog)
    {
        _isShowDialog = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"连接失败" message:@"您已经与服务器断开连接，请点击确定重新连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        });
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[SocketConnect sharedSocketConnect] connect];
        NSLog(@"重新连接");
        
        [self requestAutoLogin];
//        if(self && ![self isKindOfClass:[LoginViewController class]])
//        {
//            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            LoginViewController *loginViewController = [[LoginViewController alloc]init];
//            SlideNavigationController *controller = (SlideNavigationController *)appDelegate.window.rootViewController;
//            [controller switchToViewController:loginViewController withCompletion:^{
//                  [self dismissViewControllerAnimated:YES completion:nil];
//            }];
//        }
        
    }
    _isShowDialog = NO;
}


#pragma mark 请求自动登陆
-(void)requestAutoLogin
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"正在重新登陆";
    LoginModel *model = [[LoginModel alloc]init];
    model.sessionId = @"";
    model.strUserName = [[Account sharedAccount] getUid];
    NSString *passwordStr =  @"123456";
    model.strPassword = [AppUtil sha1:passwordStr];
    model.strIpAddress = [IPMacUtil getIPAddress];
    model.strMACAdress = [UUID getUUID];;
    model.clientID = ClientID_Mobile_TRADE;
    
    [[Account sharedAccount] saveUid:model.strUserName];
    
    NSString *jsonStr = [JSONUtil parse:Request_Login params:[JSONUtil parseDic:model]];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_LOGIN];
}






@end
