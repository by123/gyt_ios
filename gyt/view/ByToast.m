//
//  ByToast.m
//  gyt
//
//  Created by by.huang on 16/7/6.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByToast.h"
#import "AppDelegate.h"

#define ToastHeight 50
#define EnterInterval 0.5
#define ExitInterval 0.5
#define TimeInterval 1


@interface ByToast()

@property (strong, nonatomic) UILabel *tipLabel;

@end

@implementation ByToast
{
    NSTimeInterval enterInterval;
    NSTimeInterval exitInterval;
}

+(void)showNormalToast : (NSString *)content
{
    [self start:content color:NormalColor];
}

+(void)showWarnToast : (NSString *)content
{
    [self start:content color:WarnColor];
}

+(void)showErrorToast : (NSString *)content
{
    [self start:content color:ErrorColor];
}

+(void)showToast : (NSString *)content
           level : (Level)level
        interval : (long)timeInterval
{
    
}


+(void)start : (NSString *)content
       color : (UIColor *)color
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    ByToast *toast = [[ByToast alloc]init];
    [window addSubview:toast];

    
    [toast setTipText:content];
    toast.backgroundColor = color;
    [toast enter];
}

-(instancetype)init
{
    if(self == [super init])
    {
        enterInterval = EnterInterval;
        exitInterval = ExitInterval;
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ToastHeight);
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.font = [UIFont systemFontOfSize:14.0f];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, ToastHeight);
    [self addSubview:_tipLabel];
    
}

-(void)enter
{
    [UIView animateWithDuration:0 delay:enterInterval options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - ToastHeight, SCREEN_WIDTH, ToastHeight);
    } completion:^(BOOL finished) {
        [NSThread sleepForTimeInterval:TimeInterval];
        [self exit];
    }];
}

-(void)exit
{
    [UIView animateWithDuration:exitInterval animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setTipText : (NSString *)content
{
    _tipLabel.text = content;
}


@end
