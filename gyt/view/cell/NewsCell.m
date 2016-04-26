//
//  NewsCell.m
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "NewsCell.h"
#define Item_Height 100

@interface NewsCell()

@property (strong , nonatomic) UILabel *titleLabel;

@property (strong , nonatomic) UILabel *contentLabel;

@property (strong , nonatomic) UILabel *fromLabel;

@property (strong , nonatomic) UILabel *timeLabel;

@end

@implementation NewsCell

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
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.textColor = TEXT_COLOR;
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_contentLabel];
    
    _fromLabel = [[UILabel alloc]init];
    _fromLabel.font = [UIFont systemFontOfSize:13.0f];
    _fromLabel.textColor = TEXT_COLOR;
    [self.contentView addSubview:_fromLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:13.0f];
    _timeLabel.textColor = TEXT_COLOR;
    [self.contentView addSubview:_timeLabel];
    
}

-(void)setData : (NewsModel *)model
{
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, _titleLabel.contentSize.height);
    
    _contentLabel.text = model.content;
    _contentLabel.frame = CGRectMake(15, 25, SCREEN_WIDTH - 30, Item_Height/2);

    
    _fromLabel.text = model.from;
    _fromLabel.frame = CGRectMake(15,Item_Height - 10 - _fromLabel.contentSize.height , _fromLabel.contentSize.width,_fromLabel.contentSize.height);
    
    _timeLabel.text = model.time;
    _timeLabel.frame = CGRectMake(SCREEN_WIDTH - 15 - _timeLabel.contentSize.width, Item_Height - 10 - _timeLabel.contentSize.height, _timeLabel.contentSize.width, _timeLabel.contentSize.height);
    
}

+(NSString *)identify
{
    return @"NewsCell";
}

@end
