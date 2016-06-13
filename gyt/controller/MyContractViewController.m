//
//  MyContractViewController.m
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MyContractViewController.h"
#import "PushModel.h"
#import "ContractDB.h"
#import "MyContractCell.h"

@interface MyContractViewController()

@property (strong , nonatomic) UITableView *tableView;

@property (strong , nonatomic) NSMutableArray *datas;

@end

@implementation MyContractViewController

+(void)show : (SlideNavigationController *)controller
{
    MyContractViewController *targetController = [[MyContractViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    _datas = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
    [self initView];
}

-(void)initView
{
    [self initNavigationBar];
    _tableView = [[UITableView alloc]init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    UIButton *rightBtn = self.navBar.rightBtn;
    [rightBtn setHidden:NO];
    [rightBtn setBackgroundColor:[ColorUtil colorWithHexString:@"#c3262a"]];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 4;
    [rightBtn setImage:nil forState:UIControlStateNormal];
    [rightBtn setTitle:@"全部删除" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 75 - 10, StatuBar_HEIGHT +8, 75, NavigationBar_HEIGHT-16);
    [self.navBar setTitle:@"自选合约列表"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        return [_datas count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyContractCell *cell = [[MyContractCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyContractCell identify]];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        PushModel *model = [_datas objectAtIndex:indexPath.row];
        [cell setData:model.m_strInstrumentID];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        PushModel *model = [_datas objectAtIndex:indexPath.row];
        [_datas removeObject:model];
        [[ContractDB sharedContractDB] deleteItem:DBMyContractTable instrumentid:model.m_strInstrumentID];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
          withRowAnimation:UITableViewRowAnimationTop];
    }
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)OnRightClickCallBack:(NSInteger)position
{
    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        [DialogHelper showWarnTips:@"没有自选合约，不能进行删除操作"];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除全部自选合约" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[ContractDB sharedContractDB]deleteTable:DBMyContractTable];
        [[ContractDB sharedContractDB]createTable:DBMyContractTable];
        [_datas removeAllObjects];
        [_tableView reloadData];

    }
}

@end
