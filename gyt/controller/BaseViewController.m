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

@property (strong, nonatomic) UIAlertView *alertView;

@end

static Boolean isAlertShow;

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _alertView =  [[UIAlertView alloc]initWithTitle:@"连接失败" message:@"您已经与服务器断开连接，请点击确定重新连接" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OnConnectFail) name:ConnectFail object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OnConnectSuccess) name:ConnectSuccess object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ConnectSuccess object:nil];

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


-(void)OnConnectSuccess
{
}

-(void)OnConnectFail
{
    if(![[SocketConnect sharedSocketConnect] isConnect])
    {
        NSLog(@"连接失败!");
        [self connectInterrupt];
    }
}


#pragma mark - 断开弹出提示
-(void)connectInterrupt
{
    NSLog(@"提示连接失败!");
    if(!isAlertShow)
    {
        isAlertShow = YES;
        __weak BaseViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.alertView show];
        });
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSLog(@"开始重新连接");
        [[SocketConnect sharedSocketConnect] connect];
        while (true) {
            if([[SocketConnect sharedSocketConnect] isConnect])
            {
                [self requestAutoLogin];
                isAlertShow = NO;
                break;
            }
        }
    }
    else
    {
        isAlertShow = NO;
    }
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
