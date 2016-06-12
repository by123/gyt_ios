//
//  AboutViewController.m
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

+(void)show : (SlideNavigationController *)controller
{
    AboutViewController *targetController = [[AboutViewController alloc]init];
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
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"icon"];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, 80, 80);
    imageView.centerX = SCREEN_WIDTH/2;
    imageView.centerY = SCREEN_HEIGHT/3;
    [self.view addSubview:imageView];
    
    UILabel *appNameLabel = [[UILabel alloc]init];
    appNameLabel.text = AppName;
    appNameLabel.textColor = TEXT_COLOR;
    appNameLabel.font = [UIFont systemFontOfSize:16.0f];
    appNameLabel.frame = CGRectMake(0, 0, appNameLabel.contentSize.width, appNameLabel.contentSize.height);
    appNameLabel.centerX = SCREEN_WIDTH/2;
    appNameLabel.centerY = SCREEN_HEIGHT / 3 + 80;
    [self.view addSubview:appNameLabel];
    
    UILabel *reserveLabel = [[UILabel alloc]init];
    reserveLabel.text = @"深圳市股一通科技有限公司 版权所有\nCopyright ©2016 GuYiTong.All Right Reserve";
    reserveLabel.textColor = TEXT_COLOR;
    reserveLabel.font = [UIFont systemFontOfSize:13.0f];
    reserveLabel.textAlignment = NSTextAlignmentCenter;
    reserveLabel.numberOfLines = 0;
    reserveLabel.lineBreakMode = NSLineBreakByWordWrapping;
    reserveLabel.frame = CGRectMake(0, 0, reserveLabel.contentSize.width, reserveLabel.contentSize.height);
    reserveLabel.centerX = SCREEN_WIDTH/2;
    reserveLabel.centerY = SCREEN_HEIGHT-40;
    [self.view addSubview:reserveLabel];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"关于"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
