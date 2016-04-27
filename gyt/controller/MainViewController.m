//
//  MainViewController.m
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenuViewContriller.h"
#import "MainTableCell.h"
#import "ProductModel.h"
#import "MenuModel.h"
#import "DetailViewController.h"
#import "ContractDB.h"
#import "SearchViewController.h"
#define Item_Height 40

@interface MainViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UIButton *updownButton;

@property (strong, nonatomic) UIButton *inventoryButton;

@end

@implementation MainViewController

-(void)testData
{
    [_datas removeAllObjects];
    for(int i =0 ; i < 100 ;i ++)
    {
        ProductModel *model = [[ProductModel alloc]init];
        model.pid = i;
        model.name = [NSString stringWithFormat:@"%@%d",@"橡胶",1600+i];
        model.recentPrice = 2000 + arc4random() % 10000;
        float temp = arc4random() % 100;
        model.updownPrice = temp - 50;
        model.updownPercent = model.updownPrice / 15;
        
        float temp2 = arc4random() %100;
        model.inventory = [NSString stringWithFormat:@"%.f",temp2 * 100];
        float temp3 = arc4random() %100;
        model.dailyInventory = [NSString stringWithFormat:@"%.f",temp3 * 10];
        float temp4 = arc4random() %100;
        model.dealInventory = [NSString stringWithFormat:@"%.f",temp4 * 1000];

        [_datas addObject:model];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc]init];
    [self testData];
    [self initView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateView:) name:Notify_Menu_Title object:nil];
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Notify_Menu_Title object:nil];
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}


#pragma mark 初始化组件
-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#292929"];
    _tableView.frame = CGRectMake(0, StatuBar_HEIGHT + NavigationBar_HEIGHT + 30, SCREEN_WIDTH, SCREEN_HEIGHT - (StatuBar_HEIGHT + NavigationBar_HEIGHT) - 30);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    [self initHeaderView];
}


-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setTitle:@"主力合约"];
    [self.navBar setRightBtn1Image:[UIImage imageNamed:@"ic_search"]];
}

-(void)initHeaderView
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [ColorUtil colorWithHexString:@"#444444"];
    headView.userInteractionEnabled = YES;
    headView.frame = CGRectMake(0, StatuBar_HEIGHT + NavigationBar_HEIGHT , SCREEN_WIDTH, 30);
    [self.view addSubview:headView];
    
    UILabel *nameTitleLabel = [[UILabel alloc]init];
    nameTitleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH * 190 /640, 30);
    nameTitleLabel.text = @"名称";
    nameTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    nameTitleLabel.textColor = [ColorUtil colorWithHexString:@"#ffffff" alpha:0.8f];
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameTitleLabel];
    
    UILabel *priceTitleLabel = [[UILabel alloc]init];
    priceTitleLabel.frame = CGRectMake(SCREEN_WIDTH * 190 /640, 0, SCREEN_WIDTH * 160 /640, 30);
    priceTitleLabel.text = @"最新";
    priceTitleLabel.font = [UIFont systemFontOfSize:15.0f];

    priceTitleLabel.textColor = [ColorUtil colorWithHexString:@"#ffffff" alpha:0.8f];
    priceTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:priceTitleLabel];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    _updownButton = [[UIButton alloc]init];
    _updownButton.frame = CGRectMake(SCREEN_WIDTH * 350 /640, 0, SCREEN_WIDTH * 145 /640, 30);
    NSString *updownTitle = @"涨跌";

    if([userDefaults integerForKey:UserDefault_Updown] == UpdownPercent)
    {
        updownTitle = @"涨幅(%)";
    }
    [_updownButton setTitle:updownTitle forState:UIControlStateNormal];
    [_updownButton setBackgroundColor:[UIColor clearColor]];
    [_updownButton setTitleColor:[ColorUtil colorWithHexString:@"#ffffff" alpha:0.8f] forState:UIControlStateNormal];
    _updownButton.titleLabel.textAlignment =NSTextAlignmentCenter;
    _updownButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];

    [_updownButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_updownButton];
    
    
    NSString *inventoryTitle = @"持仓量";
    switch ([userDefaults integerForKey:UserDefault_Inventory]) {
        case DailyInventory:
            inventoryTitle = @"日增仓";
            break;
        case DealInventory:
            inventoryTitle = @"成交量";
            break;
        default:
            break;
    }

    _inventoryButton = [[UIButton alloc]init];
    _inventoryButton.frame = CGRectMake(SCREEN_WIDTH * 495 /640, 0, SCREEN_WIDTH * 145 /640, 30);
    [_inventoryButton setTitle:inventoryTitle forState:UIControlStateNormal];
    [_inventoryButton setBackgroundColor:[UIColor clearColor]];
    [_inventoryButton setTitleColor:[ColorUtil colorWithHexString:@"#ffffff" alpha:0.8f] forState:UIControlStateNormal];
    _inventoryButton.titleLabel.textAlignment =NSTextAlignmentCenter;
    _inventoryButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [_inventoryButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_inventoryButton];
    
}


#pragma mark 更新布局
-(void)updateView : (NSNotification *)notification
{
    MenuModel *model = notification.object;
    [self.navBar setTitle:model.title];
    
    if([model.title isEqualToString:@"浏览记录列表"])
    {
        _datas = [[ContractDB sharedContractDB] queryAll:DBHistoryContractTable];
        [_tableView reloadData];
    }
    else if([model.title isEqualToString:@"自选合约列表"])
    {
        _datas = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
        [_tableView reloadData];
    }
    else if([model.title isEqualToString:@"预警合约列表"])
    {
        _datas = [[ContractDB sharedContractDB] queryAll:DBWarnContractTable];
        [_tableView reloadData];
    }
    else
    {
        [self testData];
        [_tableView reloadData];
    }

}

#pragma mark 列表处理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Item_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableCell *cell = [[MainTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MainTableCell identify]];
    [cell setBackgroundColor:[UIColor clearColor]];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        ProductModel *model = [_datas objectAtIndex:indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UpdownType updownType = [userDefaults integerForKey:UserDefault_Updown];
        InventoryType inventoryType = [userDefaults integerForKey:UserDefault_Inventory];

        [cell setData:model updown:updownType inventore:inventoryType];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        ProductModel *model = [_datas objectAtIndex:indexPath.row];
        [[ContractDB sharedContractDB] insertItem:DBHistoryContractTable model:model];
        [DetailViewController show:self model:model];
    }
}

#pragma mark 点击回调事件
-(void)OnLeftClickCallback
{
    [[SlideNavigationController sharedInstance]leftMenuSelected:nil];
}

-(void)OnRightClickCallBack : (NSInteger)position
{
    if(position == 1)
    {
        [SearchViewController show:self];
        return;
    }
    [[SlideNavigationController sharedInstance]righttMenuSelected:nil];
}


-(void)OnClick : (id)sender
{
    UIView *view = (UIView *)sender;
    if(view == _updownButton)
    {
      [self selectUpdownType];
    }
    else if(view == _inventoryButton)
    {
        [self selectinventoryType];
    }
}


#pragma mark 点击涨跌按钮
-(void)selectUpdownType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UpdownType type = [userDefaults integerForKey:UserDefault_Updown];
    switch (type) {
        case UpdownPrice:
            [userDefaults setInteger:UpdownPercent forKey:UserDefault_Updown];
            [_updownButton setTitle:@"涨幅(%)" forState:UIControlStateNormal];
            break;
        case UpdownPercent:
            [userDefaults setInteger:UpdownPrice forKey:UserDefault_Updown];
            [_updownButton setTitle:@"涨跌" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

#pragma mark 点击持仓量按钮
-(void)selectinventoryType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    InventoryType type = [userDefaults integerForKey:UserDefault_Inventory];
    switch (type) {
        case Inventory:
            [userDefaults setInteger:DailyInventory forKey:UserDefault_Inventory];
            [_inventoryButton setTitle:@"日增仓" forState:UIControlStateNormal];
            break;
        case DailyInventory:
            [userDefaults setInteger:DealInventory forKey:UserDefault_Inventory];
            [_inventoryButton setTitle:@"成交量" forState:UIControlStateNormal];
            break;
        case DealInventory:
            [userDefaults setInteger:Inventory forKey:UserDefault_Inventory];
            [_inventoryButton setTitle:@"持仓量" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

@end
