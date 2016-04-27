
//
//  SearchViewController.m
//  gyt
//
//  Created by by.huang on 16/4/27.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

+(void)show : (BaseViewController *)controller
{
    SearchViewController *openController = [[SearchViewController alloc]init];
    [controller presentViewController:openController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}


-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    [self.navBar setTitle:@"搜索"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_close"]];
    [self.navBar.rightBtn setHidden:YES];
    
}

-(void)OnLeftClickCallback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
