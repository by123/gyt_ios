//
//  InsetTextField.m
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "InsetTextField.h"

@interface InsetTextField()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *insetImageView;

@end

@implementation InsetTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.delegate = self;
    self.textColor = TEXT_COLOR;
    self.font = [UIFont systemFontOfSize:14.0f];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
        
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = TEXT_COLOR;
    [self addSubview:_titleLabel];
    
    _insetImageView = [[UIImageView alloc]init];
    _insetImageView.hidden = YES;
    [self addSubview:_insetImageView];
}

-(void)setInsetTitle: (NSString *)title
          font : (UIFont *)font
{
    _titleLabel.text= title;
    _titleLabel.font = font;
    _titleLabel.frame = CGRectMake(5, 0, _titleLabel.contentSize.width, self.bounds.size.height);
}

-(void)setInsetImage : (UIImage *)image
{
    _insetImageView.hidden = NO;
    _insetImageView.image = image;
    _insetImageView.frame = CGRectMake(self.bounds.size.width - (self.bounds.size.height-20) - 10, 10, self.bounds.size.height - 20 , self.bounds.size.height-20);

}


- (CGRect)textRectForBounds:(CGRect)bounds {
    if(_hasTitle)
    {
        return CGRectMake(_titleLabel.contentSize.width + 10, bounds.origin.y, bounds.size.width-_titleLabel.contentSize.width-10, bounds.size.height);
    }
    return CGRectMake(5, bounds.origin.y, bounds.size.width-5, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if(_hasTitle)
    {
        return CGRectMake(_titleLabel.contentSize.width + 10, bounds.origin.y, bounds.size.width- _titleLabel.contentSize.width-10, bounds.size.height);
    }
    return CGRectMake(5, bounds.origin.y, bounds.size.width-5, bounds.size.height);
}

#pragma mark 文本编辑框事件处理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.layer.borderColor = [SELECT_COLOR CGColor];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.layer.borderColor = [[UIColor blackColor] CGColor];
}





@end
