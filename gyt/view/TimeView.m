
//
//  TimeView.m
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "TimeView.h"

#define ViewHeight 120

@interface TimeView()

@end

@implementation TimeView
{
    UIButton *currentButton;
}

-(instancetype)init
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if(self == [super initWithFrame:rect])
    {
        self.backgroundColor = [ColorUtil colorWithHexString:@"#222222" alpha:0.5f];
        [self initView];
    }
    return  self;
}

-(void)initView
{
    
    UIView *rootView = [[UIView alloc]init];
    rootView.frame =  CGRectMake(0, SCREEN_HEIGHT-ViewHeight, SCREEN_WIDTH, ViewHeight);
    rootView.backgroundColor = MAIN_COLOR;
    [self addSubview:rootView];
    
    NSArray *array = @[@"1分钟",@"3分钟",@"5分钟",@"10分钟",@"15分钟",@"30分钟",@"1小时",@"2小时",@"3小时",@"4小时",@"1日",@"1周",@"1月"];
    
    NSString *timeLine = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefault_KTimeLine];
    if(IS_NS_STRING_EMPTY(timeLine))
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"10" forKey:UserDefault_KTimeLine];
    }
    for(int i = 0 ; i < 2 ; i++)
    {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.frame = CGRectMake(0, (i + 1) * (ViewHeight / 3), SCREEN_WIDTH, 0.5);
        [rootView addSubview:lineView];
    }
    
    for(int i = 0 ; i < 4 ; i++)
    {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.frame = CGRectMake( (i + 1) * (SCREEN_WIDTH / 5),0, 0.5, ViewHeight);
        [rootView addSubview:lineView];
    }

    
    int size = [array count];
    NSInteger temp = [timeLine integerValue];
    for(int i = 0 ; i < size; i ++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        int left = (i % 5) * (SCREEN_WIDTH / 5);
        int top  =  (i / 5 ) * (ViewHeight/3);
        NSLog(@"left->%d,top->%d",left,top);
        button.frame = CGRectMake(left, top,  SCREEN_WIDTH / 5, ViewHeight/3);
        [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(temp == i)
        {
            [button setBackgroundColor:SELECT_COLOR];
            currentButton = button;
        }
        [rootView addSubview:button];
        
    }
    
}


-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    int tag = button.tag;
    [button setBackgroundColor:SELECT_COLOR];
    if(currentButton != nil)
    {
        [currentButton setBackgroundColor:[UIColor clearColor]];
    }
    currentButton = button;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",tag] forKey:UserDefault_KTimeLine];
    
    if(self.delegate)
    {
        [self.delegate OnTimeSelect:tag];
    }
    [self removeFromSuperview];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}


@end
