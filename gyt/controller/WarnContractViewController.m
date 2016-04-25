//
//  WarnContractViewController.m
//  gyt
//
//  Created by by.huang on 16/4/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "WarnContractViewController.h"
#import "ContractDB.h"
#import "ByDynamicTableView.h"

@interface WarnContractViewController ()

@property (strong , nonatomic) NSMutableArray *datas;

@property (strong , nonatomic) ByDynamicTableView *dynamicTableView;

@end

@implementation WarnContractViewController

+(void)show : (SlideNavigationController *)controller
{
    WarnContractViewController *targetController = [[WarnContractViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = SUB_COLOR;
    _datas = [[ContractDB sharedContractDB] queryAll:DBWarnContractTable];
    [self initView];
}


-(void)initView
{
    [self initNavigationBar];
    
    NSArray *widths = @[@"1",@"1",@"1",@"1"];
    NSArray *headers = @[@"名称",@"上限",@"下限",@"最新"];
    _dynamicTableView = [[ByDynamicTableView alloc]initWithData:Default_Frame array:_datas maxWidth:SCREEN_WIDTH type:Warn];
    [_dynamicTableView setHeaders:widths headers:headers];
    [self.view addSubview:_dynamicTableView];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"预警合约列表"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
