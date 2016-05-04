//
//  RightMenuCell.m
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "RightMenuCell.h"

@interface RightMenuCell()

@property (strong ,nonatomic) UILabel *titleLabel;

@property (strong ,nonatomic) UIImageView *showImageView;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation RightMenuCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    _showImageView = [[UIImageView alloc]init];
    _showImageView.frame = CGRectMake(15, (50 - 25 )/2, 25, 25);
    [self.contentView addSubview:_showImageView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_titleLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = LINE_COLOR;
    _lineView.frame  = CGRectMake(0, 50 - 0.5, SCREEN_WIDTH, 0.5);
    [self.contentView addSubview:_lineView];
}

-(void)setData : (RightMenuModel *)model
{
    _showImageView.image =  [UIImage imageNamed:model.imageStr];
    
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(60, (50 - _titleLabel.contentSize.height )/2, _titleLabel.contentSize.width, _titleLabel.contentSize.height);
}

+ (NSString *)identify
{
    return @"RightMenuCell";
}
@end
