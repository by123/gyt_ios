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


@interface DetailViewController ()

@property (strong, nonatomic) ProductModel *model;

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
      model : (ProductModel *) model
{
    DetailViewController *targetController = [[DetailViewController alloc]init];
    ProductModel *temp = [[ContractDB sharedContractDB] queryItem:DBMyContractTable pid:model.pid];
    if(temp)
    {
        targetController.model = temp;
    }
    else
    {
        targetController.model = model;
    }
    [controller presentViewController:targetController animated:YES completion:nil];

//    [controller.navigationController pushViewController:targetController animated:YES];
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
    [self.navBar setLeftSubTitle:_model.name];
    [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_drawline"]];
    [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_lightning"]];
    [self.navBar setRightBtn3Image:nil];
    currentPosition = 4;
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
    [titleArray addObject:[BottomTabView buildModel:@"新闻" image:[UIImage imageNamed:@"ic_news"]]];
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
    _handicapView = [[HandicapView alloc]init];
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

-(void)OnRightClickCallBack : (NSInteger) position
{
    if(position == 0)
    {
        [[SlideNavigationController sharedInstance]righttMenuSelected:nil];
    }
    else if(currentPosition == 0)
    {
        
    }
    else if(currentPosition == 1)
    {
        if(position == 1)
        {
            //下单
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
    else if(currentPosition == 2)
    {
        if(position == 1)
        {
            //闪电下单
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
        if(position == 1)
        {
            //选时间
        }
        else if(position == 2)
        {
            //下单
        }
        else if(position == 3)
        {
            //加入自选合约
            [self addContract];
        }
        else if(position == 4)
        {
            //加入预警合约
            [self addWarnContract];
        }
    }
    else if(currentPosition == 4)
    {
        if(position == 1)
        {
            //刷新
        }
    }
 
}

#pragma mark 加入自选合约
-(void)addContract
{
    if(_model.isMyContract)
    {
        _model.isMyContract = NO;
        [DialogHelper showWarnTips:[NSString stringWithFormat:@"%@已取消自选合约",_model.name]];
        [[ContractDB sharedContractDB] deleteItem:DBMyContractTable pid:_model.pid];

    }
    else
    {
        _model.isMyContract = YES;
        [DialogHelper showSuccessTips:[NSString stringWithFormat:@"%@已加入自选合约",_model.name]];
        [[ContractDB sharedContractDB] insertItem:DBMyContractTable model:_model];

    }
    [[ContractDB sharedContractDB] updateItem:DBHistoryContractTable pid:_model.pid model:_model];
    [[ContractDB sharedContractDB] updateItem:DBWarnContractTable pid:_model.pid model:_model];

    [self OnSelectPosition:currentPosition];
}

#pragma mark 加入预警合约
-(void)addWarnContract
{
    WarnDialog *dialog = [[WarnDialog alloc]initWithData:_model];
    [self.view addSubview:dialog];
}

-(void)OnSelectPosition:(NSInteger)position
{
    switch (position) {
        case 0:
            [self.navBar setTitle:@"新闻"];
            [self.navBar setRightBtn1Image:nil];
            [self.navBar setRightBtn2Image:nil];
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self addNewsView];
            break;
        case 1:
            [self.navBar setLeftMainTitle:@"详细报价"];
            [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_lightning"]];
            if(_model.isMyContract)
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn3Image:[UIImage imageNamed:@"ic_warn"]];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addHandicapView];
            break;
        case 2:
            [self.navBar setLeftMainTitle:@"分时图"];
            [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_lightning"]];
            if(_model.isMyContract)
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn3Image:[UIImage imageNamed:@"ic_warn"]];

            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addTimelineView];
            break;
        case 3:
            [self.navBar setLeftMainTitle:@"k线图"];
            [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_clock"]];
            [self.navBar setRightBtn2Image:[UIImage imageNamed:@"ic_lightning"]];
            if(_model.isMyContract)
            {
                [self.navBar setRightBtn3Image:[UIImage imageNamed:@"ic_collect_press"]];
            }
            else
            {
                [self.navBar setRightBtn3Image:[UIImage imageNamed:@"ic_collect_normal"]];
            }
            [self.navBar setRightBtn4Image:[UIImage imageNamed:@"ic_warn"]];
            [self.navBar.leftMainLabel setHidden:NO];
            [self.navBar.leftSubLabel setHidden:NO];
            [self.navBar.titleLabel setHidden:YES];
            [self addKlineView];
            break;
        case 4:
            [self.navBar setLeftMainTitle:@"下单"];
            [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_refresh"]];
            [self.navBar setRightBtn2Image:nil];
            [self.navBar setRightBtn3Image:nil];
            [self.navBar setRightBtn4Image:nil];
            [self.navBar.leftMainLabel setHidden:YES];
            [self.navBar.leftSubLabel setHidden:YES];
            [self.navBar.titleLabel setHidden:NO];
            [self.navBar setTitle:@"账户名"];
            [self addBuyView];
            break;
        default:
            break;
    }
    currentPosition = position;

}


@end
