//
//  LeftMenuCell.m
//  gyt
//
//  Created by by.huang on 16/4/15.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LeftMenuCell.h"

#define Cell_Height 32

@interface LeftMenuCell()

@property (strong, nonatomic) UIButton *button;

@end

@implementation LeftMenuCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}


-(void)initView
{
    _button = [[UIButton alloc]init];
    _button.backgroundColor = [UIColor clearColor];
    _button.layer.borderColor = [MAIN_COLOR CGColor];
    _button.layer.borderWidth = 0.5;
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 2;
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _button.frame = CGRectMake(0, 0, (SCREEN_WIDTH-90)/2, Cell_Height);
    [self addSubview:_button];
}

-(void)setData : (NSString *)text
{
    [_button setTitle:text forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(iPhone5 && text.length >= 9)
    {
        _button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
}

+ (NSString *)identify
{
    return @"LeftMenuCell";
}


@end

