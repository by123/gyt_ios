//
//  LeftMenuViewContriller.m
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LeftMenuViewContriller.h"

@interface LeftMenuViewContriller ()

@end

@implementation LeftMenuViewContriller

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
    [self initNavigationBar];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    [self.navBar.leftBtn setHidden:YES];
    [self.navBar.rightBtn setHidden:YES];
    UILabel *titleLabel = self.navBar.titleLabel;
    titleLabel.text = @"选择页面";
    float height = titleLabel.contentSize.height;
    titleLabel.frame = CGRectMake(30, StatuBar_HEIGHT + (NavigationBar_HEIGHT - height)/2, SCREEN_WIDTH - 60-60, height);
 
    
}

@end
