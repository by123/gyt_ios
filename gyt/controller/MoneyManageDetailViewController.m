//
//  MoneyManageDetailViewController.m
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyManageDetailViewController.h"
#import "MoneyDetailCell.h"

#define Item_Height 30

@interface MoneyManageDetailViewController ()

@property (strong, nonatomic) AccessGoldModel *model;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MoneyManageDetailViewController

+(void)show : (BaseViewController *)controller
      model : (AccessGoldModel *)model
{
    MoneyManageDetailViewController *targetController = [[MoneyManageDetailViewController alloc]init];
    targetController.model = model;
    [controller.navigationController pushViewController:targetController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [AccessGoldModel getTitleContentData:_model];
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
    _tableView.frame = Default_Frame;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:[NSString stringWithFormat:@"%@详情",[AccessGoldModel getCashType:_model.m_nCashType]]];
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


@end
