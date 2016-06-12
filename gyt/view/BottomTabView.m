//
//  BottomTabView.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BottomTabView.h"

@implementation BottomTabView
{
    UIButton *lastClickedButton;
}

-(instancetype)initWithData : (NSMutableArray *)datas
{
    self = [super init];
    if(self)
    {
        _datas = datas;
        [self initView];
        return self;
    }
    return nil;
}


-(void)initView
{
    self.backgroundColor = MAIN_COLOR;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kBottomHeight);
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        for(int i = 0; i< _datas.count ;i ++)
        {
            UIButton *button = [self build:[_datas objectAtIndex:i]];
            button.frame = CGRectMake(i * SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, kBottomHeight);
            button.tag = i;
            if(i == 4)
            {
                [button setBackgroundColor:SELECT_COLOR];
                lastClickedButton= button;
            }
            [button addTarget:self action:@selector(OnButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
    }
}

-(UIButton *)build : (BottomModel *)model
{
    UIButton *button = [[UIButton alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = model.image;
    imageView.frame = CGRectMake(0, 4, 18, 18);
    imageView.centerX = SCREEN_WIDTH/8;
    [button addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [ColorUtil colorWithHexString:@"#ecf0f1"];
    label.text = model.title;
    label.font = [UIFont systemFontOfSize:11.0f];
    label.frame = CGRectMake(0, 24, label.contentSize.width, label.contentSize.height);
    label.centerX = SCREEN_WIDTH/8;
    [button addSubview:label];
    
    return button;
}


-(void)OnButtonClicked : (id)sender
{
    UIButton *button = sender;
 
    if(button != lastClickedButton)
    {
        [lastClickedButton setBackgroundColor:[UIColor clearColor]];
        [button setBackgroundColor:SELECT_COLOR];
        lastClickedButton = button;
    }
    if(self.delegate)
    {
        [self.delegate OnSelectPosition:button.tag];
    }
}

+(BottomModel *)buildModel : (NSString *)title
                     image : (UIImage *)image
{
    BottomModel *model = [[BottomModel alloc]init];
    model.title = title;
    model.image = image;
    return model;
}




@end
