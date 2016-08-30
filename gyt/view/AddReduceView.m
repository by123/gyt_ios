//
//  AddReduceView.m
//  gyt
//
//  Created by by.huang on 16/8/30.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "AddReduceView.h"
#define ViewHeight 50


@interface AddReduceView()

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *tips;

@property (assign, nonatomic) ByTextFieldType type;

@property (strong, nonatomic) UIView *rootView;


@end

@implementation AddReduceView


-(instancetype)initWithTitle : (NSString *)title
                        type : (ByTextFieldType)type
                         tips: (NSString *)tips
                    rootView : (UIView *)rootView
{
    if(self == [super init])
    {
        self.title = title;
        self.type = type;
        self.tips = tips;
        self.rootView = rootView;
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight);
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.text = _title;
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.frame = CGRectMake(10, 0, 80, 30);
    [self addSubview:_titleLabel];
    
    _textField = [[ByTextField alloc]initWithType:_type frame:CGRectMake(70,0,100,30) rootView:_rootView title:nil];
    
    __weak AddReduceView *weakSelf = self;
    _textField.block = ^(BOOL isCompelete,NSString *text)
    {
        double value = [text doubleValue];
        if(weakSelf.delegate)
        {
            [weakSelf.delegate textFinished:value];
        }
    };
    [self addSubview:_textField];
    
    //增加
    _addBtn = [[UIButton alloc]init];
    _addBtn.frame = CGRectMake(_textField.x+_textField.width + 10, 0, 30, 30);
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.cornerRadius = 4;
    _addBtn.userInteractionEnabled = YES;
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_addBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateNormal];
    [_addBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_SELECT_COLOR] forState:UIControlStateSelected];
    [_addBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    //减少
    _reduceBtn = [[UIButton alloc]init];
    _reduceBtn.frame = CGRectMake(_addBtn.x+_addBtn.width + 10, 0, 30, 30);
    [_reduceBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reduceBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reduceBtn.layer.masksToBounds = YES;
    _reduceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reduceBtn.layer.cornerRadius = 4;
    _reduceBtn.userInteractionEnabled = YES;
    [_reduceBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateNormal];
    [_reduceBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_SELECT_COLOR] forState:UIControlStateSelected];
    [_reduceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceBtn];
    
    _tipsLabel = [[UILabel alloc]init];
    _tipsLabel.textAlignment = NSTextAlignmentLeft;
    _tipsLabel.font= [UIFont systemFontOfSize:14.0f];
    _tipsLabel.text = _tips;
    _tipsLabel.textColor = TEXT_COLOR;
    _tipsLabel.frame = CGRectMake(70, 35, SCREEN_WIDTH - 70, _tipsLabel.contentSize.height);
    [self addSubview:_tipsLabel];

}



-(void)setDefaultValue : (NSString *)value
{
    [_textField setTextFiledText:value];
}


-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(button == _addBtn)
    {
        if(self.delegate)
        {
            [self.delegate addBtnClick : self];
        }
    }
    else if(button == _reduceBtn)
    {
        if(self.delegate)
        {
            [self.delegate reduceBtnClick : self];
        }
    }
}

-(void)setEnable : (Boolean)enable
{
    if(enable)
    {
        [self setViewEnable:_addBtn enable:YES];
        [self setViewEnable:_reduceBtn enable:YES];
        [self setViewEnable:_textField enable:YES];
    }
    else
    {
        [self setViewEnable:_addBtn enable:NO];
        [self setViewEnable:_reduceBtn enable:NO];
        [self setViewEnable:_textField enable:NO];
    }
}

-(void)setViewEnable : (id)view
              enable : (Boolean)enable
{
    if([view isKindOfClass:[UIButton class]])
    {
        UIButton *button = view;
        if(enable)
        {
            button.alpha = 1;
            button.enabled = YES;
        }
        else
        {
            button.alpha = 0.8f;
            button.enabled = NO;
        }
    }
}

@end
