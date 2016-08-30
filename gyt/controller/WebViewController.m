//
//  WebViewController.m
//  gyt
//
//  Created by by.huang on 16/8/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation WebViewController

+(void)show : (BaseViewController *)controller
      title : (NSString *) titleStr
        url : (NSString *)webUrl
{
    WebViewController *targetController = [[WebViewController alloc]init];
    targetController.titleStr = titleStr;
    targetController.webUrl = webUrl;
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
    [self.navBar setTitle:_titleStr];
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
    NSString *url = _webUrl;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
