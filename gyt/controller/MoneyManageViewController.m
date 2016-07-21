//
//  MoneyManageViewController.m
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyManageViewController.h"
#import "MoneyManageDetailViewController.h"
#import "MoneyManageCell.h"
#import "AccessGoldModel.h"
#import "TZDatePickerView.h"

#define Item_Height 110

@interface MoneyManageViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) TZDatePickerView *pickerView;

@end

@implementation MoneyManageViewController

+(void)show : (SlideNavigationController *)controller
{
    MoneyManageViewController *targetCoxntroller = [[MoneyManageViewController alloc]init];
    [controller pushViewController:targetCoxntroller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleCashApplyInfoData:) name:CashApplyInfoData object:nil];
    _datas = [[NSMutableArray alloc]init];
    [self requestCashApplyInfo];
    [self initView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CashApplyInfoData object:nil];

}

-(void)initView
{
    [self initNavigationBar];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#333333"];
    _tableView.frame = Default_Frame;
    [self.view addSubview:_tableView];
    
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setTitle:@"出入金管理"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
    [self.navBar setRightImage:[UIImage imageNamed:@"ic_filter"]];

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
    MoneyManageCell *cell = [[MoneyManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MoneyManageCell identify]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
      AccessGoldModel *model = [AccessGoldModel mj_objectWithKeyValues:[_datas objectAtIndex:indexPath.row]];
      [cell setData:model];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setRootViewSelect:YES];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        AccessGoldModel *model = [AccessGoldModel mj_objectWithKeyValues:[_datas objectAtIndex:indexPath.row]];
        [MoneyManageDetailViewController show:self model:model];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setRootViewSelect:NO];
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnRightClickCallBack:(NSInteger)position
{
    _pickerView = [[TZDatePickerView alloc]init];
    __weak MoneyManageViewController *weakSelf = self;
    
    _pickerView.gotoSrceenOrderBlock = ^(NSString *beginDateStr,NSString *endDateStr){
        [weakSelf.pickerView hide];
    };
    [_pickerView show];
}


-(void)requestCashApplyInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"sessionId"] = [[Account sharedAccount] getSessionId];
    dic[@"strAccountID"] = [[Account sharedAccount]getUid];
    dic[@"startDate"] = @(0);
    dic[@"endDate"] = @(0);
    NSString *jsonStr = [JSONUtil parse:@"queryAccountCashApplyInfo" params:dic];
    
    
    [[SocketConnect sharedSocketConnect]sendData:jsonStr seq:GYT_CashApplyInfo];
}


-(void)handleCashApplyInfoData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = notification.object;
    _datas = [respondModel.response objectForKey:@"resp"];
    [_tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
