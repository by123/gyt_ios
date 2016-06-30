//
//  LoginViewController.m
//  gyt
//
//  Created by by.huang on 16/5/11.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LoginViewController.h"
#import "InsetTextField.h"
#import "LoginModel.h"
#import "IPMacUtil.h"
#import "UUID.h"
#import "MainViewController.h"
#import "ByTextField.h"
#import "ManageViewController.h"
#import "Test.h"
#import "AppDelegate.h"
#import "RightMenuViewController.h"
@interface LoginViewController ()

@property (strong , nonatomic) InsetTextField *nameTextField;

@property (strong , nonatomic) InsetTextField *passwordTextField;

@property (strong , nonatomic) UIButton *loginBtn;

@property (assign , nonatomic) Boolean isSavePsw;

@property (strong, nonatomic) UILabel *tipLabel;

@property (strong, nonatomic) UITextField *ipTextField;

@property (strong, nonatomic) UITextField *portTextField;

@property (strong, nonatomic) UIButton *setBtn;

@end

@implementation LoginViewController
{
    __weak MBProgressHUD *hua;
}



+(void)show:(BaseViewController *)controller
{
    LoginViewController *target = [[LoginViewController alloc]init];
    [controller presentViewController:target animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[SocketConnect sharedSocketConnect]setController:self];
}

#pragma mark 初始化控件
-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [[SocketConnect sharedSocketConnect] setDelegate:self];
//}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setLeftImage:nil];
    [self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"委托登录"];
}


-(void)initBody
{
    UIView *rootView =[[UIView alloc]init];
    rootView.frame = Default_Frame;
    rootView.backgroundColor = [ColorUtil colorWithHexString:@"#333333"];
    [self.view addSubview:rootView];
    
    _nameTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH-40, 40)];
    _nameTextField.hasTitle = YES;
//    _nameTextField.text = @"800014340";
//    _nameTextField.text = @"800001080"; //内外通用
    _nameTextField.text = @"800003664";  //外网
//    _nameTextField.text = @"800031702";  //外网
//    _nameTextField.text = @"800001706";
    [_nameTextField setInsetTitle:@"资金账号：" font:[UIFont systemFontOfSize:14.0f]];
    _nameTextField.block = ^(InsetTextField *insetTextField) {
        insetTextField.text = @"";
    };
    [_nameTextField setInsetImage:[UIImage imageNamed:@"ic_close"]];
    [rootView addSubview:_nameTextField];
    
    _passwordTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 40)];
    _passwordTextField.hasTitle = YES;
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefault_Password];
    _passwordTextField.text = password;
    [_passwordTextField setInsetTitle:@"登录密码：" font:[UIFont systemFontOfSize:14.0f]];
    __weak LoginViewController *weakSelf = self;
    _passwordTextField.block = ^(InsetTextField *insetTextField){
        if(IS_NS_STRING_EMPTY(insetTextField.text))
        {
            [DialogHelper showTips:@"请输入密码"];
            return;
        }
        if(!weakSelf.isSavePsw)
        {
            [[NSUserDefaults standardUserDefaults] setValue:weakSelf.passwordTextField.text forKey:UserDefault_Password];
            [DialogHelper showSuccessTips:@"密码已保存"];
           [insetTextField setInsetImage:[UIImage imageNamed:@"ic_lock"]];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserDefault_Password];
           [DialogHelper showTips:@"密码未保存"];
           [insetTextField setInsetImage:[UIImage imageNamed:@"ic_unlock"]];
        }
        weakSelf.isSavePsw = !weakSelf.isSavePsw;
    };
    [_passwordTextField setInsetImage:[UIImage imageNamed:@"ic_unlock"]];
    _passwordTextField.secureTextEntry = YES;
    [rootView addSubview:_passwordTextField];
    
    
    _loginBtn = [[UIButton alloc]init];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 4;
    _loginBtn.backgroundColor = SELECT_COLOR;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _loginBtn.frame = CGRectMake(20, 180, SCREEN_WIDTH - 40, 40);
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_loginBtn];
    
    [self test:rootView];
    
}




#pragma mark 测试模块
-(void)test : (UIView *)rootView
{
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.text = @"未连接";
    _tipLabel.textColor = TEXT_COLOR;
    _tipLabel.font = [UIFont systemFontOfSize:13.0f];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.frame = CGRectMake(0, 230, SCREEN_WIDTH, 20);
    [rootView addSubview:_tipLabel];
    
    _ipTextField = [[UITextField alloc]init];
    _ipTextField.text = [Test sharedTest].host;
    _ipTextField.textColor = [UIColor blackColor];
    _ipTextField.backgroundColor = TEXT_COLOR;
    _ipTextField.frame = CGRectMake(20, 260, SCREEN_WIDTH - 40, 50);
    [rootView addSubview:_ipTextField];
    
    _portTextField = [[UITextField alloc]init];
    _portTextField.text = [NSString stringWithFormat:@"%d",[Test sharedTest].port];
    _portTextField.textColor = [UIColor blackColor];
    _portTextField.backgroundColor = TEXT_COLOR;
    _portTextField.frame = CGRectMake(20, 330, SCREEN_WIDTH - 40, 50);
    [rootView addSubview:_portTextField];
    
    _setBtn = [[UIButton alloc]init];
    [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _setBtn.backgroundColor = [UIColor redColor];
    _setBtn.frame = CGRectMake(20, 400, SCREEN_WIDTH - 40, 50);
    [_setBtn addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_setBtn];
}

-(void)testClick : (id)sender
{
    NSString *host = _ipTextField.text;
    NSString *port = _portTextField.text;
    
    if([self isPureInt:port])
    {
        [[Test sharedTest] setHost:host];
        [[Test sharedTest] setPort:[port intValue]];
        [DialogHelper showSuccessTips:@"修改成功"];
        [[SocketConnect sharedSocketConnect] disconnect];
    }
    else
    {
        [DialogHelper showTips:@"端口输入有误"];
    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(void)OnConnectSuccess
{
    _tipLabel.text = @"已连上";
}

-(void)OnConnectFail
{
    _tipLabel.text = @"连接被断开";
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
            //            LoginViewController *targetController = [[LoginViewController alloc]init];
            //            [self.navigationController pushViewController:targetController animated:YES];
            
            //移除uiwindow
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate.window resignKeyWindow];
            
            
            UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            window.backgroundColor = BACKGROUND_COLOR;
            
            LoginViewController *loginViewController =[[LoginViewController alloc]init];
            SlideNavigationController *controller = [[SlideNavigationController alloc]initWithRootViewController:loginViewController];
            RightMenuViewController *rightMenu = [[RightMenuViewController alloc]init];
            rightMenu.view.backgroundColor = BACKGROUND_COLOR;
            rightMenu.controller = controller;
            
            controller.leftMenu = rightMenu;
            window.rootViewController = controller;
            [window makeKeyWindow];
        }
    }
    
}


#pragma mark 请求登录
-(void)login
{
    hua = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    
    if(IS_NS_STRING_EMPTY(name))
    {
        [DialogHelper showTips:@"请输入资金账号"];
        [hua hide:YES];
        return;
    }
    if(IS_NS_STRING_EMPTY(password))
    {
        [DialogHelper showTips:@"请输入密码"];
        [hua hide:YES];
        return;
    }
    
    [self hideKeyboard];

    
    LoginModel *model = [[LoginModel alloc]init];
    model.sessionId = @"";
    model.strUserName = _nameTextField.text;
    NSString *passwordStr =  _passwordTextField.text;
    model.strPassword = [AppUtil sha1:passwordStr];
    model.strIpAddress = [IPMacUtil getIPAddress];
    model.strMACAdress = [UUID getUUID];;
    model.clientID = ClientID_Mobile_TRADE;
    
    [[Account sharedAccount] saveUid:model.strUserName];
    
    NSString *jsonStr = [JSONUtil parse:Request_Login params:[JSONUtil parseDic:model]];
//    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:GYT_LOGIN];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_LOGIN];

}

#pragma mark 测试http登录
-(void)loginWithHttp
{
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    
    if(IS_NS_STRING_EMPTY(name))
    {
        [DialogHelper showTips:@"请输入资金账号"];
        return;
    }
    if(IS_NS_STRING_EMPTY(password))
    {
        [DialogHelper showTips:@"请输入密码"];
        return;
    }
    
    [self hideKeyboard];
    
    
    LoginModel *model = [[LoginModel alloc]init];
    model.sessionId = @"";
    model.strUserName = _nameTextField.text;
    model.strPassword = @"123456";
    model.strIpAddress = [IPMacUtil getIPAddress];
    model.strMACAdress = [UUID getUUID];;
    model.clientID = ClientID_Mobile_Manage;
    
    [[Account sharedAccount] saveUid:model.strUserName];
    
    NSString *jsonStr = [JSONUtil parse:Request_Login params:[JSONUtil parseDic:model]];

    [[HttpRequest sharedHttpRequest] post:jsonStr view:self.view success:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
}


-(void)OnReceiveFail:(NSError *)error
{
    [hua hide:YES];
}

-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.seq == GYT_LOGIN)
    {
        BaseRespondModel *model = [BaseRespondModel buildModel:respondObject];
        if(model.error.ErrorID == 0)
        {
            NSString *sessionId = [model.response objectForKey:@"sessionId"];

            [MobClick profileSignInWithPUID:[[Account sharedAccount] getUid]];

            [[Account sharedAccount]saveSessionid:sessionId];
//            [DialogHelper showSuccessTips:[NSString stringWithFormat:@"登录成功->%@",packageModel.result]];
            [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Update_AccountInfo object:nil];
            [MainViewController show : self];
        }
        else
        {
            [DialogHelper showTips:@"登录失败!"];
        }
    }
    
    [hua hide:YES];
}



#pragma mark 隐藏键盘
-(void)hideKeyboard
{
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


#pragma mark 点击返回
-(void)OnLeftClickCallback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 点击其他区域
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
    [_ipTextField resignFirstResponder];
    [_portTextField resignFirstResponder];
}





@end
