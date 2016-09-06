//
//  ByTabView.m
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByTabView.h"

@interface ByTabView()

@property (strong, nonatomic) NSArray *array;

@property (strong, nonatomic) NSMutableArray *buttonArrays;

@property (strong, nonatomic) UIView *lineView;

@property (assign, nonatomic) CGRect rect;

@end

@implementation ByTabView
{
    UIButton *lastButton;
}


-(instancetype)initWithTitles : (CGRect)rect
                         array: (NSArray *)array
{
    self = [super initWithFrame:rect];
    if(self)
    {
        _buttonArrays = [[NSMutableArray alloc]init];
        _rect = rect;
        self.array = array;
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,_rect.size.height)];
    [scrollView setContentSize:CGSizeMake(_rect.size.width, _rect.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    self.userInteractionEnabled = YES;
    if(!IS_NS_COLLECTION_EMPTY(_array))
    {
        _lineView  = [[UIView alloc]init];
        _lineView.backgroundColor = SELECT_COLOR;
        _lineView.frame = CGRectMake(0, self.bounds.size.height - 2, _rect.size.width / [_array count], 2);
        [scrollView addSubview:_lineView];
        
        for(int i =0 ; i< [_array count] ; i++)
        {
            UIButton *button = [[UIButton alloc]init];
            button.tag = i;
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:[_array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [button addTarget: self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake( i * (_rect.size.width/[_array count]), 0, _rect.size.width/[_array count], self.bounds.size.height);
            [scrollView addSubview:button];
            [_buttonArrays addObject:button];
            if(i == 0)
            {
                [button setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
                lastButton = button;
            }
        }
    }
}

-(void)setCurrent:(NSInteger)position
{
    if(!IS_NS_COLLECTION_EMPTY(_buttonArrays))
    {
        [self OnClick:[_buttonArrays objectAtIndex:position]];
    }
}

-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(button == lastButton)
    {
        return;
    }
    else
    {
        [lastButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        [button setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        [self startLineAnim:button.tag];
        lastButton = button;
    }
    
    if(self.delegate)
    {
        [self.delegate OnSelect:button.tag];
    }
}

-(void)startLineAnim : (NSInteger)position
{
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _lineView.frame = CGRectMake(position * (_rect.size.width / [_array count]),self.bounds.size.height - 2, _rect.size.width / [_array count], 2);
    } completion:nil];

}

-(int)getCurrent
{
    return lastButton.tag;
}

@end
