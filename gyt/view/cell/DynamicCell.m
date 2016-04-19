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

-(void)setData : (NSMutableArray *)array
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
            label.text = [array objectAtIndex:i];
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
