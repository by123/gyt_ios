//
//  LeftMenuCell.m
//  gyt
//
//  Created by by.huang on 16/4/15.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "LeftMenuCell.h"

#define kCellHeight 32

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
    _button.userInteractionEnabled = NO;
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _button.frame = CGRectMake(0, 0, (SCREEN_WIDTH-90)/2, kCellHeight);
    [self addSubview:_button];
}

-(void)setData : (MenuModel *)model
{
    [_button setTitle:model.title forState:UIControlStateNormal];
    if(iPhone5 && model.title.length >= 9)
    {
        _button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else
    {
        _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    if(model.isSelected)
    {
        [_button setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    }
    else
    {
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

+ (NSString *)identify
{
    return @"LeftMenuCell";
}




@end

