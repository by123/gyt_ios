//
//  StopLossView.m
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "StopLossView.h"
#import "ByTextField.h"
#import "StopLossModel.h"

@interface StopLossView()

@property (strong, nonatomic) ByTextField *lossPriceTextField;

@property (strong, nonatomic) UIButton *addPriceBtn;

@property (strong, nonatomic) UIButton *reducePriceBtn;

@property (strong, nonatomic) ByTextField *handTextField;

@property (strong, nonatomic) UIButton *addHandBtn;

@property (strong, nonatomic) UIButton *reduceHandBtn;

@property (strong, nonatomic) UILabel *priceCountLabel;

@property (strong, nonatomic) UIButton *tipsBtn;

@property (strong, nonatomic) UILabel *dynamicPriceLabel;

@property (strong, nonatomic) UISwitch *dynamicSwitch;

@property (strong, nonatomic) UILabel *retracementLabel;

@property (strong, nonatomic) ByTextField *retracementTextField;

@property (strong, nonatomic) UIButton *addRetracementBtn;

@property (strong, nonatomic) UIButton *reduceRetracementBtn;

@property (strong, nonatomic) UIButton *startBtn;


@property (strong, nonatomic) StopLossModel *stopLossModel;

@end

@implementation StopLossView

-(instancetype)initWithData : (DealHoldModel *)model
                       view : (UIView *)rootView
{
    if(self == [super init])
    {
        self.model = model;
        self.rootView = rootView;
        self.stopLossModel = [[StopLossModel alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView
{
    self.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT + 40, SCREEN_WIDTH, SCREEN_HEIGHT - ( NavigationBar_HEIGHT + StatuBar_HEIGHT + 40));
    
    UILabel *instrumentLabel = [[UILabel alloc]init];
    instrumentLabel.textColor = TEXT_COLOR;
    instrumentLabel.text = [NSString stringWithFormat:@"合约：%@",_model.m_strInstrumentID];
    instrumentLabel.font = [UIFont systemFontOfSize:14.0f];
    instrumentLabel.textAlignment = NSTextAlignmentCenter;
    instrumentLabel.frame = CGRectMake(10, 0, instrumentLabel.contentSize.width, 40);
    [self addSubview:instrumentLabel];
    
    UILabel *lossPriceLabel = [[UILabel alloc]init];
    lossPriceLabel.textColor = TEXT_COLOR;
    lossPriceLabel.text = @"止损价：";
    lossPriceLabel.font = [UIFont systemFontOfSize:14.0f];
    lossPriceLabel.textAlignment = NSTextAlignmentCenter;
    lossPriceLabel.frame = CGRectMake(10, 40, lossPriceLabel.contentSize.width, 30);
    [self addSubview:lossPriceLabel];
    
    _lossPriceTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(10 + lossPriceLabel.contentSize.width,40,100,30) rootView:_rootView title:nil];
    [_lossPriceTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dAvgPrice]];
    
    __weak StopLossView *weakSelf = self;
    _lossPriceTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        double value = [text doubleValue];
        [weakSelf isValidPrice:value];
        [weakSelf updateLossProfit];
    };
    [self addSubview:_lossPriceTextField];
    
    //增加价格
    _addPriceBtn = [[UIButton alloc]init];
    _addPriceBtn.frame = CGRectMake(_lossPriceTextField.x+_lossPriceTextField.width + 10, 40, 30, 30);
    [_addPriceBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addPriceBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addPriceBtn.layer.masksToBounds = YES;
    _addPriceBtn.layer.cornerRadius = 4;
    _addPriceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _addPriceBtn.backgroundColor = SELECT_COLOR;
    [_addPriceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addPriceBtn];
    
    //减少价格
    _reducePriceBtn = [[UIButton alloc]init];
    _reducePriceBtn.frame = CGRectMake(_addPriceBtn.x+_addPriceBtn.width + 10, 40, 30, 30);
    [_reducePriceBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reducePriceBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reducePriceBtn.layer.masksToBounds = YES;
    _reducePriceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reducePriceBtn.layer.cornerRadius = 4;
    _reducePriceBtn.backgroundColor = SELECT_COLOR;
    [_reducePriceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reducePriceBtn];
    
    
    //手数
    UILabel *handLabel = [[UILabel alloc]init];
    handLabel.textColor = TEXT_COLOR;
    handLabel.text = @"手数：";
    handLabel.font = [UIFont systemFontOfSize:14.0f];
    handLabel.textAlignment = NSTextAlignmentCenter;
    handLabel.frame = CGRectMake(10, 80, handLabel.contentSize.width, 30);
    [self addSubview:handLabel];
    
    _handTextField = [[ByTextField alloc]initWithType:NumberInt frame:CGRectMake(10 + lossPriceLabel.contentSize.width,80,100,30) rootView:_rootView title:nil];
    [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",_model.m_nPosition]];
    _handTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        [weakSelf updateLossProfit];
    };
    [self addSubview:_handTextField];
    
    //增加手数
    _addHandBtn = [[UIButton alloc]init];
    _addHandBtn.frame = CGRectMake(_handTextField.x+_handTextField.width + 10, 80, 30, 30);
    [_addHandBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addHandBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addHandBtn.layer.masksToBounds = YES;
    _addHandBtn.layer.cornerRadius = 4;
    _addHandBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _addHandBtn.backgroundColor = SELECT_COLOR;
    [_addHandBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addHandBtn];
    
    //减少价格
    _reduceHandBtn = [[UIButton alloc]init];
    _reduceHandBtn.frame = CGRectMake(_addHandBtn.x+_addHandBtn.width + 10, 80, 30, 30);
    [_reduceHandBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reduceHandBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reduceHandBtn.layer.masksToBounds = YES;
    _reduceHandBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reduceHandBtn.layer.cornerRadius = 4;
    _reduceHandBtn.backgroundColor = SELECT_COLOR;
    [_reduceHandBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceHandBtn];
    
    //计算盈亏
    _priceCountLabel = [[UILabel alloc]init];
    _priceCountLabel.textColor = GREEN_COLOR;
    _priceCountLabel.text = [NSString stringWithFormat:@"价差：%.2f  预期亏损：%.2f美金",0.0f,0.0f];
    _priceCountLabel.font = [UIFont systemFontOfSize:14.0f];
    _priceCountLabel.textAlignment = NSTextAlignmentLeft;
    _priceCountLabel.frame = CGRectMake(10, 120, SCREEN_WIDTH - 20, 40);
    [self addSubview:_priceCountLabel];
    
    
    //
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = TEXT_COLOR;
    lineView.frame = CGRectMake(0, self.size.height - 160, SCREEN_WIDTH, 0.5);
    [self addSubview:lineView];
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.textColor = TEXT_COLOR;
    tipsLabel.text = @"提示：\n\n1.止损单在云端运行，软件关闭仍然有效，云端自动确认结算单。\n2.止损单存在风险，云端系统，网络故障等情况下失效。";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipsLabel.frame = CGRectMake(10, self.size.height - 150, SCREEN_WIDTH - 20, 140);
    [tipsLabel sizeToFit];
    [self addSubview:tipsLabel];
    
    _tipsBtn = [[UIButton alloc]init];
    [_tipsBtn setTitle:@"止损单风险提醒" forState:UIControlStateNormal];
    [_tipsBtn setTitleColor:[ColorUtil colorWithHexString:@"#0066ff"] forState:UIControlStateNormal];
    _tipsBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _tipsBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - _tipsBtn.titleLabel.contentSize.width,self.size.height -40 ,_tipsBtn.titleLabel.contentSize.width, 40);
    [_tipsBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tipsBtn];
    
    //动态追踪
    _dynamicPriceLabel = [[UILabel alloc]init];
    _dynamicPriceLabel.text = @"动态追踪：";
    _dynamicPriceLabel.font = [UIFont systemFontOfSize:14.0f];
    _dynamicPriceLabel.textColor = TEXT_COLOR;
    _dynamicPriceLabel.frame = CGRectMake(10,160 , _dynamicPriceLabel.contentSize.width, 40);
    [self addSubview:_dynamicPriceLabel];
    
    
    _dynamicSwitch = [[UISwitch alloc]init];
    _dynamicSwitch.on = NO;
    _dynamicSwitch.frame = CGRectMake(15 + _dynamicPriceLabel.contentSize.width,160 , 0, 0);
    [_dynamicSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_dynamicSwitch];
    
    //价格回撤
    _retracementLabel = [[UILabel alloc]init];
    _retracementLabel.textColor = TEXT_COLOR;
    _retracementLabel.text = @"价格回撤：";
    _retracementLabel.font = [UIFont systemFontOfSize:14.0f];
    _retracementLabel.textAlignment = NSTextAlignmentCenter;
    _retracementLabel.frame = CGRectMake(10, 200, _retracementLabel.contentSize.width, 30);
    [self addSubview:_retracementLabel];
    
    _retracementTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(10 + _retracementLabel.contentSize.width,200,100,30) rootView:_rootView title:nil];
    [_retracementTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",0.0f]];
    _retracementTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        [weakSelf updateLossProfit];
    };
    [self addSubview:_retracementTextField];
    
    
    //价格回撤+
    _addRetracementBtn = [[UIButton alloc]init];
    _addRetracementBtn.frame = CGRectMake(_retracementTextField.x+_retracementTextField.width + 10, 200, 30, 30);
    [_addRetracementBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addRetracementBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addRetracementBtn.layer.masksToBounds = YES;
    _addRetracementBtn.layer.cornerRadius = 4;
    _addRetracementBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _addRetracementBtn.backgroundColor = SELECT_COLOR;
    [_addRetracementBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addRetracementBtn];
    
    //价格回撤－
    _reduceRetracementBtn = [[UIButton alloc]init];
    _reduceRetracementBtn.frame = CGRectMake(_addRetracementBtn.x+_addRetracementBtn.width + 10, 200, 30, 30);
    [_reduceRetracementBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reduceRetracementBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reduceRetracementBtn.layer.masksToBounds = YES;
    _reduceRetracementBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reduceRetracementBtn.layer.cornerRadius = 4;
    _reduceRetracementBtn.backgroundColor = SELECT_COLOR;
    [_reduceRetracementBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceRetracementBtn];
    
    _retracementLabel.hidden = YES;
    _retracementTextField.hidden = YES;
    _addRetracementBtn.hidden = YES;
    _reduceRetracementBtn.hidden = YES;
    
    //启动按钮
    _startBtn = [[UIButton alloc]init];
    _startBtn.layer.masksToBounds = YES;
    _startBtn.layer.cornerRadius = 4;
    [_startBtn setTitle:@"启动" forState:UIControlStateNormal];
    [_startBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_startBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_COLOR] forState:UIControlStateNormal];
    [_startBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_SELECT_COLOR] forState:UIControlStateSelected];
    _startBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _startBtn.frame = CGRectMake(50, 240, SCREEN_WIDTH - 100, 40);
    [_startBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_startBtn];
    

}

-(void)OnClick : (id)sender
{
    UIView *view = sender;
    if(view == _addPriceBtn)
    {
        double price = [[_lossPriceTextField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_lossPriceTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateLossProfit];
    }
    else if(view == _reducePriceBtn)
    {
        double price = [[_lossPriceTextField getTextFieldText] doubleValue];
        price -= _model.m_dPriceTick;
        [_lossPriceTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateLossProfit];
    }
    else if(view == _addHandBtn)
    {
        int hand = [[_handTextField getTextFieldText] intValue];
        hand ++;
        [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
        [self updateLossProfit];
    }
    else if(view == _reduceHandBtn)
    {
        int hand = [[_handTextField getTextFieldText] intValue];
        if(hand <= 1)
        {
            [ByToast showErrorToast:@"手数不能小于等于0"];
            return;
        }
        hand --;
        [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
        [self updateLossProfit];
    }
    else if(view == _tipsBtn)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notify_StopLoss object:@(0)];
    }
    else if(view == _addRetracementBtn)
    {
        double price = [[_retracementTextField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_retracementTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(view == _reduceRetracementBtn)
    {
        double price = [[_retracementTextField getTextFieldText] doubleValue];
        if(price == 0)
        {
            [ByToast showErrorToast:@"回撤价位必须大于0"];
            return;
        }
        price -= _model.m_dPriceTick;
        [_retracementTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(view == _startBtn)
    {
        if(_stopLossModel.isStart)
        {
            if(!_dynamicSwitch.isOn)
            {
                [self setViewEnable:_lossPriceTextField enable:YES];
                [self setViewEnable:_addPriceBtn enable:YES];
                [self setViewEnable:_reducePriceBtn enable:YES];
            }
            
            [self setViewEnable:_handTextField enable:YES];
            [self setViewEnable:_addHandBtn enable:YES];
            [self setViewEnable:_reduceHandBtn enable:YES];
            
            [self setViewEnable:_retracementTextField enable:YES];
            [self setViewEnable:_addRetracementBtn enable:YES];
            [self setViewEnable:_reduceRetracementBtn enable:YES];
            
            _dynamicSwitch.enabled = YES;
            _dynamicSwitch.alpha = 1.0f;
            
            [_startBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_COLOR] forState:UIControlStateNormal];
            [_startBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_SELECT_COLOR] forState:UIControlStateSelected];
            [_startBtn setTitle:@"启动" forState:UIControlStateNormal];
            
        }
        else
        {
            
            [self setViewEnable:_lossPriceTextField enable:NO];
            [self setViewEnable:_addPriceBtn enable:NO];
            [self setViewEnable:_reducePriceBtn enable:NO];
            
            [self setViewEnable:_handTextField enable:NO];
            [self setViewEnable:_addHandBtn enable:NO];
            [self setViewEnable:_reduceHandBtn enable:NO];
            
            [self setViewEnable:_retracementTextField enable:NO];
            [self setViewEnable:_addRetracementBtn enable:NO];
            [self setViewEnable:_reduceRetracementBtn enable:NO];
            
            _dynamicSwitch.enabled = NO;
            _dynamicSwitch.alpha = 0.8f;
            
            [_startBtn setBackgroundImage:[AppUtil imageWithColor:RED_COLOR] forState:UIControlStateNormal];
            [_startBtn setBackgroundImage:[AppUtil imageWithColor:RED_SELECT_COLOR] forState:UIControlStateSelected];
            [_startBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
        _stopLossModel.isStart = !_stopLossModel.isStart;
    }
}

-(void)switchAction : (id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    if(switchButton.isOn)
    {
        _retracementLabel.hidden = NO;
        _retracementTextField.hidden =NO;
        _addRetracementBtn.hidden = NO;
        _reduceRetracementBtn.hidden = NO;
        
        [self setViewEnable:_lossPriceTextField enable:NO];
        [self setViewEnable:_addPriceBtn enable:NO];
        [self setViewEnable:_reducePriceBtn enable:NO];
    }
    else
    {
        _retracementLabel.hidden = YES;
        _retracementTextField.hidden = YES;
        _addRetracementBtn.hidden = YES;
        _reduceRetracementBtn.hidden = YES;
        
        [self setViewEnable:_lossPriceTextField enable:YES];
        [self setViewEnable:_addPriceBtn enable:YES];
        [self setViewEnable:_reducePriceBtn enable:YES];
        
    }
    
}

-(void)updateLossProfit
{
    int hand = [[_handTextField getTextFieldText] intValue];
    double price = [[_lossPriceTextField getTextFieldText] doubleValue];
    double priceValue = _model.m_dAvgPrice - price;
    if(price <= _model.m_dAvgPrice)
    {
        _priceCountLabel.hidden = NO;
    }
    else
    {
        _priceCountLabel.hidden = YES;
    }
    double lossProfitValue = priceValue * hand;
    
    _priceCountLabel.text = [NSString stringWithFormat:@"价差：%.2f  预期亏损：%.2f美金",priceValue,lossProfitValue];
    
}

-(void)setViewEnable : (id)view
              enable : (Boolean)enable
{
    if([view isKindOfClass:[UIButton class]])
    {
        UIButton *button = view;
        if(enable)
        {
            button.alpha = 1;
            button.enabled = YES;
        }
        else
        {
            button.alpha = 0.8f;
            button.enabled = NO;
        }
    }
}



#pragma mark -----功能块-------

#pragma mark 价格设置是否合理
-(Boolean)isValidPrice : (double)price
{
    if(_model.m_dPriceTick == 0)
    {
        return NO;
    }
    int tempPrice = (int) (price * 100);
    int tempPrice1 = (int) (_model.m_dPriceTick * 100);
    if (fmod(tempPrice, tempPrice1) == 0)
    {
        return YES;
    }
    [ByToast showErrorToast:@"价格设置不是最小变动的整数倍"];
    return NO;
    
}


@end
