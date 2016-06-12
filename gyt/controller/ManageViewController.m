//
//  ManageViewController.m
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ManageViewController.h"

@interface ManageViewController ()

@end

@implementation ManageViewController

+(void)show : (SlideNavigationController *)controller
{
    ManageViewController *targetController = [[ManageViewController alloc]init];
    [controller pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    [self initNavigationBar];
    self.view.backgroundColor = BACKGROUND_COLOR;
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




@end
