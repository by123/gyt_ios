//
//  ConditionViewController.m
//  gyt
//
//  Created by by.huang on 16/8/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ConditionViewController.h"
#import "PriceConditionView.h"
#import "TimeConditionView.h"
#import "PreConditionView.h"
#import "WebViewController.h"
#import "TipsViewController.h"

@interface ConditionViewController ()

@property (strong, nonatomic) ByTabView *tabView;

@property (strong, nonatomic) PriceConditionView *priceConditionView;

@property (strong, nonatomic) TimeConditionView *timeConditionView;

@property (strong, nonatomic) PreConditionView *preConditionView;

@end

@implementation ConditionViewController

+(void)show : (BaseViewController *)controller
       data : (PushModel *)pushModel
{
    ConditionViewController *targetController = [[ConditionViewController alloc]init];
    targetController.pushModel = pushModel;
    [controller.navigationController pushViewController:targetController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openTips:) name:Notify_Condition object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hanldlePushQuoteData:) name:PushQuoteData object:nil];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notify_Condition object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PushQuoteData object:nil];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"条件单"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
    [self.navBar setRightImage:[UIImage imageNamed:@"ic_tips"]];

}

-(void)initBody
{
    NSArray *array = @[@"价格条件单",@"时间条件单",@"预埋单"];
    CGRect rect = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self.view addSubview:_tabView];
    
    
    _priceConditionView = [[PriceConditionView alloc]initWithData:_pushModel view:self.view];
    [self.view addSubview:_priceConditionView];
    
    _timeConditionView = [[TimeConditionView alloc]initWithData:_pushModel view:self.view];
    [self.view addSubview:_timeConditionView];
    
    _preConditionView = [[PreConditionView alloc]initWithData:_pushModel view:self.view];
    [self.view addSubview:_preConditionView];
    
    [self OnSelect:0];
    
}

#pragma mark 事件处理

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnRightClickCallBack:(NSInteger)position
{
    [TipsViewController show:self content:@"提示：\n\n1.条件单在云端运行，软件关闭仍然有效，云端自动确认结算单。\n2.条件单存在风险，云端系统，网络故障等情况下失效。" type:ConditionTips];
}

-(void)OnSelect:(NSInteger)position
{
    switch (position) {
        case 0:
            _priceConditionView.hidden = NO;
            _timeConditionView.hidden = YES;
            _preConditionView.hidden = YES;
            break;
        case 1:
            _priceConditionView.hidden = YES;
            _timeConditionView.hidden = NO;
            _preConditionView.hidden = YES;
            break;
        case 2:
            _priceConditionView.hidden = YES;
            _timeConditionView.hidden = YES;
            _preConditionView.hidden = NO;
            break;
        default:
            break;
    }
}

-(void)openTips : (NSNotification *)notification
{
    [WebViewController show:self title:@"条件单风险提示" url:@"http://www.shwebstock.com.cn/popwin/sjdfx.html"];
}

#pragma mark 处理行情主推数据
-(void)hanldlePushQuoteData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:notification.object];
    id params = respondModel.params;
    id data  = [params objectForKey:@"data"];
    PushModel *model = [PushModel mj_objectWithKeyValues:data];
    if(!_priceConditionView.isHidden)
    {
        [_priceConditionView updatePushData:model];
    }
    else if(!_timeConditionView.isHidden)
    {
        [_timeConditionView updatePushData:model];
    }
    else if(!_preConditionView.isHidden)
    {
        [_preConditionView updatePushData:model];
    }

}


@end
