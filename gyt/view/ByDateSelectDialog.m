//
//  ByDateSelectDialog.m
//  gyt
//
//  Created by by.huang on 16/8/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByDateSelectDialog.h"

#define DialogHeight IDSPointValue(220)


@interface ByDateSelectDialog()<CustomIOSAlertViewDelegate>

@property (strong, nonatomic) CustomIOSAlertView *alertView;

@end

@implementation ByDateSelectDialog

-(instancetype)init
{
    if(self == [super init])
    {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _alertView = [[CustomIOSAlertView alloc]init];
    [_alertView setDelegate:self];
    UIView *containView = [[UIView alloc]init];
    containView.backgroundColor = MAIN_COLOR;
    containView.frame = CGRectMake(0, SCREEN_HEIGHT - DialogHeight, SCREEN_WIDTH, DialogHeight);
    
    [_alertView setButtonTitles:@[@"取消",@"确定"]];
    [_alertView setContainerView:containView];
}

-(void)show
{
    if(_alertView)
    {
        [_alertView show];
    }
}


-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSLog(@"确定");
    }
    [_alertView close];
}

-(void)dismiss
{
    if(_alertView)
    {
        [_alertView close];
    }
}


@end
