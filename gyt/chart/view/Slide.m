//
//  Slide.m
//  gyt
//
//  Created by by.huang on 16/5/5.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "Slide.h"

@interface Slide()

//价格
@property (strong, nonatomic) UILabel *priceLabel;

//时间
@property (strong, nonatomic) UILabel *timeLabel;

//开盘
@property (strong, nonatomic) UILabel *openPriceLabel;

//最高
@property (strong, nonatomic) UILabel *highPriceLabel;

//最低
@property (strong, nonatomic) UILabel *lowPriceLabel;

//收盘
@property (strong, nonatomic) UILabel *closePriceLabel;

//成交量
@property (strong, nonatomic) UILabel *dealLabel;

//持仓量
@property (strong, nonatomic) UILabel *holdLabel;

//涨跌
@property (strong, nonatomic) UILabel *updownLabel;

//涨跌比率
@property (strong, nonatomic) UILabel *updownPercentLabel;

@end

@implementation Slide


-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT /2);
    self.backgroundColor = [UIColor blackColor];
    self.layer.borderColor = [TEXT_COLOR CGColor];
    self.layer.borderWidth = 0.5f;
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = [UIColor yellowColor];
    _priceLabel.font = [UIFont systemFontOfSize:13.0f];
    _priceLabel.text = @"0";
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.frame = CGRectMake(5, 5, self.width, _priceLabel.contentSize.height);
    [self addSubview:_priceLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = [UIColor yellowColor];
    _timeLabel.font = [UIFont systemFontOfSize:13.0f];
    _timeLabel.text = @"--";
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.frame = CGRectMake(5, _priceLabel.height + _priceLabel.y, self.width, _timeLabel.contentSize.height);
    [self addSubview:_timeLabel];
    
    UILabel *openTitleLabel = [[UILabel alloc]init];
    openTitleLabel.textColor = TEXT_COLOR;
    openTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    openTitleLabel.text = @"开盘";
    openTitleLabel.textAlignment = NSTextAlignmentLeft;
    openTitleLabel.frame = CGRectMake(5, _timeLabel.height + _timeLabel.y, self.width, openTitleLabel.contentSize.height);
    [self addSubview:openTitleLabel];
    
    _openPriceLabel = [[UILabel alloc]init];
    _openPriceLabel.textColor = TEXT_COLOR;
    _openPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _openPriceLabel.text = @"0";
    _openPriceLabel.textAlignment = NSTextAlignmentCenter;
    _openPriceLabel.frame = CGRectMake(0, openTitleLabel.height + openTitleLabel.y, self.width, _openPriceLabel.contentSize.height);
    [self addSubview:_openPriceLabel];
    
    UILabel *highTitleLabel = [[UILabel alloc]init];
    highTitleLabel.textColor = TEXT_COLOR;
    highTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    highTitleLabel.text = @"最高";
    highTitleLabel.textAlignment = NSTextAlignmentLeft;
    highTitleLabel.frame = CGRectMake(5, _openPriceLabel.height + _openPriceLabel.y, self.width, highTitleLabel.contentSize.height);
    [self addSubview:highTitleLabel];
    
    _highPriceLabel = [[UILabel alloc]init];
    _highPriceLabel.textColor = TEXT_COLOR;
    _highPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _highPriceLabel.text = @"0";
    _highPriceLabel.textAlignment = NSTextAlignmentCenter;
    _highPriceLabel.frame = CGRectMake(0, highTitleLabel.height + highTitleLabel.y, self.width, _highPriceLabel.contentSize.height);
    [self addSubview:_highPriceLabel];
    
    UILabel *lowTitleLabel = [[UILabel alloc]init];
    lowTitleLabel.textColor = TEXT_COLOR;
    lowTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    lowTitleLabel.text = @"最低";
    lowTitleLabel.textAlignment = NSTextAlignmentLeft;
    lowTitleLabel.frame = CGRectMake(5, _highPriceLabel.height + _highPriceLabel.y, self.width, lowTitleLabel.contentSize.height);
    [self addSubview:lowTitleLabel];
    
    _lowPriceLabel = [[UILabel alloc]init];
    _lowPriceLabel.textColor = TEXT_COLOR;
    _lowPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _lowPriceLabel.text = @"0";
    _lowPriceLabel.textAlignment = NSTextAlignmentCenter;
    _lowPriceLabel.frame = CGRectMake(0, lowTitleLabel.height + lowTitleLabel.y, self.width, _lowPriceLabel.contentSize.height);
    [self addSubview:_lowPriceLabel];
    
    UILabel *closeTitleLabel = [[UILabel alloc]init];
    closeTitleLabel.textColor = TEXT_COLOR;
    closeTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    closeTitleLabel.text = @"收盘";
    closeTitleLabel.textAlignment = NSTextAlignmentLeft;
    closeTitleLabel.frame = CGRectMake(5, _lowPriceLabel.height + _lowPriceLabel.y, self.width, closeTitleLabel.contentSize.height);
    [self addSubview:closeTitleLabel];
    
    _closePriceLabel = [[UILabel alloc]init];
    _closePriceLabel.textColor = TEXT_COLOR;
    _closePriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _closePriceLabel.text = @"0";
    _closePriceLabel.textAlignment = NSTextAlignmentCenter;
    _closePriceLabel.frame = CGRectMake(0, closeTitleLabel.height + closeTitleLabel.y, self.width, _closePriceLabel.contentSize.height);
    [self addSubview:_closePriceLabel];
    
    _updownLabel = [[UILabel alloc]init];
    _updownLabel.textColor = TEXT_COLOR;
    _updownLabel.font = [UIFont systemFontOfSize:13.0f];
    _updownLabel.text = @"0";
    _updownLabel.textAlignment = NSTextAlignmentCenter;
    _updownLabel.frame = CGRectMake(0, _closePriceLabel.height + _closePriceLabel.y, self.width, _updownLabel.contentSize.height);
    [self addSubview:_updownLabel];
    
    _updownPercentLabel = [[UILabel alloc]init];
    _updownPercentLabel.textColor = TEXT_COLOR;
    _updownPercentLabel.font = [UIFont systemFontOfSize:13.0f];
    _updownPercentLabel.text = @"0.00%";
    _updownPercentLabel.textAlignment = NSTextAlignmentCenter;
    _updownPercentLabel.frame = CGRectMake(0, _updownLabel.height + _updownLabel.y, self.width, _updownPercentLabel.contentSize.height);
    [self addSubview:_updownPercentLabel];
    
    
    
    UILabel *dealTitleLabel = [[UILabel alloc]init];
    dealTitleLabel.textColor = TEXT_COLOR;
    dealTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    dealTitleLabel.text = @"成交量";
    dealTitleLabel.textAlignment = NSTextAlignmentLeft;
    dealTitleLabel.frame = CGRectMake(5, _updownPercentLabel.height + _updownPercentLabel.y, self.width, dealTitleLabel.contentSize.height);
    [self addSubview:dealTitleLabel];
    
    _dealLabel = [[UILabel alloc]init];
    _dealLabel.textColor =TEXT_COLOR;
    _dealLabel.font = [UIFont systemFontOfSize:13.0f];
    _dealLabel.text = @"0";
    _dealLabel.textAlignment = NSTextAlignmentCenter;
    _dealLabel.frame = CGRectMake(0, dealTitleLabel.height + dealTitleLabel.y, self.width, _closePriceLabel.contentSize.height);
    [self addSubview:_dealLabel];
    
    
    UILabel *holdTitleLabel = [[UILabel alloc]init];
    holdTitleLabel.textColor = TEXT_COLOR;
    holdTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    holdTitleLabel.text = @"持仓量";
    holdTitleLabel.textAlignment = NSTextAlignmentLeft;
    holdTitleLabel.frame = CGRectMake(5, _dealLabel.height + _dealLabel.y, self.width, dealTitleLabel.contentSize.height);
    [self addSubview:holdTitleLabel];
    
    _holdLabel = [[UILabel alloc]init];
    _holdLabel.textColor = TEXT_COLOR;
    _holdLabel.font = [UIFont systemFontOfSize:13.0f];
    _holdLabel.text = @"0";
    _holdLabel.textAlignment = NSTextAlignmentCenter;
    _holdLabel.frame = CGRectMake(0, holdTitleLabel.height + holdTitleLabel.y, self.width, _holdLabel.contentSize.height);
    [self addSubview:_holdLabel];
    
    
    UILabel *holdUpdownLabel = [[UILabel alloc]init];
    holdUpdownLabel.textColor = TEXT_COLOR;
    holdUpdownLabel.font = [UIFont systemFontOfSize:13.0f];
    holdUpdownLabel.text = @"0";
    holdUpdownLabel.textAlignment = NSTextAlignmentCenter;
    holdUpdownLabel.frame = CGRectMake(0, _holdLabel.height + _holdLabel.y, self.width, holdUpdownLabel.contentSize.height);
    [self addSubview:holdUpdownLabel];
    
}

-(void)setTime:(NSString *)time
{
    _timeLabel.text = time;
}

-(void)setData : (NSString *)text
{
    if([text containsString:@"Open"])
    {
        _openPriceLabel.text = [text substringFromIndex:6];
    }
    else if([text containsString:@"Close"])
    {
        _closePriceLabel.text = [text substringFromIndex:7];
    }
    else if([text containsString:@"High"])
    {
        _highPriceLabel.text = [text substringFromIndex:6];
    }
    else if([text containsString:@"Low"])
    {
        _lowPriceLabel.text = [text substringFromIndex:5];
    }
    else if([text containsString:@"Change"])
    {
        NSString *change = [text substringFromIndex:8];
        if([change containsString:@"0.00%"])
        {
            [self setUpDownTextColor:TEXT_COLOR];
        }
        else if([change containsString:@"-"])
        {
            [self setUpDownTextColor:[UIColor greenColor]];
        }
        else
        {
            [self setUpDownTextColor:[UIColor redColor]];
        }
        _updownPercentLabel.text = change;
    }
    else if([text containsString:@"VOL"])
    {
        _holdLabel.text = [text substringFromIndex:5];
    }
    else if([text containsString:@"Price"])
    {
        _priceLabel.text = [text substringFromIndex:7];
    }
}

-(void)setUpDownTextColor : (UIColor *)color
{
    _openPriceLabel.textColor = color;
    _closePriceLabel.textColor = color;
    _highPriceLabel.textColor = color;
    _lowPriceLabel.textColor = color;
    _updownLabel.textColor = color;
    _updownPercentLabel.textColor = color;
    _holdLabel.textColor = color;
    _dealLabel.textColor = color;
    
}
@end
