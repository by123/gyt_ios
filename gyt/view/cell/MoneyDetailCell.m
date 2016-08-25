//
//  MoneyDetailCell.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyDetailCell.h"

@interface MoneyDetailCell()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation MoneyDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
    }
    return self;
}


-(void)initView
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.textColor = TEXT_COLOR;
    _contentLabel.textAlignment = NSTextAlignmentRight;
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = LINE_COLOR;
    _lineView.frame = CGRectMake(15, 30 - 0.5, SCREEN_WIDTH - 15, 0.5);
    [self.contentView addSubview:_lineView];
}

-(void)setData : (TitleContentModel *)model
{
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(15, 0, _titleLabel.contentSize.width, 30);
    
    _contentLabel.text = model.content;
    _contentLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH -10,30);
    

}

+(NSString *)identify
{
    return @"MoneyDetailCell";
}

@end
