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
#import "WarnContractViewController.h"
#import "LoginModel.h"
#import "MoneyDetailViewController.h"
#import "MoneyManageViewController.h"
#import "AboutViewController.h"
#import "ManageViewController.h"

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
//    titleLabel.frame = CGRectMake(90, StatuBar_HEIGHT + (NavigationBar_HEIGHT - height)/2, SCREEN_WIDTH - 60-60, height);
    titleLabel.frame = CGRectMake(30, StatuBar_HEIGHT + (NavigationBar_HEIGHT - height)/2, SCREEN_WIDTH - 60-60, height);
}


-(void)initMenu
{
    _tableView = [[UITableView alloc]init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH - 60, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT));
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
            [MoneyDetailViewController show:self.controller];
            break;
        case 1:
            [MoneyManageViewController show:self.controller];
            break;
        case 2:
            [MyContractViewController show:self.controller];
            break;
        case 3:
            [ManageViewController show:self.controller];
            break;
        case 4:
            [AboutViewController show:self.controller];
            break;
        case 5:
            [self logout];
            
            break;
    
            
        default:
            break;
    }
}



#pragma mark 登出
-(void)logout
{

    LoginModel *model = [[LoginModel alloc]init];
    model.strUserName = [[Account sharedAccount]getUid];
    model.sessionId = [[Account sharedAccount]getSessionId];
    
    [JSONUtil parse:Request_Logout params:[JSONUtil parseDic:model]];

    NSMutableDictionary *dic = [JSONUtil parseDic:model];
    NSString *jsonStr = dic.mj_JSONString;
    [self requestLogout:jsonStr];
}


-(void)requestLogout : (NSString *)jsonStr
{

    [[HttpRequest sharedHttpRequest]post:jsonStr view:self.controller.view success:^(id responseObject) {
        
    } fail:^(NSError *error) {
    }];
}
@end
