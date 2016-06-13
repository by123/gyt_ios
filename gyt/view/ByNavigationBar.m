//
//  ByNavigationBar.m
//  haihua
//
//  Created by by.huang on 16/3/8.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByNavigationBar.h"
#import "UILabel+ContentSize.h"

@implementation ByNavigationBar


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    self.backgroundColor = MAIN_COLOR;
    self.userInteractionEnabled = YES;
    _leftBtn = [[UIButton alloc]init];
    _leftBtn.frame = CGRectMake(0, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_leftBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_leftBtn addTarget:self action:@selector(OnLeftCallBack) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"ic_left_menu"] forState:UIControlStateNormal];
    
    _rightBtn = [[UIButton alloc]init];
    UIImage *rightImage = [UIImage imageNamed:@"ic_right_menu"];
    _rightBtn.tag = 0;
    _rightBtn.frame = CGRectMake(SCREEN_WIDTH - rightImage.size.width - 10, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_rightBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightBtn addTarget:self action:@selector(OnRightCallBack:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setImage:rightImage forState:UIControlStateNormal];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTitleCallBack:)];
    [_titleLabel addGestureRecognizer:recognizer];
    
    _leftMainLabel = [[UILabel alloc]init];
    _leftMainLabel.textColor = [UIColor whiteColor];
    _leftMainLabel.textAlignment = NSTextAlignmentLeft;
    _leftMainLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _leftSubLabel = [[UILabel alloc]init];
    _leftSubLabel.textColor = [ColorUtil colorWithHexString:@"#FFC125"];
    _leftSubLabel.textAlignment = NSTextAlignmentLeft;
    _leftSubLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _rightBtn1 = [[UIButton alloc]init];
    _rightBtn1.tag = 1;
    _rightBtn1.frame = CGRectMake(SCREEN_WIDTH - rightImage.size.width * 2 - 20, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_rightBtn1 setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightBtn1 addTarget:self action:@selector(OnRightCallBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn2 = [[UIButton alloc]init];
    _rightBtn2.tag = 2;
    _rightBtn2.frame = CGRectMake(SCREEN_WIDTH - rightImage.size.width * 3 - 30, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_rightBtn2 setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightBtn2 addTarget:self action:@selector(OnRightCallBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn3 = [[UIButton alloc]init];
    _rightBtn3.tag = 3;
    _rightBtn3.frame = CGRectMake(SCREEN_WIDTH - rightImage.size.width * 4 - 40, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_rightBtn3 setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightBtn3 addTarget:self action:@selector(OnRightCallBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn4 = [[UIButton alloc]init];
    _rightBtn4.tag = 4;
    _rightBtn4.frame = CGRectMake(SCREEN_WIDTH - rightImage.size.width * 5 - 50, StatuBar_HEIGHT, NavigationBar_HEIGHT, NavigationBar_HEIGHT);
    [_rightBtn4 setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightBtn4 addTarget:self action:@selector(OnRightCallBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_leftBtn];
    [self addSubview:_titleLabel];
    [self addSubview:_leftMainLabel];
    [self addSubview:_leftSubLabel];
    
    self.userInteractionEnabled = YES;

}


#pragma mark 设置中间标题
-(void)setTitle:(NSString *)title
{
    if(_titleLabel)
    {
        _titleLabel.text = title;
        _titleLabel.frame = CGRectMake((SCREEN_WIDTH -  200)/2, StatuBar_HEIGHT , 200, NavigationBar_HEIGHT);
    }
}

#pragma mark 设置左边按钮图标
-(void)setLeftImage : (UIImage *)image
{
    [_leftBtn setImage:image forState:UIControlStateNormal];
}

#pragma mark 设置左边主标题
-(void)setLeftMainTitle : (NSString *)mainTitle
{
    _leftMainLabel.text = mainTitle;
    _leftMainLabel.frame = CGRectMake(40, StatuBar_HEIGHT + 5,60, _leftMainLabel.contentSize.height);
}

#pragma mark 设置左边副标题
-(void)setLeftSubTitle : (NSString *)subTitle
{
    _leftSubLabel.text = subTitle;
    _leftSubLabel.frame = CGRectMake(40, _leftMainLabel.y + _leftMainLabel.contentSize.height, _leftSubLabel.contentSize.width,_leftSubLabel.contentSize.height);
}

-(void)setRightImage : (UIImage *)image
{
    if(image)
    {
        [_rightBtn setImage:image forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        return;
    }
    [_rightBtn removeFromSuperview];
}

#pragma mark 设置右边倒数第二个按钮图片
-(void)setRightBtn1Image : (UIImage *)image
{
    if(image)
    {
        [_rightBtn1 setImage:image forState:UIControlStateNormal];
        [self addSubview:_rightBtn1];
        return;
    }
    [_rightBtn1 removeFromSuperview];}

#pragma mark 设置右边倒数第三个按钮图片
-(void)setRightBtn2Image : (UIImage *)image
{
    if(image)
    {
        [_rightBtn2 setImage:image forState:UIControlStateNormal];
        [self addSubview:_rightBtn2];
        return;
    }
    [_rightBtn2 removeFromSuperview];
}

#pragma mark 设置右边倒数第四个按钮图片
-(void)setRightBtn3Image : (UIImage *)image
{
    if(image)
    {
        [_rightBtn3 setImage:image forState:UIControlStateNormal];
        [self addSubview:_rightBtn3];
        return;
    }
    [_rightBtn3 removeFromSuperview];
}

#pragma mark 设置右边倒数第五个按钮图片
-(void)setRightBtn4Image : (UIImage *)image
{
    if(image)
    {
        [_rightBtn4 setImage:image forState:UIControlStateNormal];
        [self addSubview:_rightBtn4];
        return;
    }
    [_rightBtn4 removeFromSuperview];
}


#pragma mark 点击处理
-(void)OnLeftCallBack
{
    if(self.delegate)
    {
        [self.delegate OnLeftClickCallback];
    }
}

-(void)OnRightCallBack : (id)sender
{
    if(self.delegate)
    {
        UIButton *button = sender;
        NSLog(@"%d",button.tag);
        [self.delegate OnRightClickCallBack:button.tag];
    }
}

-(void)OnTitleCallBack : (id)sender
{
    if(self.delegate)
    {
        [self.delegate OnTitleClick];
    }
}


@end
