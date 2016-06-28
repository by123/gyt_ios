//
//  AddViewController.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AddViewController.h"



@interface AddViewController()

@property (strong, nonatomic) UIWebView *webView;

@property (assign, nonatomic) CashType cashType;

@end

@implementation AddViewController

+(void)show : (BaseViewController *)controller
       type : (CashType) type
{
    AddViewController *targetController = [[AddViewController alloc]init];
    targetController.cashType = type;
    [controller.navigationController pushViewController:targetController animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    if(_cashType == CashType_In)
    {
        [self.navBar setTitle:@"银行转期货"];
    }
    else
    {
        [self.navBar setTitle:@"期货转银行"];
    }
   
    
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)initView
{
    [self initNavigationBar];
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    _webView.frame = Default_Frame;
    [self.view addSubview:_webView];
    [self loadData];

}


-(void)loadData
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://114.119.6.146:8088/login/"]]];
}

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
