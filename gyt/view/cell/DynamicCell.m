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
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _labels = [[NSMutableArray alloc]init];
        _widths = widths;
        if(!IS_NS_COLLECTION_EMPTY(_widths))
        {
            for(NSString *temp in _widths)
            {
                int tempInt = [temp intValue];
                count +=tempInt;
            }
        }

        return self;
    }
    return nil;
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
                case 0://品种
                    label.text = model.m_strProductName;
                    break;
                case 1://合约号
                    label.text = model.m_strInstrumentID;
                    break;
                case 2://多空
                    label.text = [Constant EEntrustBSStr:model.m_nDirection];
                    break;
                case 3://手数
                    label.text = [NSString stringWithFormat:@"%.f",model.m_nVolume];
                    break;
                case 4://可用
                    label.text = [NSString stringWithFormat:@"%.f",model.m_nVolume];
                    break;
                case 5://开仓均价
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dOpenPrice];
                    break;
                case 6://逐笔浮盈
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dFloatProfit];
                    break;
                case 7://币种
                    label.text = @"RMB";
                    break;
                case 8://损盈
                    break;
                    
                case 9://价值
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dMarketValue];
                    break;
                case 10://保证金
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dMargin];
                    break;
                case 11://今手数
                    label.text = @"1";
                    break;
                case 12://今可用
                    label.text = @"1";
                    break;
                case 13://投保
                    label.text = [Constant EHedge_Flag_TypeStr:model.m_nHedgeFlag];
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
                case 0://时间
                    if(IS_NS_STRING_EMPTY(model.m_tag.m_nOrderTime))
                    {
                        label.text = [self generateTime:[NSString stringWithFormat:@"%d",model.m_nInsertTime]];
                    }
                    else{
                        label.text = [self generateTime:model.m_tag.m_nOrderTime];
                    }
                    break;
                case 1://合约
                    label.text = model.m_strInstrumentID;
                    break;
                case 2://状态
                    if(model.m_nOrderStatus == 0)
                    {
                        label.text  = @"待报";
                    }
                    else
                    {
                        label.text = [Constant EEntrustStatusStr:model.m_nOrderStatus];
                    }
                    break;
                case 3://买卖
                    label.text = [Constant EEntrustBSStr:model.m_nDirection];
                    break;
                case 4://委托价
                    if(model.m_dOrderPrice == 0)
                    {
                        label.text = [NSString stringWithFormat:@"%.f",model.m_dLimitPrice];
                    }
                    else
                    {
                        label.text = [NSString stringWithFormat:@"%.f",model.m_dOrderPrice];
                    }
                    break;
                case 5://委托量
                    if(model.m_nOrderNum == 0)
                    {
                        label.text = [NSString stringWithFormat:@"%.f",model.m_nVolumeTotalOriginal];
                    }
                    else
                    {
                        label.text = [NSString stringWithFormat:@"%d",model.m_nOrderNum];
                    }
                    break;
                case 6://可撤
                    label.text = [NSString stringWithFormat:@"%d",model.m_nVolumeLeft];
                    break;
                case 7://已成交
                    label.text = [NSString stringWithFormat:@"%d",model.m_nVolumeTraded];
                    break;
                case 8://投保
                    label.text = [Constant EHedge_Flag_TypeStr:model.m_nHedgeFlag];
                    break;
                case 9://合同号
                    label.text = model.m_strContractNum;
                    break;
                case 10://主场号
                    label.text = model.m_strContractNum;
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
                case 0://时间
                    label.text = model.m_strTradeTime;
                    break;
                case 1://合约
                    label.text = model.m_strInstrumentID;
                    break;
                case 2://买卖
                    label.text = [Constant EEntrustBSStr:model.m_nDirection];
                    break;
                case 3://成交价
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dPrice];
                    break;
                case 4://成交量
                    label.text = [NSString stringWithFormat:@"%d",model.m_nVolume];
                    break;
                case 5://合同号
                    label.text = model.m_strOrderSysID;
                    break;
                case 6://主场号
                    label.text = @"";
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


-(void)setWarnData : (ProductModel *)model
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
                    label.text = @"123";
                    break;
                case 2:
                    label.text = @"111";
                    break;
                case 3:
                    label.text = [NSString stringWithFormat:@"%.f",model.recentPrice];
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

-(NSString *)generateTime : (NSString *)time
{
    NSString *t1 = [time substringWithRange:NSMakeRange(0, 2)];
    NSString *t2 = [time substringWithRange:NSMakeRange(2, 2)];
    NSString *t3 = [time substringWithRange:NSMakeRange(2, 2)];
    NSString *result = [NSString stringWithFormat:@"%@:%@:%@",t1,t2,t3];
    return result;
}

+(NSString *)identify
{
    return @"DynamicCell";
}


@end
