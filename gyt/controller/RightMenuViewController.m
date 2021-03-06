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
#import "DealHistoryViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

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

-(void)OnTitleClick
{}


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
            [DealHistoryViewController show:self.controller];
            break;
        case 2:
            [MoneyManageViewController show:self.controller];
            break;
        case 3:
            [MyContractViewController show:self.controller];
            break;
        case 4:
            [ManageViewController show:self.controller];
            break;
        case 5:
            [AboutViewController show:self.controller];
            break;
        case 6:
            [self logout];
            break;
    
            
        default:
            break;
    }
}



#pragma mark 登出
-(void)logout
{
    [[Account sharedAccount] setAutoLogin:NO];
    [[SocketConnect sharedSocketConnect] disconnect];
    [[SocketConnect sharedSocketConnect] connect];
    LoginViewController *targetController = [[LoginViewController alloc]init];
    [self.controller pushViewController:targetController animated:YES];
//    model.strUserName = [[Account sharedAccount]getUid];
//    model.sessionId = [[Account sharedAccount]getSessionId];
//    
//    [JSONUtil parse:Request_Logout params:[JSONUtil parseDic:model]];
//
//    NSMutableDictionary *dic = [JSONUtil parseDic:model];
//    NSString *jsonStr = dic.mj_JSONString;
//    [self requestLogout:jsonStr];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

-(void)requestLogout : (NSString *)jsonStr
{

    [[HttpRequest sharedHttpRequest]post:jsonStr view:self.controller.view success:^(id responseObject) {
        
    } fail:^(NSError *error) {
    }];
}
@end
