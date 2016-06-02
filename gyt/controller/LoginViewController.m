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

@interface LoginViewController ()

@property (strong , nonatomic) InsetTextField *nameTextField;

@property (strong , nonatomic) InsetTextField *passwordTextField;

@property (strong , nonatomic) UIButton *loginBtn;

@property (assign , nonatomic) Boolean isSavePsw;

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
    
}

#pragma mark 初始化控件
-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_close"]];
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
    _nameTextField.text = @"800001080";
    [_nameTextField setInsetTitle:@"资金账号：" font:[UIFont systemFontOfSize:14.0f]];
    _nameTextField.block = ^(InsetTextField *insetTextField) {
        insetTextField.text = @"";
    };
    [_nameTextField setInsetImage:[UIImage imageNamed:@"ic_close"]];
    [rootView addSubview:_nameTextField];
    
    _passwordTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 40)];
    _passwordTextField.hasTitle = YES;
    _passwordTextField.text = @"123456";
    [_passwordTextField setInsetTitle:@"登录密码：" font:[UIFont systemFontOfSize:14.0f]];
    __weak LoginViewController *weakSelf = self;
    _passwordTextField.block = ^(InsetTextField *insetTextField){
        if(weakSelf.isSavePsw)
        {
           [DialogHelper showSuccessTips:@"密码已保存"];
           [insetTextField setInsetImage:[UIImage imageNamed:@"ic_lock"]];
        }
        else
        {
           [DialogHelper showTips:@"密码未保存"];
           [insetTextField setInsetImage:[UIImage imageNamed:@"ic_unlock"]];
        }
        weakSelf.isSavePsw = !weakSelf.isSavePsw;
    };
    [_passwordTextField setInsetImage:[UIImage imageNamed:@"ic_lock"]];
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
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:GYT_LOGIN];
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


-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.seq == GYT_LOGIN)
    {
        BaseRespondModel *model = [BaseRespondModel buildModel:respondObject];
        if(model.error.ErrorID == 0)
        {
            NSString *sessionId = [model.response objectForKey:@"sessionId"];
            [[Account sharedAccount]saveSessionid:sessionId];
            [DialogHelper showSuccessTips:[NSString stringWithFormat:@"登录成功->%@",packageModel.result]];
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
}



@end
