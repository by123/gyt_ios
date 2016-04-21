//
//  MainTabelCell.m
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MainTableCell.h"

#define nameWidth  SCREEN_WIDTH * 190 / 640
#define recentPriceWidth  SCREEN_WIDTH * 160 / 640
#define updownWidth  SCREEN_WIDTH * 145 / 640
#define inventoryWidth  SCREEN_WIDTH * 145 / 640

@interface MainTableCell()

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UILabel *recentPriceLabel;

@property (strong, nonatomic) UILabel *updownLabel;

@property (strong, nonatomic) UILabel *inventoryLabel;

@end

@implementation MainTableCell

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
    _nameLabel.frame = CGRectMake(0, 0, nameWidth, self.bounds.size.height);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    _recentPriceLabel = [[UILabel alloc]init];
    _recentPriceLabel.textColor = [UIColor redColor];
    _recentPriceLabel.font = [UIFont systemFontOfSize:15.0f];
    _recentPriceLabel.frame = CGRectMake(nameWidth, 0, recentPriceWidth, self.bounds.size.height);
    _recentPriceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_recentPriceLabel];
    
    _updownLabel = [[UILabel alloc]init];
    _updownLabel.textColor = [UIColor redColor];
    _updownLabel.font = [UIFont systemFontOfSize:15.0f];
    _updownLabel.frame = CGRectMake(nameWidth + recentPriceWidth, 0, updownWidth, self.bounds.size.height);
    _updownLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_updownLabel];
    
    _inventoryLabel = [[UILabel alloc]init];
    _inventoryLabel.textColor = [UIColor grayColor];
    _inventoryLabel.font = [UIFont systemFontOfSize:15.0f];
    _inventoryLabel.frame = CGRectMake(nameWidth + recentPriceWidth+updownWidth, 0,inventoryWidth, self.bounds.size.height);
    _inventoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_inventoryLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    [self.contentView addSubview:lineView];

}

-(void)setData : (ProductModel *)model
        updown : (UpdownType) updownType
     inventore : (InventoryType) inventoryType
{
    if(model.updownPrice > 0)
    {
        model.isUp = YES;
    }
    _nameLabel.text = model.name;
    if([model.inventory isEqualToString:@"0"])
    {
        _recentPriceLabel.textColor = [UIColor grayColor];
        _updownLabel.textColor = [UIColor grayColor];
        _recentPriceLabel.text = @"--";
        _updownLabel.text = @"--";
    }
    else
    {
        if(model.isUp)
        {
            _recentPriceLabel.textColor = [UIColor redColor];
            _updownLabel.textColor = [UIColor redColor];
        }
        else
        {
            _recentPriceLabel.textColor = [UIColor greenColor];
            _updownLabel.textColor = [UIColor greenColor];
            
        }
        _recentPriceLabel.text = [NSString stringWithFormat:@"%.f",model.recentPrice];
        if(updownType == UpdownPrice)
        {
            _updownLabel.text = [NSString stringWithFormat:@"%.f",model.updownPrice];
        }
        else if(updownType == UpdownPercent)
        {
            _updownLabel.text = [NSString stringWithFormat:@"%.f",model.updownPercent];
        }
    }
 
    switch (inventoryType) {
        case Inventory:
            _inventoryLabel.text = model.inventory;
            break;
        case DailyInventory:
            _inventoryLabel.text = model.dailyInventory;
            break;
        case DealInventory:
            _inventoryLabel.text = model.dealInventory;
            break;
        default:
            break;
    }


}


+(NSString *)identify
{
    return @"MainTableCell";
}

@end
