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

#define Item_Height 110

@interface MoneyManageViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation MoneyManageViewController

+(void)show : (SlideNavigationController *)controller
{
    MoneyManageViewController *targetController = [[MoneyManageViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc]init];
    AccessGoldModel *model = [AccessGoldModel new];
    model.m_strSerialNo = @"8623234234234";
    model.m_applyDate = @"2016-05-12";
    model.m_applyTime = @"16:26";
    model.m_nMoneyType = MoneyType_RMB;
    model.m_nPayType = PayType_ON_LINE;
    model.m_nCashType = CashType_Out;
    model.m_nStatus = CashApplicationStatus_Submit;
    model.m_dCashValue = 8000.000f;
    
    for(int i =0 ; i < 50 ; i++)
    {
        [_datas addObject:model];
    }
    [self initView];
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
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"出入金管理"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
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
      [cell setData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setRootViewSelect:YES];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [MoneyManageDetailViewController show:self model:[_datas objectAtIndex:indexPath.row]];
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

@end
