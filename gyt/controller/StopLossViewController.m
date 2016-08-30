//
//  StopLossViewController.m
//  gyt
//
//  Created by by.huang on 16/8/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "StopLossViewController.h"
#import "StopLossView.h"
#import "StopProfitView.h"
#import "WebViewController.h"

@interface StopLossViewController ()

@property (strong, nonatomic) ByTabView *tabView;

@property (strong, nonatomic) StopLossView *stopLossView;

@property (strong, nonatomic) StopProfitView *stopProfitView;

@end

@implementation StopLossViewController
{
    //是否切换到止损单
    Boolean isStopLoss;
}

+(void)show : (BaseViewController *)controller data: (DealHoldModel *)model
{
    StopLossViewController *targetController = [[StopLossViewController alloc]init];
    targetController.model = model;
    [controller.navigationController pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isStopLoss = YES;
    [self initView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notify_StopLoss object:nil];
}

-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openTips:) name:Notify_StopLoss object:nil];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"止盈止损设置"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)initBody
{
    NSArray *array = @[@"止损单",@"止盈单"];
    CGRect rect = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self.view addSubview:_tabView];
    
    _stopLossView = [[StopLossView alloc]initWithData:_model view:self.view];
    [self.view addSubview:_stopLossView];
    
    _stopProfitView = [[StopProfitView alloc]initWithData:_model view:self.view];
    [self.view addSubview:_stopProfitView];
    
    _stopLossView.hidden = NO;
    _stopProfitView.hidden = YES;
    
}


#pragma mark 事件处理

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnSelect:(NSInteger)position
{
    switch (position) {
        case 0:
            _stopLossView.hidden = NO;
            _stopProfitView.hidden = YES;
            break;
        case 1:
            _stopLossView.hidden = YES;
            _stopProfitView.hidden = NO;
            break;
        default:
            break;
    }
}


-(void)openTips : (NSNotification *)notification
{
    NSNumber *tag = notification.object;
    switch ([tag intValue]) {
        case 0:
            [WebViewController show:self title:@"止损风险提示" url:@"http://redirect.wenhua.com.cn/skip.asp?id=29"];
            break;
        case 1:
            [WebViewController show:self title:@"止盈风险提示" url:@"http://redirect.wenhua.com.cn/skip.asp?id=29"];
            break;
        default:
            break;
    }

}


@end
