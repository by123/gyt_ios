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
#import "AppDelegate.h"

#define Item_Height  IDSPointValue(40)

@interface MainViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *mainDatas;

@property (strong, nonatomic) NSMutableArray *myDatas;

@property (strong, nonatomic) NSMutableArray *historyDatas;

@property (strong, nonatomic) UIButton *updownButton;

@property (strong, nonatomic) UIButton *inventoryButton;

@property (strong, nonatomic) MainItemDialog *mainItemDialog;

@property (strong, nonatomic) ShortCutView *shortCutView;

@end

@implementation MainViewController
{
    CGFloat currentY;
    int current;
//    int count;
}


+(void)show : (BaseViewController *)controller
{
    MainViewController *targetController = [[MainViewController alloc]init];
    [controller.navigationController pushViewController:targetController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mainDatas = [[NSMutableArray alloc]init];
    _myDatas = [[NSMutableArray alloc]init];
    _historyDatas = [[NSMutableArray alloc]init];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAccountData:) name:AccountDetailData object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleInstrumentData:) name:InstrumentDetailData object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handlePushQuoteData:) name:PushQuoteData object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserInfo) name:Notify_Update_AccountInfo object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateView:) name:Notify_Menu_Title object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAutoLogin:) name:LoginData object:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, StatuBar_HEIGHT + NavigationBar_HEIGHT + 30, SCREEN_WIDTH, SCREEN_HEIGHT - (StatuBar_HEIGHT + NavigationBar_HEIGHT) - 30)];
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#292929"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setHidden:YES];
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
        _historyDatas = [[ContractDB sharedContractDB] queryAll:DBHistoryContractTable];
        [_tableView reloadData];
    }
    else if([model.title isEqualToString:@"自选合约列表"])
    {
        _myDatas = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
        [_tableView reloadData];
    }
//    else if([model.title isEqualToString:@"预警合约列表"])
//    {
//        _mainDatas = [[ContractDB sharedContractDB] queryAll:DBWarnContractTable];
//        [_tableView reloadData];
//    }
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
    switch (current) {
        case 0:
            return [_mainDatas count];
        case 1:
            return [_myDatas count];
        case 2:
            return [_historyDatas count];
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Item_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [MainTableCell identify];
    MainTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[MainTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    PushModel *model;
    if(!IS_NS_COLLECTION_EMPTY(_mainDatas) && current == 0)
    {
        model = [_mainDatas objectAtIndex:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_myDatas) && current == 1)
    {
        model = [_myDatas objectAtIndex:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_historyDatas) && current == 2)
    {
        model = [_historyDatas objectAtIndex:indexPath.row];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UpdownType updownType = [userDefaults integerForKey:UserDefault_Updown];
    InventoryType inventoryType = [userDefaults integerForKey:UserDefault_Inventory];
    
    [cell setData:model updown:updownType inventore:inventoryType];
    cell.tag = indexPath.row;
    //添加长按手势
    UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPressGesture];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushModel *model;
    if(!IS_NS_COLLECTION_EMPTY(_mainDatas) && current == 0)
    {
        model = [_mainDatas objectAtIndex:indexPath.row];
        [DetailViewController show:self datas:_mainDatas position:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_myDatas) && current == 1)
    {
        model = [_myDatas objectAtIndex:indexPath.row];
        [DetailViewController show:self datas:_myDatas position:indexPath.row];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_historyDatas) && current == 2)
    {
        model = [_historyDatas objectAtIndex:indexPath.row];
        [DetailViewController show:self datas:_historyDatas position:indexPath.row];
    }
    [[ContractDB sharedContractDB] insertItem:DBHistoryContractTable model:model];
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
            [_tableView reloadData];
            break;
        case 1:
            [self.navBar setTitle:@"自选合约 ▼"];
            [_myDatas removeAllObjects];
            _myDatas = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
            [_tableView reloadData];
            break;
        case 2:
            [self.navBar setTitle:@"历史浏览记录 ▼"];
            [_historyDatas removeAllObjects];
            _historyDatas = [[ContractDB sharedContractDB] queryAll:DBHistoryContractTable];
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
        [SearchViewController show:self datas:_mainDatas];
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
    PushModel *model;
    if(!IS_NS_COLLECTION_EMPTY(_mainDatas) && current == 0)
    {
        model = [_mainDatas objectAtIndex:cell.tag];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_myDatas) && current == 1)
    {
        model = [_myDatas objectAtIndex:cell.tag];
    }
    else if(!IS_NS_COLLECTION_EMPTY(_historyDatas) && current == 2)
    {
        model = [_historyDatas objectAtIndex:cell.tag];
    }
    CGFloat height = Item_Height * (cell.tag + 1) + StatuBar_HEIGHT + NavigationBar_HEIGHT + 30 - currentY ;
    [_mainItemDialog updateView:model position:cell.tag height:height];
    [_mainItemDialog setLeftImage :model.isMyContract];
    [_mainItemDialog setHidden:NO];
    
}

#pragma mark 点击加入自选合约
-(void)OnLeftClicked : (PushModel *)model
{
    if(model.isMyContract == 1)
    {
        model.isMyContract = 0;
        [_mainItemDialog setLeftImage : model.isMyContract];
        [ByToast showWarnToast:[NSString stringWithFormat:@"%@已取消自选合约",model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] deleteItem:DBMyContractTable instrumentid:model.m_strInstrumentID];
        
        [_myDatas removeObject:model];
        [_tableView reloadData];
    }
    else
    {
        model.isMyContract = 1;
        [_mainItemDialog setLeftImage : model.isMyContract];
        [ByToast showNormalToast:[NSString stringWithFormat:@"%@已加入自选合约",model.m_strInstrumentID]];
        [[ContractDB sharedContractDB] insertItem:DBMyContractTable model:model];
        
    }
    [[ContractDB sharedContractDB] updateItem:DBHistoryContractTable instrumentid:model.m_strInstrumentID model:model];
}

#pragma mark 点击下单
-(void)OnRightClicked : (PushModel *)model position:(NSInteger)position
{
     _shortCutView = [[ShortCutView alloc]initWithView:self.view model:model];
    [self.view addSubview:_shortCutView];
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
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:XT_CAccountDetail];
}

#pragma mark 获取合约信息
-(void)requestProductInfo
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:XT_CInstrumentDetail];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:XT_CInstrumentDetail];
}



#pragma mark 主推订阅
-(void)requestsubMultiPrice
{
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];

    for(PushModel *model in _mainDatas)
    {
        if([model.m_strInstrumentID containsString:@"HSI"])
        {
            [array1 addObject:model.m_strExchangeID];
            [array2 addObject:model.m_strInstrumentID];
        }
    }

   
    PushRequestModel *model = [[PushRequestModel alloc]init];
    model.sessionId = [[Account sharedAccount]getSessionId];
    model.platformID =PLATFORM_OUTTER_YN_MN;
    model.market = array1 ;
    model.code = array2;
    
    NSString *jsonStr = [JSONUtil parse:@"subMultiPrice" params:model.mj_keyValues];
    
    [[SocketConnect sharedSocketConnect]sendData:jsonStr seq:0];
}



#pragma mark 处理资金信息
-(void)handleAccountData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = notification.object;
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    NSMutableArray *array = model.datas;
    if(!IS_NS_COLLECTION_EMPTY(array))
    {
        for(id obj in array)
        {
            MoneyDetailModel *moneyDetailModel = [MoneyDetailModel mj_objectWithKeyValues:obj];
            [[NSUserDefaults standardUserDefaults]setValue:moneyDetailModel.mj_JSONString forKey:MoneyInfo];
        }
    }
    else{
        [ByToast showErrorToast:@"获取资金信息失败，请重试!"];
    }
}

#pragma mark 处理合约信息
-(void)handleInstrumentData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = notification.object;
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    [_mainDatas removeAllObjects];
    for(id temp in model.datas)
    {
        [_mainDatas addObject:[PushModel mj_objectWithKeyValues:temp]];
    }
    NSMutableArray *contractDatas = [[ContractDB sharedContractDB] queryAll:DBContractTable];
    for(int i = 0 ; i < [_mainDatas count] ; i++ )
    {
        PushModel *tempModel = [_mainDatas objectAtIndex:i];
        if(!IS_NS_COLLECTION_EMPTY(contractDatas))
        {
            for(PushModel *model in contractDatas)
            {
                if([tempModel.m_strInstrumentID isEqualToString:model.m_strInstrumentID])
                {
                    model.m_strProductID = tempModel.m_strProductID;
                    model.m_dPriceTick = tempModel.m_dPriceTick;
                    [_mainDatas replaceObjectAtIndex:i withObject:model];
                }
            }
        }
    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.mainDatas =  _mainDatas;
    [_tableView setHidden:NO];
    [_tableView reloadData];
    [self requestsubMultiPrice];

}


#pragma mark 处理行情主推数据
-(void)handlePushQuoteData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:notification.object];
    id data  = [respondModel.params objectForKey:@"data"];
    PushModel *pushModel = [PushModel mj_objectWithKeyValues:data];
    
    if(!IS_NS_COLLECTION_EMPTY(_mainDatas))
    {
        for(PushModel *model in _mainDatas)
        {
            if([model.m_strInstrumentID isEqualToString:pushModel.m_strInstrumentID] &&(pushModel.m_dLastPrice != model.m_dLastPrice || pushModel.m_nVolume != model.m_nVolume))
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
                model.m_strUpdateTime = pushModel.m_strUpdateTime;
                [_tableView reloadData];
                break;
            }
        }
    }

    if(_shortCutView)
    {
        [_shortCutView handlePushQuoteData:pushModel];
    }
}



/*                    if(model.isMyContract)
 {
 [[ContractDB sharedContractDB]updateItem:DBMyContractTable instrumentid:model.m_strInstrumentID model:model];
 }
 [[ContractDB sharedContractDB] insertItem:DBContractTable model:pushModel];
 [[ContractDB sharedContractDB]updateItem:DBHistoryContractTable instrumentid:model.m_strInstrumentID model:model];
 */

#pragma mark 处理登陆信息
-(void)handleAutoLogin : (NSNotification *)notification
{
    BaseRespondModel *model = notification.object;
    if(model.error.ErrorID == 0)
    {
        NSString *sessionId = [model.response objectForKey:@"sessionId"];
        
        [MobClick profileSignInWithPUID:[[Account sharedAccount] getUid]];
        
        [[Account sharedAccount]saveSessionid:sessionId];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Update_AccountInfo object:nil];
    }
    else
    {
        [ByToast showErrorToast:@"登录失败!"];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
