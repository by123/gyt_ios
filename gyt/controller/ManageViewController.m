//
//  ManageViewController.m
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ManageViewController.h"
#import "LoginViewController.h"
#import "Test.h"


#define ItemHeight 50
@interface ManageViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ManageViewController
{
    NSArray *array;
}

+(void)show : (SlideNavigationController *)controller
{
    ManageViewController *targetController = [[ManageViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"暂无内容"];
    [self initView];
}

-(void)initView
{
    [self initNavigationBar];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = Default_Frame;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"系统设置"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}


-(void)OnLeftClickCallback
{
   [self.navigationController popViewControllerAnimated:YES];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ManageTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = BACKGROUND_COLOR;
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.textColor  = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}



@end
