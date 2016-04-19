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
    self.textColor = TEXT_COLOR;
    self.font = [UIFont systemFontOfSize:14.0f];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
        
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = TEXT_COLOR;
    [self addSubview:_titleLabel];
}

-(void)setInsetTitle: (NSString *)title
          font : (UIFont *)font
{
    _titleLabel.text= title;
    _titleLabel.font = font;
    _titleLabel.frame = CGRectMake(5, 0, _titleLabel.contentSize.width, self.bounds.size.height);
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
@end
