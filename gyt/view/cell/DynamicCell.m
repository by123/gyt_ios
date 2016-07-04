//
//  DynamicCell.m
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DynamicCell.h"

#define Item_Heihgt 40
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
            label.tag = i;
            int width =  [[_widths objectAtIndex:i] intValue] * maxWidth / count;
            switch (i) {
//                case 0://品种
//                    label.text = model.m_strProductID;
//                    break;
                case 0://合约号
                    label.text = model.m_strInstrumentID;
                    break;
                case 1://多空
                    label.text = [Constant EEntrustBSStr:model.m_nDirection];
                    break;
                case 2://手数
                    label.text = [NSString stringWithFormat:@"%d",model.m_nPosition];
                    break;
                case 3://可用
                    label.text = [NSString stringWithFormat:@"%d",model.m_nCanCloseVol];
                    break;
                case 4://开仓均价
                    label.text = [NSString stringWithFormat:@"%.2f",model.m_dAvgPrice];
                    break;
                case 5://逐笔浮盈
                    [self handleUpDown : model label:label];
                    break;
//                case 7://币种
//                    label.text = [Constant getMoneyType:model.m_nMoneyType];
//                    break;
//                case 8://损盈
//                    label.text = [NSString stringWithFormat:@"%.2f",model.m_dProfitRate];
//                    break;
//                case 9://价值
//                    label.text = [NSString stringWithFormat:@"%.f",model.m_dInstrumentValue];
//                    break;
                case 6://保证金
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dUsedMargin];
                    break;
                case 7://今手数
                    label.text =[NSString stringWithFormat:@"%d",model.m_nOpenVolume];
                    break;
//                case 12://今可用
//                    label.text = [NSString stringWithFormat:@"%d",model.m_nCanCloseVol];                    break;
//                case 13://投保
//                    label.text = [Constant EHedge_Flag_TypeStr:model.m_nHedgeFlag];
//                    break;
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, Item_Heihgt);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = LINE_COLOR;
//            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
//            [self.contentView addSubview:lineView];
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
                case 0://时间
                    if(model.m_nInsertTime == 0)
                    {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                        [formatter setDateFormat:@"HH:mm:ss"];
                        label.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
                    }
                    else{
                        label.text = [self generateTime:[NSString stringWithFormat:@"%d",model.m_nInsertTime]];
                    }
                    break;
                case 1://合约
                    label.text = model.m_strInstrumentID;
                    break;
                case 2://状态
                    label.text = [Constant EEntrustStatusStr:model.m_nOrderStatus];
                    break;
                case 3://买卖
                    label.text = [Constant EEntrustBSStr:model.m_nDirection];
                    break;
                case 4://委托价
                    if(model.m_dOrderPrice == 0)
                    {
                        label.text = [NSString stringWithFormat:@"%.2f",model.m_dLimitPrice];
                    }
                    else
                    {
                        label.text = [NSString stringWithFormat:@"%.2f",model.m_dOrderPrice];
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
            label.frame = CGRectMake(currentWidth, 0, width, Item_Heihgt);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = LINE_COLOR;
//            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
//            [self.contentView addSubview:lineView];
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
                    if(model.m_nInsertTime == 0)
                    {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                        [formatter setDateFormat:@"HH:mm:ss"];
                        label.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
                    }
                    else{
                        label.text = [self generateTime:[NSString stringWithFormat:@"%d",model.m_nInsertTime]];
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
                        label.text = [NSString stringWithFormat:@"%.2f",model.m_dLimitPrice];
                    }
                    else
                    {
                        label.text = [NSString stringWithFormat:@"%.2f",model.m_dOrderPrice];
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
            label.frame = CGRectMake(currentWidth, 0, width, Item_Heihgt);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = LINE_COLOR;
//            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
//            [self.contentView addSubview:lineView];
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
                    label.text = [NSString stringWithFormat:@"%.2f",model.m_dTradeAmount];
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
            label.frame = CGRectMake(currentWidth, 0, width, Item_Heihgt);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = LINE_COLOR;
//            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
//            [self.contentView addSubview:lineView];
        }
    }
}


-(void)setWarnData : (PushModel *)model
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
                    label.text = model.m_strInstrumentID;
                    break;
                case 1:
                    label.text = @"123";
                    break;
                case 2:
                    label.text = @"111";
                    break;
                case 3:
                    label.text = [NSString stringWithFormat:@"%.f",model.m_dLastPrice];
                    break;
                default:
                    break;
            }
            label.frame = CGRectMake(currentWidth, 0, width, Item_Heihgt);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_labels addObject:label];
            currentWidth += width;
            
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = LINE_COLOR;
//            lineView.frame = CGRectMake(0, 30- 0.5, maxWidth, 0.5);
//            [self.contentView addSubview:lineView];
        }
    }
}

-(NSString *)generateTime : (NSString *)time
{
    NSString *t1 = [time substringWithRange:NSMakeRange(0, 2)];
    NSString *t2 = [time substringWithRange:NSMakeRange(2, 2)];
    NSString *t3 = [time substringWithRange:NSMakeRange(2, 2)];
    NSString *result = [NSString stringWithFormat:@"%@:%@:%@",t1,t2,t3];
    NSLog(@"%@",result);
    return result;
}

+(NSString *)identify
{
    return @"DynamicCell";
}

- (void)drawRect:(CGRect)rect { CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //上分割线
    //CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, LINE_COLOR.CGColor);CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 0.5));
}



//处理逐笔浮盈
-(void)handleUpDown : (DealHoldModel *)model
              label : (UILabel *)label
{
    double value = 0 ;
    if(model.m_nDirection == ENTRUST_BUY)
    {
        value = (model.m_dLastPrice - model.m_dAvgPrice) * model.m_nPosition;
    }
    else if(model.m_nDirection == ENTRUST_SELL)
    {
        value = (model.m_dAvgPrice - model.m_dLastPrice) * model.m_nPosition;
    }
    label.text = [NSString stringWithFormat:@"%.2f",value];
    if(value > 0)
    {
        label.textColor = RED_COLOR;
    }
    else if(value < 0)
    {
        label.textColor = GREEN_COLOR;
    }
    else
    {
        label.textColor = TEXT_COLOR;
    }
}
@end
