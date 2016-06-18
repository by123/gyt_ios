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
#import "PushModel.h"
#import "MenuModel.h"
#import "DetailViewController.h"
#import "ContractDB.h"
#import "SearchViewController.h"
#import "UserInfoDataModel.h"
#import "UserInfoModel.h"
#import "UserRespondModel.h"
#import "QueryRequest.h"
#import "MoneyDetailModel.h"
#import "LoginModel.h"
#import "IPMacUtil.h"
#import "UUID.h"
#import "PushRequestModel.h"
#import "PushModel.h"
#import "ShortCutView.h"

#define Item_Height 40

@interface MainViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UIButton *updownButton;

@property (strong, nonatomic) UIButton *inventoryButton;

@property (strong, nonatomic) MainItemDialog *mainItemDialog;

@end

@implementation MainViewController
{
    CGFloat currentY;
    int current;
}


+(void)show : (BaseViewController *)controller
{
    MainViewController *targetController = [[MainViewController alloc]init];
    [controller.navigationController pushViewController:targetController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _datas = [[NSMutableArray alloc]init];
    [self initView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserInfo) name:Notify_Update_AccountInfo object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateView:) name:Notify_Menu_Title object:nil];
    
 
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Notify_Menu_Title object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Notify_Update_AccountInfo object:nil];
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
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
    
    if([[Account sharedAccount]isLogin])
    {
        [self getUserInfo];
    }
    
    [self initMainItemDialog];
}


-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setTitle:@"主力合约 ▼"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_right_menu"]];
    [self.navBar setRightImage:[UIImage imageNamed:@"ic_search"]];
    [self.navBar setRightBtn1Image:nil];
    [self.navBar setRightBtn2Image:nil];
    [self.navBar setRightBtn3Image:nil];
    [self.navBar setRightBtn4Image:nil];

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
    NSString *updownTitle = @"涨跌 ▼";

    if([userDefaults integerForKey:UserDefault_Updown] == UpdownPercent)
    {
        updownTitle = @"涨幅(%) ▼";
    }
    [_updownButton setTitle:updownTitle forState:UIControlStateNormal];
    [_updownButton setBackgroundColor:[UIColor clearColor]];
    [_updownButton setTitleColor:[ColorUtil colorWithHexString:@"#ffffff" alpha:0.8f] forState:UIControlStateNormal];
    _updownButton.titleLabel.textAlignment =NSTextAlignmentCenter;
    _updownButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];

    [_updownButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_updownButton];
    
    
    NSString *inventoryTitle = @"持仓量 ▼";
    switch ([userDefaults integerForKey:UserDefault_Inventory]) {
        case DailyInventory:
            inventoryTitle = @"日增仓 ▼";
            break;
        case DealInventory:
            inventoryTitle = @"成交量 ▼";
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

-(void)initMainItemDialog
{
    _mainItemDialog = [[MainItemDialog alloc]init];
    _mainItemDialog.delegate = self;
    [self.view addSubview:_mainItemDialog];
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
    [cell setOpaque:YES];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = SELECT_COLOR;
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        PushModel *model = [_datas objectAtIndex:indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UpdownType updownType = [userDefaults integerForKey:UserDefault_Updown];
        InventoryType inventoryType = [userDefaults integerForKey:UserDefault_Inventory];
        
        [cell setData:model updown:updownType inventore:inventoryType];
        cell.tag = indexPath.row;
        //添加长按手势
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGesture];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        PushModel *model = [_datas objectAtIndex:indexPath.row];
        [[ContractDB sharedContractDB] insertItem:DBHistoryContractTable model:model];
        [DetailViewController show:self model:model position:indexPath.row];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    currentY = scrollView.contentOffset.y;
}


#pragma mark 点击回调事件
-(void)OnLeftClickCallback
{
    [[SlideNavigationController sharedInstance]leftMenuSelected:nil];
}


-(void)OnTitleClick
{
    current ++;
    if(current > 2)
    {
        current = 0;
    }
    switch (current) {
        case 0:
            [self.navBar setTitle:@"主力合约 ▼"];
            [_datas removeAllObjects];
            [self requestProductInfo];
            break;
        case 1:
            [self.navBar setTitle:@"自选合约 ▼"];
            [_datas removeAllObjects];
            _datas = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
            [_tableView reloadData];
            break;
        case 2:
            [self.navBar setTitle:@"历史浏览记录 ▼"];
            [_datas removeAllObjects];
            _datas = [[ContractDB sharedContractDB] queryAll:DBHistoryContractTable];
            [_tableView reloadData];
            break;
            
        default:
            break;
    }

}

-(void)OnRightClickCallBack : (NSInteger)position
{
    if(position == 0)
    {
        [SearchViewController show:self datas:_datas];
        return;
    }
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

#pragma mark 长按cell处理
-(void)longPress : (UILongPressGestureRecognizer *)recongizer
{
    MainTableCell *cell = (MainTableCell *)recongizer.view;
    NSLog(@"%d",cell.tag);
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        PushModel *model = [_datas objectAtIndex:cell.tag];
        CGFloat height = Item_Height * (cell.tag + 1) + StatuBar_HEIGHT + NavigationBar_HEIGHT + 30 - currentY ;
        [_mainItemDialog updateView:model position:cell.tag height:height];
        [_mainItemDialog setLeftImage :model.isMyContract];
        [_mainItemDialog setHidden:NO];
    }
    
}

#pragma mark 点击加入自选合约
-(void)OnLeftClicked : (PushModel *)model
{
    if(model.isMyContract == 1)
    {
        model.isMyContract = 0;
        [_mainItemDialog setLeftImage : model.isMyContract];
        [DialogHelper showWarnTips:[NSString stringWithFormat:@"%@已取消自选合约",model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] deleteItem:DBMyContractTable instrumentid:model.m_strInstrumentID];
    }
    else
    {
        model.isMyContract = 1;
        [_mainItemDialog setLeftImage : model.isMyContract];
        [DialogHelper showSuccessTips:[NSString stringWithFormat:@"%@已加入自选合约",model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] insertItem:DBMyContractTable model:model];
        
    }
    [[ContractDB sharedContractDB] updateItem:DBHistoryContractTable instrumentid:model.m_strInstrumentID model:model];
}

#pragma mark 点击下单
-(void)OnRightClicked : (PushModel *)model position:(NSInteger)position
{
    ShortCutView *shortCutView = [[ShortCutView alloc]initWithView:self.view model:model];
    [self.view addSubview:shortCutView];
//    [DetailViewController show:self model:model position:position];
}


#pragma mark 点击涨跌按钮
-(void)selectUpdownType
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UpdownType type = [userDefaults integerForKey:UserDefault_Updown];
    switch (type) {
        case UpdownPrice:
            [userDefaults setInteger:UpdownPercent forKey:UserDefault_Updown];
            [_updownButton setTitle:@"涨幅(%) ▼" forState:UIControlStateNormal];
            break;
        case UpdownPercent:
            [userDefaults setInteger:UpdownPrice forKey:UserDefault_Updown];
            [_updownButton setTitle:@"涨跌 ▼" forState:UIControlStateNormal];
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
            [_inventoryButton setTitle:@"日增仓 ▼" forState:UIControlStateNormal];
            break;
        case DailyInventory:
            [userDefaults setInteger:DealInventory forKey:UserDefault_Inventory];
            [_inventoryButton setTitle:@"成交量 ▼" forState:UIControlStateNormal];
            break;
        case DealInventory:
            [userDefaults setInteger:Inventory forKey:UserDefault_Inventory];
            [_inventoryButton setTitle:@"持仓量 ▼" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [_tableView reloadData];
}


#pragma mark 获取用户资料
-(void)getUserInfo
{
    UserInfoModel *data = [[UserInfoModel alloc]init];
    data.m_strAccountID = [[Account sharedAccount] getUid];
    data.m_nAccountType = AT_OUTTER_FUTURE;
    data.m_bSubAccount = @(true);
    NSString *accountInfoStr = [JSONUtil parseStr:data];
    [[Account sharedAccount] saveAccountInfo:accountInfoStr];
    NSLog(@"用户信息->%@",accountInfoStr);
    [self requestAccountInfo];
    [self requestProductInfo];
}

#pragma mark 请求资金信息
-(void)requestAccountInfo
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:XT_CAccountDetail];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:XT_CAccountDetail];
}

#pragma mark 获取合约信息
-(void)requestProductInfo
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:XT_CInstrumentDetail];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:XT_CInstrumentDetail];
}



#pragma mark 主推订阅
-(void)requestsubMultiPrice
{
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];

    for(PushModel *model in _datas)
    {
        [array1 addObject:model.m_strExchangeID];
        [array2 addObject:model.m_strInstrumentID];
    }

    PushRequestModel *model = [[PushRequestModel alloc]init];
    model.sessionId = [[Account sharedAccount]getSessionId];
    model.platformID =PLATFORM_OUTTER_YN_MN;
    model.market = array1 ;
    model.code = array2;
    
    NSString *jsonStr = [JSONUtil parse:@"subMultiPrice" params:model.mj_keyValues];
    
    [[SocketConnect sharedSocketConnect]sendData:jsonStr delegate:self seq:0];
}


#pragma mark 接收到服务端传来的数据
-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.seq == XT_CAccountDetail &&  packageModel.result)
    {
        BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
//        NSLog(@"资金信息->%@",model.d);
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
            //多种资金
            for(id obj in array)
            {
                MoneyDetailModel *moneyDetailModel = [MoneyDetailModel mj_objectWithKeyValues:obj];
                [[NSUserDefaults standardUserDefaults]setValue:moneyDetailModel.mj_JSONString forKey:MoneyInfo];
            }
            [DialogHelper showSuccessTips:@"获取资金信息成功!"];

        }
        else{
            [DialogHelper showTips:@"获取资金信息失败，请重试!"];
        }
    }
    else if(packageModel.seq == XT_CInstrumentDetail &&  packageModel.result)
    {
        NSLog(@"合约信息->%@",packageModel.result);
        BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
            [_datas removeAllObjects];
            for(id obj in array)
            {
                PushModel *productModel = [PushModel mj_objectWithKeyValues:obj];
                PushModel *model = [[ContractDB sharedContractDB]queryItem:DBMyContractTable instrumentid:productModel.m_strInstrumentID];
                if(model)
                {
                    productModel.isMyContract = model.isMyContract;
                }
//                if([productModel.m_strInstrumentID isEqualToString:@"CN 1606"])
//                {
                    [_datas addObject:productModel];
//                }
            }
        }
        [_tableView reloadData];
        [self requestsubMultiPrice];

    }
//    else if(packageModel.seq == 0)
//    {
//        BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];
//        if(respondModel.status == 0)
//        {
//            [DialogHelper showTips:@"订阅成功"];
//        }
//    }
//
    if(packageModel.cmd == 4)
    {
        BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];

        if([respondModel.method isEqualToString:@"pushQuoteData"])
        {
            //行情主推
            id params = respondModel.params;
            id data  = [params objectForKey:@"data"];
            PushModel *pushModel = [PushModel mj_objectWithKeyValues:data];
            [self handleResult:pushModel];
        }

    }

}

#pragma mark 处理行情变化
-(void)handleResult : (PushModel *)pushModel
{
    NSMutableArray *temps = [[NSMutableArray alloc]init];
    [temps addObjectsFromArray:_datas];
    
    if(!IS_NS_COLLECTION_EMPTY(temps))
    {
        int count = [temps count];
        for(int i = 0 ; i< count; i++)
        {
            PushModel *model = [temps objectAtIndex:i];
            if([model.m_strInstrumentID isEqualToString:pushModel.m_strInstrumentID])
            {
                //无数据变化不刷新
                if(pushModel.m_dLastPrice == model.m_dLastPrice && pushModel.m_nVolume == model.m_nVolume)
                {
                    return;
                }
                else
                {
                    model.m_dLastPrice = pushModel.m_dLastPrice;
                    model.m_dOpenPrice = pushModel.m_dOpenPrice;
                    model.m_nVolume = pushModel.m_nVolume;
                    model.m_dAskPrice1 = pushModel.m_dAskPrice1;
                    model.m_dBidPrice1 = pushModel.m_dBidPrice1;
                    model.m_dHighestPrice = pushModel.m_dHighestPrice;
                    model.m_dLowestPrice = pushModel.m_dLowestPrice;
                    model.m_nAskVolume1 = pushModel.m_nAskVolume1;
                    model.m_nBidVolume1 = pushModel.m_nBidVolume1;
                    if(model.isMyContract)
                    {
                        [[ContractDB sharedContractDB]updateItem:DBMyContractTable instrumentid:model.m_strInstrumentID model:model];
                    }
                    [[ContractDB sharedContractDB]updateItem:DBHistoryContractTable instrumentid:model.m_strInstrumentID model:model];
                
                    NSLog(@"%@->%f->%d",model.m_strInstrumentID,model.m_dLastPrice,model.m_nVolume);
                    //只刷新变化的那一行
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
                    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    break;
                }
            }
        }
    
    }
 
}
@end
