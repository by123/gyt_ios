//
//  OrderStopLossViewController.m
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "OrderStopLossViewController.h"
#import "OrderStopLossView.h"
@interface OrderStopLossViewController ()

@property (strong, nonatomic) ByTabView *tabView;

@property (strong, nonatomic) OrderStopLossView *orderStopLossView;

@end

@implementation OrderStopLossViewController
{
    EEntrustBS director;
}

+(void)show : (BaseViewController *)controller
       data : (PushModel *)pushModel
{
    OrderStopLossViewController *targetController = [[OrderStopLossViewController alloc]init];
    targetController.pushModel = pushModel;
    [controller.navigationController pushViewController:targetController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hanldlePushQuoteData:) name:PushQuoteData object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleOrderData:) name:OrderData object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PushQuoteData object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:OrderData object:nil];

}

-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    director = ENTRUST_BUY;
    [self initNavigationBar];
    [self initBody];
    
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"止损开仓"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)initBody
{
    NSArray *array = @[@"买入",@"卖出"];
    CGRect rect = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self.view addSubview:_tabView];
    
    _orderStopLossView = [[OrderStopLossView alloc]initWithData:_pushModel view:self];
    [_orderStopLossView setDirector:director];
    [self.view addSubview:_orderStopLossView];
    
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
            director = ENTRUST_BUY;
            break;
        case 1:
            director = ENTRUST_SELL;
            break;
        default:
            break;
    }
    [_orderStopLossView setDirector:director];
}

#pragma mark 处理行情主推数据
-(void)hanldlePushQuoteData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:notification.object];
    id params = respondModel.params;
    id data  = [params objectForKey:@"data"];
    PushModel *model = [PushModel mj_objectWithKeyValues:data];
    [_orderStopLossView updatePushData:model];
}


#pragma mark 处理下单数据
-(void)handleOrderData : (NSNotification *)notification
{
    if(_orderStopLossView)
    {
        BaseRespondModel *model = notification.object;
        [_orderStopLossView handleOrderData:model];
    }
}

@end
