//
//  SearchCell.m
//  gyt
//
//  Created by by.huang on 16/4/28.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell()

@property (strong , nonatomic) UILabel *nameLabel;

@property (strong , nonatomic) UILabel *exchangeLabel;

@end

@implementation SearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = TEXT_COLOR;
    _nameLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    _exchangeLabel = [[UILabel alloc]init];
    _exchangeLabel.textColor = TEXT_COLOR;
    _exchangeLabel.font = [UIFont systemFontOfSize:14.0f];
    _exchangeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_exchangeLabel];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(0, 40-0.5, SCREEN_WIDTH, 0.5);
    [self.contentView addSubview:lineView];
}


-(void)setData : (PushModel *)model
{
    _nameLabel.text = model.m_strInstrumentID;
    _nameLabel.frame = CGRectMake(15, 0, _nameLabel.contentSize.width, 40);
    
    _exchangeLabel.text = model.m_strExchangeName;
    _exchangeLabel.frame = CGRectMake(SCREEN_WIDTH -15 - _exchangeLabel.contentSize.width, 0, _exchangeLabel.contentSize.width, 40);

}


+(NSString *)identify
{
    return @"SearchCell";
}

@end
