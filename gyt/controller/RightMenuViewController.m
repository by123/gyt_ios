//
//  rightMenuViewController.m
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "RightMenuViewController.h"
#import "RightMenuCell.h"
#import "RightMenuModel.h"
#import "SlideNavigationController.h"
#import "MyContractViewController.h"

@interface RightMenuViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
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

-(void)initView
{
    _datas = [RightMenuModel getDatas];

    [self initNavigationBar];
    [self initMenu];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    [self.navBar.leftBtn setHidden:YES];
    [self.navBar.rightBtn setHidden:YES];
    UILabel *titleLabel = self.navBar.titleLabel;
    titleLabel.text = @"主菜单";
    float height = titleLabel.contentSize.height;
    titleLabel.frame = CGRectMake(90, StatuBar_HEIGHT + (NavigationBar_HEIGHT - height)/2, SCREEN_WIDTH - 60-60, height);
}


-(void)initMenu
{
    _tableView = [[UITableView alloc]init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame = CGRectMake(60, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH - 60, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RightMenuCell *cell = [[RightMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RightMenuCell identify]];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [cell setData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger position = indexPath.row;
    switch (position) {
        case 0:
            [MyContractViewController show:self.controller];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

@end
