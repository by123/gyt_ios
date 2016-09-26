//
//  OrderStopLossView.m
//  gyt
//
//  Created by by.huang on 16/8/29.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "OrderStopLossView.h"
#import "ByTextField.h"
#import "OrderStopLossModel.h"
#import "OrderRequestModel.h"
#import "OrderModel.h"
#import "StopValueTag.h"

@interface OrderStopLossView()

@property (strong, nonatomic) AddReduceView *priceView;

@property (strong, nonatomic) AddReduceView *handView;

@property (strong, nonatomic) AddReduceView *lossView;

@property (strong, nonatomic) AddReduceView *profitView;

@property (assign, nonatomic) EEntrustBS director;

@property (strong, nonatomic) UIButton *orderBtn;




@end

@implementation OrderStopLossView

-(instancetype)initWithData : (PushModel *)model
                       view : (BaseViewController *)controller
{
    if(self == [super init])
    {
        self.model = model;
        self.controller = controller;
        self.rootView = controller.view;
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
  
    
    _priceView = [[AddReduceView alloc]initWithTitle:@"价格：" type:NumberFloat tips:@"＋0.00" rootView:_rootView];
    _priceView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 50);
    _priceView.delegate = self;
    _priceView.userInteractionEnabled = YES;
    [_priceView setDefaultValue:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
    [self addSubview:_priceView];
    
    
    _handView = [[AddReduceView alloc]initWithTitle:@"手数：" type:NumberInt tips:@"" rootView:_rootView];
    _handView.frame = CGRectMake(0, 100, SCREEN_WIDTH, 50);
    _handView.delegate = self;
    _handView.userInteractionEnabled = YES;
    [_handView setDefaultValue:@"1"];
    [self addSubview:_handView];
    
    _lossView = [[AddReduceView alloc]initWithTitle:@"止损价：" type:NumberFloat tips:@"未设置" rootView:_rootView];
    _lossView.frame = CGRectMake(0, 160, SCREEN_WIDTH, 50);
    _lossView.delegate = self;
    _lossView.userInteractionEnabled = YES;
    [_lossView setDefaultValue:[NSString stringWithFormat:@"%.2f",0.0f]];
    [self addSubview:_lossView];
    
    _profitView = [[AddReduceView alloc]initWithTitle:@"止盈价：" type:NumberFloat tips:@"未设置" rootView:_rootView];
    _profitView.frame = CGRectMake(0, 220, SCREEN_WIDTH, 50);
    _profitView.delegate = self;
    _profitView.userInteractionEnabled = YES;
    [_profitView setDefaultValue:[NSString stringWithFormat:@"%.2f",0.0f]];
    [self addSubview:_profitView];


    _orderBtn = [[UIButton alloc]init];
    _orderBtn.layer.masksToBounds = YES;
    _orderBtn.layer.cornerRadius = 4;
    [_orderBtn setTitle:@"下单（买）" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_orderBtn setBackgroundImage:[AppUtil imageWithColor:RED_COLOR] forState:UIControlStateNormal];
    [_orderBtn setBackgroundImage:[AppUtil imageWithColor:RED_SELECT_COLOR] forState:UIControlStateSelected];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _orderBtn.frame = CGRectMake(50, 280, SCREEN_WIDTH - 100, 40);
    [_orderBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_orderBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = TEXT_COLOR;
    lineView.frame = CGRectMake(0, self.size.height - 130, SCREEN_WIDTH, 0.5);
    [self addSubview:lineView];
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.textColor = TEXT_COLOR;
    tipsLabel.text = @"提示:\n\n1.止损开仓是在挂单列表生成一条止损预备单，内容可以在挂单列表修改\n2.止损预备单在委托成交后才转化为止损单，成交前退出软件会导致预备单丢失";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipsLabel.frame = CGRectMake(10, self.size.height - 120, SCREEN_WIDTH - 20, 140);
    [tipsLabel sizeToFit];
    [self addSubview:tipsLabel];
    
    
}

-(void)addBtnClick:(AddReduceView *)addReduceView
{
    if(addReduceView == _priceView)
    {
        double price = [[_priceView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updatePriceValue];
    }
    else if(addReduceView == _handView)
    {
        int hand = [[addReduceView.textField getTextFieldText] intValue];
        hand ++;
        [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
        [self updateLossValue];
        [self updateProfitValue];
    }
    else if(addReduceView == _lossView)
    {
        double price = [[_lossView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateLossValue];
    }
    else if(addReduceView == _profitView)
    {
        double price = [[_profitView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateProfitValue];
    }
}

-(void)reduceBtnClick:(AddReduceView *)addReduceView
{
    if(addReduceView == _priceView)
    {
        double price = [[_priceView.textField getTextFieldText] doubleValue];
        if([self isValidPrice:price])
        {
            price -= _model.m_dPriceTick;
            [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        }
        [self updatePriceValue];
    }
    else if(addReduceView == _handView)
    {
        int hand = [[addReduceView.textField getTextFieldText] intValue];
        if(hand <= 1)
        {
            [ByToast showErrorToast:@"手数不能小于等于0"];
            return;
        }
        hand --;
        [addReduceView.textField  setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
        [self updateLossValue];
        [self updateProfitValue];
    }
    else if(addReduceView == _lossView)
    {
        double price = [[_lossView.textField getTextFieldText] doubleValue];
        if([self isValidPrice:price])
        {
            price -= _model.m_dPriceTick;
            [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
            [self updateLossValue];
        }
    }
    else if(addReduceView == _profitView)
    {
        double price = [[_profitView.textField getTextFieldText] doubleValue];
        if([self isValidPrice:price])
        {
            price -= _model.m_dPriceTick;
            [addReduceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
            [self updateProfitValue];
        }
    }

}

-(void)setDirector : (EEntrustBS)director
{
    _director = director;
    [self updatePriceValue];
    [self updateLossValue];
    [self updateProfitValue];
    [self updateOrderBtn];
}



#pragma mark 更新联动后，价格差
-(void)updatePriceValue
{
    double currentPrice = [[_priceView.textField getTextFieldText] doubleValue];
    double price = 0.0f;
    if(_director == ENTRUST_BUY)
    {
        price = currentPrice - _model.m_dAskPrice1;
    }
    else
    {
        price = currentPrice - _model.m_dBidPrice1;
    }
    if(price < 0)
    {
        _priceView.tipsLabel.textColor = GREEN_COLOR;
        _priceView.tipsLabel.text = [NSString stringWithFormat:@"%.2f",price];
    }
    else
    {
        _priceView.tipsLabel.text = [NSString stringWithFormat:@"+%.2f",price];
        if(price == 0)
        {
            _priceView.tipsLabel.textColor = TEXT_COLOR;
        }
        else
        {
            _priceView.tipsLabel.textColor = RED_COLOR;
        }
    }
    [self updateLossValue];
    [self updateProfitValue];
}

#pragma mark 更新联动后，止损差
-(void)updateLossValue
{
    double currentPrice = [[_priceView.textField getTextFieldText] doubleValue];
    double currentLoss = [[_lossView.textField getTextFieldText] doubleValue];
    int hand = [[_handView.textField getTextFieldText] intValue];
    if(currentLoss == 0)
    {
        _lossView.tipsLabel.text = @"未设置";
        _lossView.tipsLabel.textColor = TEXT_COLOR;
        return;
    }
    if(_director == ENTRUST_BUY)
    {
        _lossView.tipsLabel.text = [NSString stringWithFormat:@"止损价差%.2f，亏%.2f",currentPrice - currentLoss,hand *(currentPrice - currentLoss)];
    }
    else
    {
        _lossView.tipsLabel.text = [NSString stringWithFormat:@"止损价差%.2f，亏%.2f",currentLoss - currentPrice,hand *(currentLoss - currentPrice)];
    }
    if(currentPrice - currentLoss == 0)
    {
        _lossView.tipsLabel.textColor = TEXT_COLOR;
    }
    else
    {
        _lossView.tipsLabel.textColor = GREEN_COLOR;
    }
}

#pragma mark 更新联动后，止盈差
-(void)updateProfitValue
{
    double currentPrice = [[_priceView.textField getTextFieldText] doubleValue];
    double currentProfit = [[_profitView.textField getTextFieldText] doubleValue];
    int hand = [[_handView.textField getTextFieldText] intValue];
    if(currentProfit == 0)
    {
        _profitView.tipsLabel.text = @"未设置";
        _profitView.tipsLabel.textColor = TEXT_COLOR;
        return;
    }
    
    if(_director == ENTRUST_BUY)
    {
        _profitView.tipsLabel.text = [NSString stringWithFormat:@"止盈价差%.2f，盈%.2f",currentProfit - currentPrice,hand *(currentProfit - currentPrice)];
    }
    else
    {
        _profitView.tipsLabel.text = [NSString stringWithFormat:@"止盈价差%.2f，盈%.2f",currentPrice - currentProfit,hand *(currentPrice - currentProfit)];
    }
    if(currentPrice - currentProfit == 0)
    {
        _profitView.tipsLabel.textColor = TEXT_COLOR;
    }
    else
    {
        _profitView.tipsLabel.textColor = RED_COLOR;
    }
}

#pragma mark 更新下单按钮
-(void)updateOrderBtn
{
    if(_director == ENTRUST_BUY)
    {
        [_orderBtn setTitle:@"下单（买）" forState:UIControlStateNormal];
        [_orderBtn setBackgroundImage:[AppUtil imageWithColor:RED_COLOR] forState:UIControlStateNormal];
        [_orderBtn setBackgroundImage:[AppUtil imageWithColor:RED_SELECT_COLOR] forState:UIControlStateSelected];

    }
    else
    {
        [_orderBtn setTitle:@"下单（卖）" forState:UIControlStateNormal];
        [_orderBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_COLOR] forState:UIControlStateNormal];
        [_orderBtn setBackgroundImage:[AppUtil imageWithColor:GREEN_SELECT_COLOR] forState:UIControlStateSelected];
    }
}

-(void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(button == _orderBtn)
    {
        [self requestStart];
    }
}

-(void)textFinished:(double)text
{
    [self updatePriceValue];
    [self updateLossValue];
    [self updateProfitValue];
}

#pragma mark 设置止盈止损启动
-(void)requestStart
{
    double orderPrice = [[_priceView.textField getTextFieldText] doubleValue];
    int hand = [[_handView.textField getTextFieldText] intValue];
    double profitPrice = [[_profitView.textField getTextFieldText] doubleValue];
    double lossPrice = [[_lossView.textField getTextFieldText] doubleValue];
    
    StopValueTag *stopValueTag = [[StopValueTag alloc]init];
    
    stopValueTag.m_dStopProfitValue  = profitPrice;
    stopValueTag.m_dStopLossValue = lossPrice;
    
    stopValueTag.m_bEnableStopProfit = (profitPrice == 0) ? false : true;
    stopValueTag.m_bEnableStopLoss = (lossPrice == 0) ? false : true;
    
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    OrderRequestModel *orderModel = [[OrderRequestModel alloc]init];
    orderModel.strSessionID = [[Account sharedAccount]getSessionId];
    orderModel.account = account;

    orderModel.info = [OrderModel buildOrderModel : _model.m_strProductID instrumentID:_model.m_strInstrumentID  orderPrice:orderPrice orderNum:hand direction:_director offsetFlag:EOFF_THOST_FTDC_OF_Open priceType:BROKER_PRICE_COMPETE stopTag:stopValueTag];
    
    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    NSLog(@"%@",jsonStr);
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_ORDER];
    
    [self.controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark 处理下单数据
-(void)handleOrderData : (BaseRespondModel *)respondModel
{
    NSLog(@"123");
}



#pragma mark -----功能块-------

#pragma mark 价格设置是否合理
-(Boolean)isValidPrice : (double)price
{
    if(_model.m_dPriceTick == 0)
    {
        [ByToast showErrorToast:@"未获取到最小变动价格"];
        return NO;
    }
    if(price <= 0)
    {
        [ByToast showErrorToast:@"价格不能小于0"];
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

#pragma mark 处理主推数据
-(void)updatePushData : (PushModel *)pushModel;
{
    if([pushModel.m_strInstrumentID isEqualToString:_model.m_strInstrumentID])
    {
        [self updatePriceValue];
    }
}

@end
