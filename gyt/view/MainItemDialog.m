//
//  MainItemDialog.m
//  gyt
//
//  Created by by.huang on 16/6/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MainItemDialog.h"

#define Item_Height 44

@interface MainItemDialog()

@property (strong, nonatomic) UIButton *leftBtn;

@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic) UIView *lineView;


@property (strong, nonatomic) PushModel *model;

@property (assign, nonatomic) NSInteger position;

@end

@implementation MainItemDialog

-(instancetype)init
{
    if(self == [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)])
    {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return  self;
}



-(void)initView
{
    _leftBtn = [[UIButton alloc]init];
    _leftBtn.backgroundColor = MAIN_COLOR;
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftBtn setTitle:@"加入自选合约" forState:UIControlStateNormal];
    UIImage *leftImage = [UIImage imageNamed:@"ic_collect_normal"];
    [_leftBtn setImage:[AppUtil transformImage:leftImage width:20 height:20] forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_leftBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    _rightBtn = [[UIButton alloc]init];
    _rightBtn.backgroundColor = MAIN_COLOR;
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"下单" forState:UIControlStateNormal];
    UIImage *rightImage = [UIImage imageNamed:@"ic_lightning"];
    [_rightBtn setImage:[AppUtil transformImage:rightImage width:20 height:20] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_rightBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];

    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor blackColor];
    [self addSubview:_lineView];
    
}

-(void)updateView : (PushModel *)model
          position:(NSInteger)position
           height : (CGFloat)height
{
    self.model = model;
    self.position = position;
    _leftBtn.frame = CGRectMake(0, height, SCREEN_WIDTH/2, Item_Height);
    _rightBtn.frame = CGRectMake(SCREEN_WIDTH/2, height, SCREEN_WIDTH/2, Item_Height);
    _lineView.frame = CGRectMake(SCREEN_WIDTH/2, height, 0.5, Item_Height);
}


-(void)OnClick : (id)sender
{
    if(sender == _leftBtn)
    {
        if(self.delegate)
        {
            [self setHidden:YES];
            [self.delegate OnLeftClicked : _model];
        }
    }
    else if(sender == _rightBtn)
    {
        if(self.delegate)
        {
            [self setHidden:YES];
            [self.delegate OnRightClicked : _model position:_position];
        }
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setHidden:YES];
}


@end
