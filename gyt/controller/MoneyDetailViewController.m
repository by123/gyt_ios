//
//  MoneyDetailViewController.m
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyDetailViewController.h"
#import "InsetTextField.h"
#import "ByTabView.h"
#import "MoneyDetailModel.h"
#import "MoneyDetailCell.h"
#import "AddViewController.h"
#import "ReduceViewController.h"
#import "QueryRequest.h"


#define Button_Height 50
#define Item_Height 30

@interface MoneyDetailViewController ()

//银转期（入金）
@property (strong, nonatomic) UIButton *increseMoney;

//期转银（出金）
@property (strong, nonatomic) UIButton *decreseMoney;

//金额
@property (strong, nonatomic) InsetTextField *moneyTextField;

//个人信息
@property (strong, nonatomic) UITableView *tableView;

//数据
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation MoneyDetailViewController


+(void)show : (SlideNavigationController *)controller
{
    MoneyDetailViewController *targetController = [[MoneyDetailViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAccountDetailData:) name:AccountDetailData object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handlePushData:) name:PushData object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AccountDetailData object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PushData object:nil];
}


-(void)initView
{
    [self initNavigationBar];
    [self initBody];
    [self initBottomView];
  
    NSString *moneyDetailStr = [[NSUserDefaults standardUserDefaults] objectForKey:MoneyInfo];
    MoneyDetailModel *moneyDetailModel = [MoneyDetailModel mj_objectWithKeyValues:moneyDetailStr];
    _datas = [MoneyDetailModel getData : moneyDetailModel];
    [_tableView reloadData];
    [self requestAccountInfo];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"我的资金"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}


-(void)initBody
{
    UIView *rootView = [[UIView alloc]initWithFrame:Default_Frame];
    [self.view addSubview:rootView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#333333"];
    _tableView.frame = CGRectMake(0,0, SCREEN_WIDTH, rootView.height - Button_Height);
    [rootView addSubview:_tableView];
}


-(void)initBottomView
{
    _increseMoney = [[UIButton alloc]init];
    [_increseMoney setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_increseMoney setTitle:@"银行转期货" forState:UIControlStateNormal];
    _increseMoney.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _increseMoney.frame = CGRectMake(0, SCREEN_HEIGHT-Button_Height, SCREEN_WIDTH/2, Button_Height);
    [_increseMoney setBackgroundImage:[AppUtil imageWithColor:BACKGROUND_COLOR] forState:UIControlStateNormal];
    [_increseMoney setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateHighlighted];
    [_increseMoney addTarget:self action:@selector(OnBankToFuture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_increseMoney];
    
    
    _decreseMoney = [[UIButton alloc]init];
    [_decreseMoney setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_decreseMoney setTitle:@"期货转银行" forState:UIControlStateNormal];
    _decreseMoney.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _decreseMoney.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - Button_Height, SCREEN_WIDTH/2, Button_Height);
    [_decreseMoney setBackgroundImage:[AppUtil imageWithColor:BACKGROUND_COLOR] forState:UIControlStateNormal];
    [_decreseMoney setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateHighlighted];
    [_decreseMoney addTarget:self action:@selector(OnFutureToBank) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_decreseMoney];
    
    UIView *startLineView = [[UIView alloc]init];
    startLineView.backgroundColor = [UIColor blackColor];
    startLineView.frame = CGRectMake(0, SCREEN_HEIGHT - Button_Height+ 0.5, SCREEN_WIDTH, 0.5);
    [self.view addSubview:startLineView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - Button_Height + 10, 0.5, 30);
    [self.view addSubview:lineView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        return 0;
    }
    return [_datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Item_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyDetailCell *cell = [[MoneyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MoneyDetailCell identify]];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [cell setData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 银行转期货
-(void)OnBankToFuture
{
    [AddViewController show:self type:CashType_In];
}


#pragma mark 期货转银行
-(void)OnFutureToBank
{
    [ReduceViewController show:self];
}



#pragma mark 请求资金信息
-(void)requestAccountInfo
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:XT_CAccountDetail];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:XT_CAccountDetail];
}



#pragma mark 处理资金变化信息
-(void)handlePushData : (NSNotification *)notification
{
    PackageModel *model = notification.object;
    NSString *dataStr = model.result;
    [[PushDataHandle sharedPushDataHandle] handlePushData:dataStr delegate :self];
}

#pragma mark 处理资金请求信息
-(void)handleAccountDetailData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = notification.object;
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    NSMutableArray *array = model.datas;
    if(!IS_NS_COLLECTION_EMPTY(array))
    {
        //多种资金
        for(id obj in array)
        {
            MoneyDetailModel *moneyDetailModel = [MoneyDetailModel mj_objectWithKeyValues:obj];
            [self updateInfo:moneyDetailModel];
        }
    }
    else{
        [ByToast showErrorToast:@"获取资金信息失败，请重试!"];
    }

}

-(void)pushResult:(id)data
{
    if([data isKindOfClass:[MoneyDetailModel class]])
    {
        MoneyDetailModel *model = data;
        [self updateInfo:model];
    }
}

-(void)updateInfo : (MoneyDetailModel *)model
{
    [[NSUserDefaults standardUserDefaults]setValue:model.mj_JSONString forKey:MoneyInfo];
    _datas = [MoneyDetailModel getData : model];
    [_tableView reloadData];
    
}





@end
