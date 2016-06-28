//
//  ManageViewController.m
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ManageViewController.h"
#import "LoginViewController.h"
#import "Test.h"


@interface ManageViewController ()

@property (strong, nonatomic) UIButton *updateBtn;

@property (strong, nonatomic) UITextField *ipTextField;

@property (strong, nonatomic) UITextField *portTextField;

@end

@implementation ManageViewController

+(void)show : (SlideNavigationController *)controller
{
    ManageViewController *targetController = [[ManageViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    [self initNavigationBar];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    
    _ipTextField = [[UITextField alloc]init];
    _ipTextField.layer.masksToBounds = YES;
    _ipTextField.layer.cornerRadius = 4;
    _ipTextField.backgroundColor = [UIColor whiteColor];
    _ipTextField.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 50);
    [_ipTextField setText:[[Test sharedTest] host]];
    [self.view addSubview:_ipTextField];
    
    _portTextField = [[UITextField alloc]init];
    _portTextField.layer.masksToBounds = YES;
    _portTextField.layer.cornerRadius = 4;
    _portTextField.backgroundColor = [UIColor whiteColor];
    _portTextField.frame = CGRectMake(20, 170, SCREEN_WIDTH - 40, 50);
    [_portTextField setText:[NSString stringWithFormat:@"%d",[[Test sharedTest] port]]];
    [self.view addSubview:_portTextField];
    
    _updateBtn = [[UIButton alloc]init];
    _updateBtn.layer.masksToBounds = YES;
    _updateBtn.layer.cornerRadius = 8;
    [_updateBtn setBackgroundColor:[UIColor redColor]];
    [_updateBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _updateBtn.frame = CGRectMake(20, 240,SCREEN_WIDTH - 40, 50);
    [_updateBtn addTarget:self action:@selector(OnUpdateClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_updateBtn];
    
    
}

-(void)OnUpdateClick : (id)sender
{
    NSString *host = _ipTextField.text;
    NSString *port = _portTextField.text;
    
    if([self isPureInt:port])
    {        
        [[Test sharedTest] setHost:host];
        [[Test sharedTest] setPort:[port integerValue]];
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

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"系统设置"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}


-(void)OnLeftClickCallback
{
//    if(self.navigationController)
//    {
        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

-(void)OnReceiveSuccess:(id)respondObject
{
}

-(void)OnReceiveFail:(NSError *)error
{
}



@end
