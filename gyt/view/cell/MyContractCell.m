//
//  MyContractCell.m
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MyContractCell.h"

@interface MyContractCell()

@property (strong ,nonatomic) UILabel *nameLabel;

@end

@implementation MyContractCell

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
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = [ColorUtil colorWithHexString:@"#FFC125"];
    _nameLabel.font = [UIFont systemFontOfSize:15.0f];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_nameLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5);;
    [self.contentView addSubview:lineView];
}

-(void)setData : (NSString *)name
{
    _nameLabel.text = name;
}

+ (NSString *)identify
{
    return @"MyContractCell";
}

@end
