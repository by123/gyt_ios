//
//  DetailViewController.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DetailViewController.h"
#import "SlideNavigationController.h"

@interface DetailViewController ()

@property (strong, nonatomic) ProductModel *model;

@end

@implementation DetailViewController

+(void)show : (BaseViewController *)controller
      model : (ProductModel *) model
{
    DetailViewController *targetController = [[DetailViewController alloc]init];
    targetController.model = model;
    [controller.navigationController pushViewController:targetController animated:YES];
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

}


-(void)initBottomView
{
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    [titleArray addObject:[BottomTabView buildModel:@"新闻" image:[UIImage imageNamed:@"ic_news"]]];
    [titleArray addObject:[BottomTabView buildModel:@"盘口" image:[UIImage imageNamed:@"ic_handicap"]]];
    [titleArray addObject:[BottomTabView buildModel:@"分时" image:[UIImage imageNamed:@"ic_timeline_chart"]]];
    [titleArray addObject:[BottomTabView buildModel:@"k线" image:[UIImage imageNamed:@"ic_kline_chart"]]];
    [titleArray addObject:[BottomTabView buildModel:@"下单" image:[UIImage imageNamed:@"ic_lightnting_buy"]]];
    BottomTabView *tabView = [[BottomTabView alloc]initWithData:titleArray];
    tabView.frame = CGRectMake(0, SCREEN_HEIGHT - kBottomHeight, SCREEN_WIDTH, kBottomHeight);
    tabView.delegate = self;
    [self.view addSubview:tabView];
}


#pragma mark 点击事件回调
-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnRightClickCallBack : (NSInteger) position
{
    switch (position) {
        case 0:
            [[SlideNavigationController sharedInstance]righttMenuSelected:nil];
            break;
            
        default:
            break;
    }
}

-(void)OnSelectPosition:(NSInteger)position
{
    switch (position) {
        case 0:
            [self.navBar setLeftMainTitle:@"新闻"];
            break;
        case 1:
            [self.navBar setLeftMainTitle:@"详细报价"];
            break;
        case 2:
            [self.navBar setLeftMainTitle:@"分时图"];
            break;
        case 3:
            [self.navBar setLeftMainTitle:@"k线图"];
            break;
        case 4:
            [self.navBar setLeftMainTitle:@"下单"];
            break;
        default:
            break;
    }
}


@end
