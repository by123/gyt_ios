//
//  HandicapView.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HandicapView.h"

@interface HandicapView()

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIButton *leftButton;

@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UIView *lineView;


@end

@implementation HandicapView

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
    [self initTopView];
}

-(void)initTopView
{
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight);
    _topView.backgroundColor = LINE_COLOR;
    [self addSubview:_topView];
    
    _leftButton = [[UIButton alloc]init];
    [_leftButton setTitle:@"盘口" forState:UIControlStateNormal];
    [_leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, kTopHeight);
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _leftButton.backgroundColor = [UIColor clearColor];
    [_leftButton addTarget:self action:@selector(OnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc]init];
    [_rightButton setTitle:@"成交明细" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, kTopHeight);
    _rightButton.backgroundColor = [UIColor clearColor];
    [_rightButton addTarget:self action:@selector(OnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_rightButton];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = SELECT_COLOR;
    _lineView.frame = CGRectMake(0, kTopHeight - 2, SCREEN_WIDTH/2, 2);
    [_topView addSubview:_lineView];
}


-(void)OnClicked : (id)sender
{
    UIButton *button = sender;
    if(button == _leftButton)
    {
        [_leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(0, kTopHeight - 2, SCREEN_WIDTH/2, 2);
 
    }
    else if(button == _rightButton)
    {
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(SCREEN_WIDTH/2, kTopHeight - 2, SCREEN_WIDTH/2, 2);
    }
}

@end
