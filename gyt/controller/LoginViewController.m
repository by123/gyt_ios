//
//  LoginViewController.m
//  gyt
//
//  Created by by.huang on 16/5/11.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LoginViewController.h"
#import "InsetTextField.h"
#import "DialogHelper.h"
#import "JSONUtil.h"
#import "LoginModel.h"

@interface LoginViewController ()

@property (strong , nonatomic) InsetTextField *companyTextField;

@property (strong , nonatomic) InsetTextField *nameTextField;

@property (strong , nonatomic) InsetTextField *passwordTextField;

@property (strong , nonatomic) UIButton *loginBtn;

@property (assign , nonatomic) Boolean isSavePsw;

@end

@implementation LoginViewController


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
    
    _companyTextField = [[InsetTextField alloc]initWithFrame: CGRectMake(20, 20, SCREEN_WIDTH-40, 40)];
    _companyTextField.hasTitle = YES;
    [_companyTextField setInsetTitle:@"开户公司" font:[UIFont systemFontOfSize:14.0f]];
    _companyTextField.block = ^(InsetTextField *insetTextField) {
        [DialogHelper showTips:@"开发中"];
    };
    [_companyTextField setInsetImage:[UIImage imageNamed:@"ic_search"]];
    [rootView addSubview:_companyTextField];

    
    _nameTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH-40, 40)];
    _nameTextField.hasTitle = YES;
    _nameTextField.text = @"800026042";
    [_nameTextField setInsetTitle:@"资金账号" font:[UIFont systemFontOfSize:14.0f]];
    _nameTextField.block = ^(InsetTextField *insetTextField) {
        insetTextField.text = @"";
    };
    [_nameTextField setInsetImage:[UIImage imageNamed:@"ic_close"]];
    [rootView addSubview:_nameTextField];
    
    _passwordTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 40)];
    _passwordTextField.hasTitle = YES;
    _passwordTextField.text = @"123456";
    [_passwordTextField setInsetTitle:@"登录密码" font:[UIFont systemFontOfSize:14.0f]];
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
    model.sessionId = @"ceshi";
    model.strUserName = _nameTextField.text;
    model.strPassword = _passwordTextField.text;
    model.strIpAddress = @"ceshi";
    model.strMACAdress = @"64-00-6A-89-6B-76";
    model.clientID = 3;
    
    [[Account sharedAccount] saveAccount:model.strUserName sessionid:model.sessionId];
    
    NSString *jsonStr = [JSONUtil parse:Request_Login params:[JSONUtil parseStr:model]];
//    NSLog(@"%@",jsonStr);
    [self requestLogin:jsonStr];
    
}


#pragma mark 请求登录
-(void)requestLogin : (NSString *)jsonStr
{
    
    [[HttpRequest sharedHttpRequest] post:jsonStr view:self.view success:^(id responseObject) {
        
        NSString *text = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"返回结果->%@",text);
        ResponseModel *model = [ResponseModel mj_objectWithKeyValues:responseObject];
        int code = [[model.response objectForKey:@"success"] integerValue];
        if(code == 1)
        {
            NSString *sessionId = [model.response objectForKey:@"sessionId"];
            [[Account sharedAccount]saveSessionid:sessionId];
            [DialogHelper showSuccessTips:[NSString stringWithFormat:@"登录成功->%@",text]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [DialogHelper showTips:@"登录失败!"];
        }
        
    } fail:^(NSError *error) {
        [DialogHelper showTips:@"登录失败!"];
    }];
    

}

#pragma mark 隐藏键盘
-(void)hideKeyboard
{
    [_companyTextField resignFirstResponder];
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
