//
//  CloseView.m
//  gyt
//
//  Created by by.huang on 16/6/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "CloseView.h"
#define View_Height 160
#define View_Width SCREEN_WIDTH-60

@interface CloseView()

@property (strong, nonatomic) UIView *parentView;

@property (strong, nonatomic) DealHoldModel *model;

@end

@implementation CloseView


-(instancetype)initWithView : (UIView *)parentView
                      model : (DealHoldModel *)model
{
    self.parentView = parentView;
    self.model = model;
    if(self.parentView == nil)
    {
        return self;
    }
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
    self.userInteractionEnabled = YES;
    
    UIView *rootView = [[UIView alloc]init];
    [rootView setUserInteractionEnabled:YES];
    rootView.frame =  CGRectMake(30, (SCREEN_HEIGHT-View_Height)/2-100, View_Width, View_Height);
    rootView.layer.masksToBounds = YES;
    rootView.layer.cornerRadius = 4;
    rootView.layer.borderColor = [LINE_COLOR CGColor];
    rootView.layer.borderWidth = 1;
    rootView.backgroundColor = MAIN_COLOR;
    [self addSubview:rootView];

    
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    
    [rootView addSubview:nameLabel];
}


@end
