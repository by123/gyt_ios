//
//  HistoryCell.m
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HistoryOrderCell.h"
#define Item_Height 200
#define Label_Height 32

@interface HistoryOrderCell()

@property (strong, nonatomic) UIButton *rootView;


//合同编号
@property (strong, nonatomic) UILabel *contractNumLabel;

//交易所合约
@property (strong, nonatomic) UILabel *instrumentLabel;

//交易时间
@property (strong, nonatomic) UILabel *dateLabel;

//委托价格
@property (strong, nonatomic) UILabel *orderPriceLabel;

//委托量
@property (strong, nonatomic) UILabel *orderNumLabel;

//剩余委托量
@property (strong, nonatomic) UILabel *volumeLeftLabel;

//委托状态
@property (strong, nonatomic) UILabel *orderStatusLabel;

//买卖方向
@property (strong, nonatomic) UILabel *directionLabel;

//币种
@property (strong, nonatomic) UILabel *moneyTypeLabel;

//成交均价
@property (strong, nonatomic) UILabel *tradedPriceLabel;

//成交数量
@property (strong, nonatomic) UILabel *volumeTradedLabel;

@end

@implementation HistoryOrderCell


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
    self.backgroundColor = [UIColor clearColor];
    
    _rootView = [[UIButton alloc]init];
    [_rootView setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#444444"]] forState:UIControlStateNormal];
    [_rootView setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateSelected];
    _rootView.frame = CGRectMake(10, 10, SCREEN_WIDTH -20 , Item_Height-10);
    _rootView.userInteractionEnabled = NO;
    [self.contentView addSubview:_rootView];

    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, Label_Height, SCREEN_WIDTH - 20, 0.5);
    lineView.backgroundColor = LINE_COLOR;
    [_rootView addSubview:lineView];
  
    //
    _contractNumLabel = [[UILabel alloc]init];
    [self setProperty:_contractNumLabel];
    _contractNumLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 40, Label_Height);
    _contractNumLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_contractNumLabel];
    
    //
    _instrumentLabel = [[UILabel alloc]init];
    [self setProperty:_instrumentLabel];
    _instrumentLabel.frame = CGRectMake(10, Label_Height,  SCREEN_WIDTH -20, Label_Height);
    _instrumentLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_instrumentLabel];

    //
    _dateLabel = [[UILabel alloc]init];
    [self setProperty:_dateLabel];
    _dateLabel.frame = CGRectMake(0, Label_Height,  SCREEN_WIDTH - 30, Label_Height);
    _dateLabel.textAlignment = NSTextAlignmentRight;
    [_rootView addSubview:_dateLabel];
    
    //
    _orderPriceLabel = [[UILabel alloc]init];
    [self setProperty:_orderPriceLabel];
    _orderPriceLabel.frame = CGRectMake(10, Label_Height*2, SCREEN_WIDTH - 20, Label_Height);
    _orderPriceLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_orderPriceLabel];
    
    //
    _orderNumLabel = [[UILabel alloc]init];
    [self setProperty:_orderNumLabel];
    _orderNumLabel.frame = CGRectMake(0, Label_Height * 2, SCREEN_WIDTH -30, Label_Height);
    _orderNumLabel.textAlignment = NSTextAlignmentRight;
    [_rootView addSubview:_orderNumLabel];
    
    //
    _volumeLeftLabel = [[UILabel alloc]init];
    [self setProperty:_volumeLeftLabel];
    _volumeLeftLabel.frame = CGRectMake(10, Label_Height*3, SCREEN_WIDTH -20, Label_Height);
    _volumeLeftLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_volumeLeftLabel];
    
    //
    _orderStatusLabel = [[UILabel alloc]init];
    [self setProperty:_orderStatusLabel];
    _orderStatusLabel.frame = CGRectMake(0, Label_Height * 3, SCREEN_WIDTH -30, Label_Height);
    _orderStatusLabel.textAlignment = NSTextAlignmentRight;
    [_rootView addSubview:_orderStatusLabel];
    
    //
    _directionLabel = [[UILabel alloc]init];
    [self setProperty:_directionLabel];
    _directionLabel.frame = CGRectMake(10, Label_Height*4, SCREEN_WIDTH-20, Label_Height);
    _directionLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_directionLabel];
    
    //
    _moneyTypeLabel = [[UILabel alloc]init];
    [self setProperty:_moneyTypeLabel];
        _moneyTypeLabel.frame = CGRectMake(0, Label_Height * 4, SCREEN_WIDTH-30, Label_Height);
    _moneyTypeLabel.textAlignment = NSTextAlignmentRight;
    [_rootView addSubview:_moneyTypeLabel];
    
    //
    _tradedPriceLabel = [[UILabel alloc]init];
    [self setProperty:_tradedPriceLabel];
        _tradedPriceLabel.frame = CGRectMake(10, Label_Height*5, SCREEN_WIDTH-20, Label_Height);
    _tradedPriceLabel.textAlignment = NSTextAlignmentLeft;
    [_rootView addSubview:_tradedPriceLabel];
    
    //
    _volumeTradedLabel = [[UILabel alloc]init];
    [self setProperty:_volumeTradedLabel];
    _volumeTradedLabel.frame = CGRectMake(0, Label_Height * 5, SCREEN_WIDTH-30, Label_Height);
    _volumeTradedLabel.textAlignment = NSTextAlignmentRight;
    [_rootView addSubview:_volumeTradedLabel];

}

-(void)setProperty : (UILabel *)label
{
    label.textColor = TEXT_COLOR;
    label.font = [UIFont systemFontOfSize:13.0f];
}


-(void)setData : (HistoryOrderModel *)model;
{
    _contractNumLabel.text = [NSString stringWithFormat:@"合同编号:%@",model.m_strOrderSysID];
    
    _instrumentLabel.text = [NSString stringWithFormat:@"合约：%@",model.m_strInstrumentID];
    
    NSString *dateStr = [AppUtil getFormatDate:model.m_nInsertDate];
    NSString *timeStr = [AppUtil getFormatTime:model.m_nInsertTime];
    _dateLabel.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    _orderPriceLabel.text = [NSString stringWithFormat:@"委托价：%.2f",model.m_dLimitPrice];
    
    _orderNumLabel.text = [NSString stringWithFormat:@"委托量：%d",model.m_nVolumeTotalOriginal];

    _volumeLeftLabel.text = [NSString stringWithFormat:@"剩余委托量：%d",model.m_nVolumeLeft];
    
    _orderStatusLabel.text = [NSString stringWithFormat:@"委托状态：%@",[Constant EEntrustStatusStr : model.m_nOrderStatus]];
    
    _directionLabel.text = [NSString stringWithFormat:@"买卖方向：%@",[Constant EEntrustBSStr : model.m_nDirection]];
    
    _moneyTypeLabel.text = [NSString stringWithFormat:@"币种：%@",[Constant getMoneyType : model.m_nMoneyType]];
    
    _tradedPriceLabel.text = [NSString stringWithFormat:@"成交均价：%.2f",model.m_dTradedPrice];
    
    _volumeTradedLabel.text = [NSString stringWithFormat:@"成交量：%d",model.m_nVolumeTraded];
    
}

+(NSString *)identify
{
    return @"HistoryOrderCell";
}

@end
