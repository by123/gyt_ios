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
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = SELECT_COLOR;
    
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
    
//    UIView *lineView = [[UIView alloc]init];
//    lineView.backgroundColor = LINE_COLOR;
//    lineView.frame = CGRectMake(0, self.bounds.size.height - 0.5, SCREEN_WIDTH, 0.5);
//    [self.contentView addSubview:lineView];

}

-(void)setData : (PushModel *)model
        updown : (UpdownType) updownType
     inventore : (InventoryType) inventoryType
{
    if(model.m_dOpenPrice < model.m_dLastPrice)
    {
        model.isUp = YES;
    }
    _nameLabel.text = model.m_strInstrumentID;
    double lastPrice = model.m_dLastPrice;
    if(lastPrice == 0)
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
        _recentPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.m_dLastPrice];
        if(updownType == UpdownPrice)
        {
            _updownLabel.text = [NSString stringWithFormat:@"%.2f",model.m_dLastPrice - model.m_dOpenPrice];
        }
        else if(updownType == UpdownPercent)
        {
            float percent = (model.m_dLastPrice - model.m_dOpenPrice) / model.m_dOpenPrice;
            _updownLabel.text = [NSString stringWithFormat:@"%.2f",percent * 100];
        }
    }
 
    switch (inventoryType) {
        case Inventory:
            _inventoryLabel.text = [NSString stringWithFormat:@"%d",model.m_dOpenInterest];
            break;
        case DailyInventory:
            _inventoryLabel.text = [NSString stringWithFormat:@"%d",model.m_dOpenInterest - model.m_dPreOpenInterest];
            break;
        case DealInventory:
            _inventoryLabel.text = [NSString stringWithFormat:@"%d",model.m_nVolume];
            break;
        default:
            break;
    }


}


+(NSString *)identify
{
    return @"MainTableCell";
}

- (void)drawRect:(CGRect)rect { CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //上分割线
    //CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, LINE_COLOR.CGColor);CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.5));
}


@end
