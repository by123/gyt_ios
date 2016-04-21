//
//  DynamicCell.m
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DynamicCell.h"

@interface DynamicCell()

@property (strong, nonatomic) NSArray *widths;

@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation DynamicCell
{
    int count;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widths :(NSArray *)widths
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _labels = [[NSMutableArray alloc]init];
        self.widths = widths;
        if(!IS_NS_COLLECTION_EMPTY(_widths))
        {
            for(NSString *temp in _widths)
            {
                int tempInt = [temp intValue];
                count +=tempInt;
            }
        }
    }
    return self;
}

-(void)setHoldData : (DealHoldModel *)model
          maxWidth : (int)maxWidth
{
    if(!IS_NS_COLLECTION_EMPTY(_widths))
    {
        int currentWidth =0;
        for(int i = 0 ; i < _widths.count ; i ++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.textColor= TEXT_COLOR;
            label.font = [UIFont systemFontOfSize:13.0f];
            int width =  [[_widths objectAtIndex:i] intValue] * maxWidth / count;
            switch (i) {
                case 0:
                    label.text = model.name;
                    break;
                case 1:
                    label.text = model.buySell;
                    if([model.buySell isEqualToString:@"多"])
                    {
                        label.textColor= [UIColor redColor];
                    }
                    else
                    {
                        label.textColor= [UIColor greenColor];
                    }
                    break;
                case 2:
                    label.text = model.hand;
                    break;
                case 3:
                    label.text = model.canuse;
                    break;
                case 4:
                    label.text = model.averagePrice;
                    break;
                case 5:
                    label.text = model.profit;
                    if([model.profit integerValue] > 0)
                    {
                        label.textColor= [UIColor redColor];
                    }
                    else
                    {
                        label.textColor= [UIColor greenColor];
                    }
                    break;
                    
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, 30);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
            [self.contentView addSubview:lineView];
        }
    }

}

-(void)setHoldingData : (DealHoldingModel *)model
             maxWidth : (int)maxWidth
{
    if(!IS_NS_COLLECTION_EMPTY(_widths))
    {
        int currentWidth =0;
        for(int i = 0 ; i < _widths.count ; i ++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.textColor= TEXT_COLOR;
            label.font = [UIFont systemFontOfSize:13.0f];
            int width =  [[_widths objectAtIndex:i] intValue] * maxWidth / count;
            switch (i) {
                case 0:
                    label.text = model.name;
                    break;
                case 1:
                    label.text = model.kaiping;
                    break;
                case 2:
                    label.text = model.price;
                    break;
                case 3:
                    label.text = model.handby;
                    break;
                case 4:
                    label.text = model.hand;
                    break;
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, 30);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
            [self.contentView addSubview:lineView];
        }
    }

}

-(void)setHoldByData : (DealHoldByModel *)model
            maxWidth : (int)maxWidth
{
    if(!IS_NS_COLLECTION_EMPTY(_widths))
    {
        int currentWidth =0;
        for(int i = 0 ; i < _widths.count ; i ++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.textColor= TEXT_COLOR;
            label.font = [UIFont systemFontOfSize:13.0f];
            int width =  [[_widths objectAtIndex:i] intValue] * maxWidth / count;
            switch (i) {
                case 0:
                    label.text = model.name;
                    break;
                case 1:
                    label.text = model.statu;
                    break;
                case 2:
                    label.text = model.kaiping;
                    break;
                case 3:
                    label.text = model.price;
                    break;
                case 4:
                    label.text = model.handby;
                    break;
                case 5:
                    label.text = model.handDeal;
                    break;
                case 6:
                    label.text = model.handCancel;
                    break;
                case 7:
                    label.text = model.time;
                    break;
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, 30);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
            [self.contentView addSubview:lineView];
        }
    }
}

-(void)setProfitData : (DealProfitModel *)model
            maxWidth : (int)maxWidth
{
    if(!IS_NS_COLLECTION_EMPTY(_widths))
    {
        int currentWidth =0;
        for(int i = 0 ; i < _widths.count ; i ++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.textColor= TEXT_COLOR;
            label.font = [UIFont systemFontOfSize:13.0f];
            int width =  [[_widths objectAtIndex:i] intValue] * maxWidth / count;
            switch (i) {
                case 0:
                    label.text = model.name;
                    break;
                case 1:
                    label.text = model.kaiping;
                    break;
                case 2:
                    label.text = model.price;
                    break;
                case 3:
                    label.text = model.hand;
                    break;
                case 4:
                    label.text = model.time;
                    break;
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, 30);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
            [self.contentView addSubview:lineView];
        }
    }
}

+(NSString *)identify
{
    return @"DynamicCell";
}


@end
