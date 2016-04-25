//
//  WarnDialog.m
//  gyt
//
//  Created by by.huang on 16/4/25.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "WarnDialog.h"
#import "InsetTextField.h"
#import "AppUtil.h"
#import "DialogHelper.h"
#import "ContractDB.h"

#define DialogWidth  SCREEN_WIDTH - 30
#define DialogHeight 200

@interface WarnDialog()

@property (strong , nonatomic) ProductModel *model;

@property (strong , nonatomic) UIButton *cancelBtn;

@property (strong , nonatomic) UIButton *confirmBtn;

@property (strong , nonatomic) UILabel *titleLabel;

@property (strong , nonatomic) UIButton *upBtn;

@property (strong , nonatomic) UIButton *downBtn;

@property (strong , nonatomic) InsetTextField *upTextField;

@property (strong , nonatomic) InsetTextField *downTextField;


@end

@implementation WarnDialog

-(instancetype)initWithData : (ProductModel *)model;
{
    if(self == [super init])
    {
        self.model = model;
        [self initView];
    }
    return self;
}

-(void)initView
{
    [self setBackgroundColor:[ColorUtil colorWithHexString:@"#000000" alpha:0.3f]];
    self.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    UIView *rootView = [[UIView alloc]init];
    rootView.backgroundColor = SUB_COLOR;
    rootView.frame = CGRectMake(15, NavigationBar_HEIGHT + StatuBar_HEIGHT+20,DialogWidth, DialogHeight);
    rootView.layer.masksToBounds = YES;
    rootView.layer.cornerRadius = 4;
    [self addSubview:rootView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = [NSString stringWithFormat:@"设置价格预警－%@",_model.name];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = LINE_COLOR;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, 0, DialogWidth, 40);
    [rootView addSubview:_titleLabel];
    
    _upBtn = [self buildSelectBtn : @"预警价格上限为"];
    _upBtn.frame = CGRectMake(15, 50, 150, 40);
    [rootView addSubview:_upBtn];
    
    _downBtn = [self buildSelectBtn:@"预警价格下限位"];
    _downBtn.frame = CGRectMake(15, 100, 150, 40);
    [rootView addSubview:_downBtn];
    
    _upTextField = [[InsetTextField alloc]init];
    _upTextField.hasTitle = NO;
    _upTextField.text = [NSString stringWithFormat:@"%.f",_model.recentPrice];
    _upTextField.frame = CGRectMake(170, 55, 80, 30);
    [_upTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [rootView addSubview:_upTextField];
    
    _downTextField = [[InsetTextField alloc]init];
    _downTextField.hasTitle = NO;
    _downTextField.text = [NSString stringWithFormat:@"%.f",_model.recentPrice];
    [_downTextField setKeyboardType:UIKeyboardTypeNumberPad];
    _downTextField.frame = CGRectMake(170, 105, 80, 30);
    [rootView addSubview:_downTextField];
    
    
    _cancelBtn = [[UIButton alloc]init];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundImage:[AppUtil imageWithColor:LINE_COLOR] forState:UIControlStateNormal];
    [_cancelBtn setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#000000" alpha:0.3]] forState:UIControlStateHighlighted];
    _cancelBtn.frame = CGRectMake(0, DialogHeight - 40, (SCREEN_WIDTH - 30)/2, 40);
    [_cancelBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];

    [rootView addSubview:_cancelBtn];

    _confirmBtn = [[UIButton alloc]init];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundImage:[AppUtil imageWithColor:LINE_COLOR] forState:UIControlStateNormal];
    [_confirmBtn setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#000000" alpha:0.2]] forState:UIControlStateHighlighted];
    _confirmBtn.frame = CGRectMake((SCREEN_WIDTH - 30)/2 , DialogHeight - 40, (SCREEN_WIDTH - 30)/2, 40);
    [_confirmBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_confirmBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = SUB_COLOR;
    lineView.frame = CGRectMake((SCREEN_WIDTH - 30)/2, DialogHeight - 40, 0.5, 40);
    [rootView addSubview:lineView];
    
    
}

-(UIButton *)buildSelectBtn : (NSString *)title
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [button setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#000000" alpha:0.2]] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [button setImage:[UIImage imageNamed:@"ic_chose"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_chose_in"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(button == _confirmBtn)
    {
        if(![_upBtn isSelected] && ![_downBtn isSelected])
        {
            [DialogHelper showTips:@"您还没有选择"];
        }
        else
        {
            [DialogHelper showSuccessTips:[NSString stringWithFormat:@"%@已加入预警合约",_model.name]];
            [[ContractDB sharedContractDB]insertItem:DBWarnContractTable model:_model];
            [self removeFromSuperview];
        }
    }
    else if(button == _cancelBtn)
    {
        [self removeFromSuperview];
    }
    else if(button == _upBtn)
    {
        if([_upBtn isSelected])
        {
            [_upBtn setSelected:NO];
        }
        else
        {
            [_upBtn setSelected:YES];
        }
    }
    else if(button == _downBtn)
    {
        if([_downBtn isSelected])
        {
            [_downBtn setSelected:NO];
        }
        else
        {
            [_downBtn setSelected:YES];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
