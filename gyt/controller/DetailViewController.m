//
//  DetailViewController.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DetailViewController.h"
#import "SlideNavigationController.h"
#import "HandicapView.h"
#import "DealView.h"
#import "ContractDB.h"
#import "WarnDialog.h"
#import "NewsView.h"
#import "CandleView.h"
#import "TimeView.h"
#import "ShortCutView.h"

@interface DetailViewController ()

@property (strong, nonatomic) PushModel *model;

@property (strong, nonatomic) UIView *bodyView;

@property (strong, nonatomic) NewsView *newsView;

@property (strong, nonatomic) HandicapView *handicapView;

@property (strong, nonatomic) DealView *dealView;

@property (strong, nonatomic) CandleView *candleView;

@property (strong, nonatomic) BottomTabView *tabView;

@end

@implementation DetailViewController
{
    NSInteger currentPosition;
}

+(void)show : (BaseViewController *)controller
      model : (PushModel *) model
   position : (NSInteger)position
{
    DetailViewController *targetController = [[DetailViewController alloc]init];
    targetController.model = model;
    [controller presentViewController:targetController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

}

#pragma mark 初始化组件
-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBodyView];
    [self initBottomView];
}


-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
    [self.navBar setLeftMainTitle:@"分时图"];
    [self.navBar setLeftSubTitle:_model.m_strInstrumentID];
    [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_drawline"]];
    [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_lightning"]];
    [self.navBar setRightBtn3Image:nil];
    currentPosition = 3;
    [self OnSelectPosition:currentPosition];
}

-(void)initBodyView
{
    _bodyView = [[UIView alloc]init];
    _bodyView.frame =CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, kContentHeight);
    [self.view addSubview:_bodyView];
    [self addBuyView];
}

-(void)initBottomView
{
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
//    [titleArray addObject:[BottomTabView buildModel:@"新闻" image:[UIImage imageNamed:@"ic_news"]]];
    [titleArray addObject:[BottomTabView buildModel:@"盘口" image:[UIImage imageNamed:@"ic_handicap"]]];
    [titleArray addObject:[BottomTabView buildModel:@"分时" image:[UIImage imageNamed:@"ic_timeline_chart"]]];
    [titleArray addObject:[BottomTabView buildModel:@"k线" image:[UIImage imageNamed:@"ic_kline_chart"]]];
    [titleArray addObject:[BottomTabView buildModel:@"下单" image:[UIImage imageNamed:@"ic_lightnting_buy"]]];
    _tabView = [[BottomTabView alloc]initWithData:titleArray];
    _tabView.frame = CGRectMake(0, SCREEN_HEIGHT - kBottomHeight, SCREEN_WIDTH, kBottomHeight);
    _tabView.delegate = self;
    [self.view addSubview:_tabView];
}


#pragma mark 显示底部栏
-(void)showBottomView
{
    [_tabView setHidden:NO];
}

#pragma mark 隐藏底部栏
-(void)hideBottomView
{
    [_tabView setHidden:YES];
}


#pragma mark 初始化新闻模块
-(void)addNewsView
{
    [self clearAllView];
    _newsView = [[NewsView alloc]initWithData:CGRectMake(0, 0, SCREEN_WIDTH, kContentHeight + kTopHeight) model:_model];
    [_bodyView addSubview:_newsView];
}


#pragma mark 添加盘口模块
-(void)addHandicapView
{
    [self clearAllView];
    _handicapView = [[HandicapView alloc]initWithData:_model];
    _handicapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kContentHeight + kTopHeight);
    [_bodyView addSubview:_handicapView];
}


#pragma mark 添加分时图模块
-(void)addTimelineView
{
    [self clearAllView];
    _candleView = [[CandleView alloc]initWithType:CGRectMake(0, 0, SCREEN_WIDTH, kContentHeight + kTopHeight) type:TimeLine];
    [_bodyView addSubview:_candleView];
}

#pragma mark 添加k线图模块
-(void)addKlineView
{
    [self clearAllView];
    _candleView = [[CandleView alloc]initWithType:CGRectMake(0, 0, SCREEN_WIDTH, kContentHeight + kTopHeight) type:KLine];
    [_bodyView addSubview:_candleView];
    
}

#pragma mark 添加下单模块
-(void)addBuyView
{
    [self clearAllView];
    _dealView = [[DealView alloc]initWithData:CGRectMake(0, 0, SCREEN_WIDTH, kContentHeight + kTopHeight) model:_model view:self.view];
    [_bodyView addSubview:_dealView];

}



#pragma mark 清除上次绘制布局
-(void)clearAllView
{
    if(_bodyView)
    {
        [_bodyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}


#pragma mark 点击事件回调
-(void)OnLeftClickCallback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)OnTitleClick
{}

-(void)OnRightClickCallBack : (NSInteger) position
{

    if(currentPosition == 0)
    {
        if(position == 0)
        {
            //下单
            [self addOrder];
        }
        else if(position == 1)
        {
            //加入自选合约
            [self addContract];
        }
        else if(position == 2)
        {
            //加入预警合约
            [self addWarnContract];
        }
    }
    else if(currentPosition == 1)
    {
        if(position == 0)
        {
            //闪电下单
            [self addOrder];
        }
        else if(position == 1)
        {
            //加入自选合约
            [self addContract];
        }
        else if(position == 2)
        {
            //加入预警合约
            [self addWarnContract];
        }
    }
    else if(currentPosition == 2)
    {
        if(position == 0)
        {
            //选时间
            [self addTimeView];
        }
        else if(position == 1)
        {
            //下单
            [self addOrder];
        }
        else if(position == 2)
        {
            //加入自选合约
            [self addContract];
        }
        else if(position == 3)
        {
            //加入预警合约
            [self addWarnContract];
        }
    }
    else if(currentPosition == 3)
    {
        if(position == 0)
        {
            //刷新
            [DialogHelper showTips:@"开发中"];
        }
    }
 
}

#pragma mark 加入自选合约
-(void)addContract
{
    if(_model.isMyContract == 1)
    {
        _model.isMyContract = 0;
        [DialogHelper showWarnTips:[NSString stringWithFormat:@"%@已取消自选合约",_model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] deleteItem:DBMyContractTable instrumentid:_model.m_strInstrumentID];

    }
    else
    {
        _model.isMyContract = 1;
        [DialogHelper showSuccessTips:[NSString stringWithFormat:@"%@已加入自选合约",_model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] insertItem:DBMyContractTable model:_model];

    }
    [[ContractDB sharedContractDB] updateItem:DBHistoryContractTable instrumentid:_model.m_strInstrumentID model:_model];
    [[ContractDB sharedContractDB] updateItem:DBWarnContractTable instrumentid:_model.m_strInstrumentID model:_model];

    [self OnSelectPosition:currentPosition];
}

#pragma mark 加入预警合约
-(void)addWarnContract
{
    WarnDialog *dialog = [[WarnDialog alloc]initWithData:_model];
    [self.view addSubview:dialog];
}


#pragma mark 选择时间
-(void)addTimeView
{
    TimeView *timeView = [[TimeView alloc]init];
    timeView.delegate = self;
    [self.view addSubview:timeView];
}

#pragma mark 快速下单板
-(void)addOrder
{
    ShortCutView *shortCutView = [[ShortCutView alloc]initWithView:self.view model:_model];
    [self.view addSubview:shortCutView];
}

-(void)OnSelectPosition:(NSInteger)position
{
    switch (position) {
//        case 0:
//            [self.navBar setTitle:@"新闻"];
//            [self.navBar setRightImage:nil];
//            [self.navBar setRightBtn1Image:nil];
//            [self.navBar setRightBtn2Image:nil];
//            [self.navBar setRightBtn3Image:nil];
//            [self.navBar setRightBtn4Image:nil];
//            [self addNewsView];
//            break;
        case 0:
            [self.navBar setLeftMainTitle:@"详细报价"];
            [self.navBar setRightImage:[UIImage imageNamed:@"ic_lightning"]];

            if(_model.isMyContract == 1)
            {
                [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn2Image:nil];
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addHandicapView];
            break;
        case 1:
            [self.navBar setLeftMainTitle:@"分时图"];
            [self.navBar setRightImage:[UIImage imageNamed:@"ic_lightning"]];
            if(_model.isMyContract == 1)
            {
                [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn2Image:nil];
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addTimelineView];
            break;
        case 2:
            [self.navBar setLeftMainTitle:@"k线图"];
            [self.navBar setRightImage:[UIImage imageNamed:@"ic_clock"]];
            [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_lightning"]];
            if(_model.isMyContract == 1)
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addKlineView];
            break;
        case 3:
            [self.navBar setLeftMainTitle:@"下单"];
            [self.navBar setRightImage:[UIImage imageNamed:@"ic_refresh"]];
            [self.navBar setRightBtn1Image:nil];
            [self.navBar setRightBtn2Image:nil];
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:YES];
            [self.navBar.leftSubLabel setHidden:YES];
            [self.navBar.titleLabel setHidden:NO];
            [self.navBar setTitle:[[Account sharedAccount] getUid]];
            [self addBuyView];
            break;
        default:
            break;
    }
    currentPosition = position;

}


-(void)OnTimeSelect:(NSInteger)position
{
    if(_candleView)
    {
        [_candleView update:position];
    }
}


@end
