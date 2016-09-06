//
//  TipsViewController.m
//  gyt
//
//  Created by by.huang on 16/9/1.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()

@property (strong, nonatomic) UILabel *tipsLabel;

@property (strong, nonatomic) UIButton *tipsBtn;

@end

@implementation TipsViewController

+(void)show : (BaseViewController *)controller
    content : (NSString *) content
       type : (TipsType)type
{
    TipsViewController *targetViewController = [[TipsViewController alloc]init];
    targetViewController.content = content;
    targetViewController.type = type;
    [controller.navigationController pushViewController:targetViewController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];

    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.textColor = TEXT_COLOR;
    tipsLabel.text = _content;
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipsLabel.frame = CGRectMake(10, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH - 20,SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT + 40));
    [tipsLabel sizeToFit];
    [self.view addSubview:tipsLabel];

    _tipsBtn = [[UIButton alloc]init];
    [_tipsBtn setTitle:@"条件单风险提醒" forState:UIControlStateNormal];
    [_tipsBtn setTitleColor:[ColorUtil colorWithHexString:@"#0066ff"] forState:UIControlStateNormal];
    _tipsBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _tipsBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - _tipsBtn.titleLabel.contentSize.width,SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT + 80) ,_tipsBtn.titleLabel.contentSize.width, 40);
    [_tipsBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tipsBtn];
}


-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"风险提醒"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];

}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
