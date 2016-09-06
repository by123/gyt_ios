//
//  TimeConditionView.m
//  gyt
//
//  Created by by.huang on 16/8/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "TimeConditionView.h"
#import "ByTextField.h"
#import "ByDatePicker.h"

#define Tag_LastPrice 0
#define Tag_Dirctor 1
#define Tag_Price 2
#define Tag_Time 3

@interface TimeConditionView()

@property (strong, nonatomic) UIButton *directorBtn;

@property (strong, nonatomic) UIButton *tipsBtn;

@property (strong, nonatomic) AddReduceView *handView;

@property (strong, nonatomic) UIButton *priceBtn;

@property (strong, nonatomic) AddReduceView *priceView;

@property (strong, nonatomic) UIButton *timeBtn;

@property (strong, nonatomic) AddReduceView *lossView;

@property (strong, nonatomic) AddReduceView *profitView;

@property (strong, nonatomic) UILabel *lossLabel;

@property (strong, nonatomic) UILabel *profitLabel;

@property (strong, nonatomic) UISwitch *seniorSwitch;

@property (strong, nonatomic) UIButton *confirmBtn;

@property (strong, nonatomic) UIButton *timeTextField;
@end

@implementation TimeConditionView
{
    int pLastPrice;
    int pDirector;
    int pPrice;
    int pTime;
    
}

-(instancetype)initWithData : (PushModel *)model
                       view : (UIView *)rootView
{
    if(self == [super init])
    {
        self.model = model;
        self.rootView = rootView;
        [self initView];
    }
    return self;
}

-(void)initView
{
    pLastPrice = 0 ;
    pDirector = 0;
    pPrice = 0;
    pTime = 0;
    
    self.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT + 40, SCREEN_WIDTH, SCREEN_HEIGHT - ( NavigationBar_HEIGHT + StatuBar_HEIGHT + 40));
    
    UILabel *instrumentLabel = [[UILabel alloc]init];
    instrumentLabel.textColor = TEXT_COLOR;
    instrumentLabel.text = [NSString stringWithFormat:@"合约：%@",_model.m_strInstrumentID];
    instrumentLabel.font = [UIFont systemFontOfSize:14.0f];
    instrumentLabel.textAlignment = NSTextAlignmentCenter;
    instrumentLabel.frame = CGRectMake(10, 0, instrumentLabel.contentSize.width, 40);
    [self addSubview:instrumentLabel];
    
    
    //时间条件
    UILabel *timePriceLabel = [[UILabel alloc]init];
    timePriceLabel.textColor = TEXT_COLOR;
    timePriceLabel.text = @"时间到达：";
    timePriceLabel.font = [UIFont systemFontOfSize:14.0f];
    timePriceLabel.textAlignment = NSTextAlignmentCenter;
    timePriceLabel.frame = CGRectMake(10, 40, timePriceLabel.contentSize.width, 30);
    [self addSubview:timePriceLabel];
    

    _timeTextField = [[UIButton alloc]init];
    [_timeTextField setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _timeTextField.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _timeTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _timeTextField.layer.borderWidth = 0.5;
    _timeTextField.layer.cornerRadius = 2;
    _timeTextField.layer.masksToBounds = YES;
    [_timeTextField setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_timeTextField setTitle:[AppUtil getNowTimeStr] forState:UIControlStateNormal];
    _timeTextField.frame = CGRectMake(10 + timePriceLabel.contentSize.width , 40, 100, 30);
    [_timeTextField addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeTextField];
    
    
    //下单方向
    UILabel *dirctorLabel = [[UILabel alloc]init];
    dirctorLabel.textColor = TEXT_COLOR;
    dirctorLabel.text = @"方向：";
    dirctorLabel.font = [UIFont systemFontOfSize:14.0f];
    dirctorLabel.textAlignment = NSTextAlignmentCenter;
    dirctorLabel.frame = CGRectMake(10, 80, dirctorLabel.contentSize.width, 30);
    [self addSubview:dirctorLabel];
    
    _directorBtn = [[UIButton alloc]init];
    [_directorBtn setTitle:@"买入" forState:UIControlStateNormal];
    _directorBtn.backgroundColor = SELECT_COLOR;
    _directorBtn.layer.masksToBounds = YES;
    _directorBtn.layer.cornerRadius = 4;
    _directorBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _directorBtn.frame = CGRectMake(dirctorLabel.contentSize.width + 10, 80, 60, 30);
    [_directorBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_directorBtn];
    
    
    //手数
    UILabel *handLabel = [[UILabel alloc]init];
    handLabel.textColor = TEXT_COLOR;
    handLabel.text = @"手数：";
    handLabel.font = [UIFont systemFontOfSize:14.0f];
    handLabel.textAlignment = NSTextAlignmentCenter;
    handLabel.frame = CGRectMake(10, 120, handLabel.contentSize.width, 30);
    [self addSubview:handLabel];
    
    _handView = [[AddReduceView alloc]initWithTitle:nil type:NumberInt tips:nil rootView:_rootView];
    _handView.frame = CGRectMake(handLabel.contentSize.width , 120, SCREEN_WIDTH, 30);
    _handView.delegate = self;
    _handView.userInteractionEnabled = YES;
    [_handView setDefaultValue:[NSString stringWithFormat:@"%d",1]];
    [self addSubview:_handView];
    
    
    //下单方式
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.textColor = TEXT_COLOR;
    priceLabel.text = @"下单：";
    priceLabel.font = [UIFont systemFontOfSize:14.0f];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.frame = CGRectMake(10, 160, priceLabel.contentSize.width, 30);
    [self addSubview:priceLabel];
    
    _priceBtn = [[UIButton alloc]init];
    [_priceBtn setTitle:@"对手价" forState:UIControlStateNormal];
    _priceBtn.backgroundColor = SELECT_COLOR;
    _priceBtn.layer.masksToBounds = YES;
    _priceBtn.layer.cornerRadius = 4;
    _priceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _priceBtn.frame = CGRectMake(priceLabel.contentSize.width + 10, 160, 60, 30);
    [_priceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_priceBtn];
    
    _priceView = [[AddReduceView alloc]initWithTitle:nil type:NumberFloat tips:nil rootView:_rootView];
    _priceView.frame = CGRectMake(10 + 60 + priceLabel.contentSize.width , 160, SCREEN_WIDTH, 30);
    _priceView.delegate = self;
    _priceView.userInteractionEnabled = YES;
    [_priceView setDefaultValue:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
    [self addSubview:_priceView];
    
    
    //时效
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = TEXT_COLOR;
    timeLabel.text = @"时效：";
    timeLabel.font = [UIFont systemFontOfSize:14.0f];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.frame = CGRectMake(10, 200, timeLabel.contentSize.width, 30);
    [self addSubview:timeLabel];
    
    _timeBtn = [[UIButton alloc]init];
    [_timeBtn setTitle:@"永久有效" forState:UIControlStateNormal];
    _timeBtn.backgroundColor = SELECT_COLOR;
    _timeBtn.layer.masksToBounds = YES;
    _timeBtn.layer.cornerRadius = 4;
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _timeBtn.frame = CGRectMake(timeLabel.contentSize.width + 10, 200, 80, 30);
    [_timeBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];
    
    //高级设置
    UILabel *seniorLabel = [[UILabel alloc]init];
    seniorLabel.textColor = TEXT_COLOR;
    seniorLabel.text = @"高级：";
    seniorLabel.font = [UIFont systemFontOfSize:14.0f];
    seniorLabel.textAlignment = NSTextAlignmentCenter;
    seniorLabel.frame = CGRectMake(10, 240, seniorLabel.contentSize.width, 30);
    [self addSubview:seniorLabel];
    
    _seniorSwitch = [[UISwitch alloc]init];
    _seniorSwitch.on = NO;
    _seniorSwitch.frame = CGRectMake(15 + seniorLabel.contentSize.width,240 , 0, 0);
    [_seniorSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_seniorSwitch];
    
    //止损设置
    _lossLabel = [[UILabel alloc]init];
    _lossLabel.textColor = TEXT_COLOR;
    _lossLabel.text = @"止损：";
    _lossLabel.font = [UIFont systemFontOfSize:14.0f];
    _lossLabel.textAlignment = NSTextAlignmentCenter;
    _lossLabel.frame = CGRectMake(10, 280, _lossLabel.contentSize.width, 30);
    [self addSubview:_lossLabel];
    
    _lossView = [[AddReduceView alloc]initWithTitle:nil type:NumberFloat tips:nil rootView:_rootView];
    _lossView.frame = CGRectMake(10 + _lossLabel.contentSize.width, 280, SCREEN_WIDTH, 30);
    _lossView.delegate = self;
    _lossView.userInteractionEnabled = YES;
    [_lossView setDefaultValue:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
    [self addSubview:_lossView];
    
    //止盈设置
    _profitLabel = [[UILabel alloc]init];
    _profitLabel.textColor = TEXT_COLOR;
    _profitLabel.text = @"止盈：";
    _profitLabel.font = [UIFont systemFontOfSize:14.0f];
    _profitLabel.textAlignment = NSTextAlignmentCenter;
    _profitLabel.frame = CGRectMake(10, 320, _profitLabel.contentSize.width, 30);
    [self addSubview:_profitLabel];
    
    _profitView = [[AddReduceView alloc]initWithTitle:nil type:NumberFloat tips:nil rootView:_rootView];
    _profitView.frame = CGRectMake(10 + _profitLabel.contentSize.width, 320, SCREEN_WIDTH, 30);
    _profitView.delegate = self;
    _profitView.userInteractionEnabled = YES;
    [_profitView setDefaultValue:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
    [self addSubview:_profitView];
    
    _lossView.hidden = YES;
    _lossLabel.hidden = YES;
    _profitView.hidden = YES;
    _profitLabel.hidden = YES;
    
    
    //发出按钮
    _confirmBtn = [[UIButton alloc]init];
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.layer.cornerRadius = 4;
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_confirmBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateNormal];
    [_confirmBtn setBackgroundImage:[AppUtil imageWithColor:SELECT_SELECT_COLOR] forState:UIControlStateSelected];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _confirmBtn.frame = CGRectMake(50, self.height - 60, SCREEN_WIDTH - 100, 40);
    [_confirmBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_confirmBtn];
    
    //    UIView *lineView = [[UIView alloc]init];
    //    lineView.backgroundColor = TEXT_COLOR;
    //    lineView.frame = CGRectMake(0, self.size.height - 150, SCREEN_WIDTH, 0.5);
    //    [self addSubview:lineView];
    //
    //    UILabel *tipsLabel = [[UILabel alloc]init];
    //    tipsLabel.textColor = TEXT_COLOR;
    //    tipsLabel.text = @"提示：\n\n1.条件单在云端运行，软件关闭仍然有效，云端自动确认结算单。\n2.条件单存在风险，云端i系统，网络故障等情况下失效。";
    //    tipsLabel.numberOfLines = 0;
    //    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    //    tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    tipsLabel.frame = CGRectMake(10, self.size.height - 140, SCREEN_WIDTH - 20, 140);
    //    [tipsLabel sizeToFit];
    //    [self addSubview:tipsLabel];
    
    //    _tipsBtn = [[UIButton alloc]init];
    //    [_tipsBtn setTitle:@"条件单风险提醒" forState:UIControlStateNormal];
    //    [_tipsBtn setTitleColor:[ColorUtil colorWithHexString:@"#0066ff"] forState:UIControlStateNormal];
    //    _tipsBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //    _tipsBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - _tipsBtn.titleLabel.contentSize.width,self.size.height -40 ,_tipsBtn.titleLabel.contentSize.width, 40);
    //    [_tipsBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_tipsBtn];
    
}

-(void)OnClick : (id)sender
{
    UIView *view = sender;
    if(view == _directorBtn)
    {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        [datas addObject:@"买入"];
        [datas addObject:@"卖出"];
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:datas title:@"请选择"];
        dialog.delegate = self;
        dialog.tag = Tag_Dirctor;
        [_rootView addSubview:dialog];
    }
    else if(view == _priceBtn)
    {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        [datas addObject:@"对手价"];
        [datas addObject:@"市价"];
        [datas addObject:@"最新价"];
        [datas addObject:@"限价"];
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:datas title:@"请选择"];
        dialog.delegate = self;
        dialog.tag = Tag_Price;
        [_rootView addSubview:dialog];
    }
    else if(view == _timeBtn)
    {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        [datas addObject:@"永久有效"];
        [datas addObject:@"当日有效"];
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:datas title:@"请选择"];
        dialog.delegate = self;
        dialog.tag = Tag_Time;
        [_rootView addSubview:dialog];
    }
    else if(view == _tipsBtn)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:Notify_Condition object:nil];
    }
    else if(view == _timeTextField)
    {
        [self showDatePicker];
    }
    else if(view == _confirmBtn)
    {
        
    }
}

-(void)OnListDialogItemClick:(id)data position:(NSInteger)position dialog:(ByListDialog *)dialog
{
    NSString *selectStr = data;
    if(dialog.tag == Tag_Dirctor)
    {
        pDirector = position;
        [_directorBtn setTitle:selectStr forState:UIControlStateNormal];
    }
    else if(dialog.tag == Tag_Price)
    {
        pPrice = position;
        [_priceBtn setTitle:selectStr forState:UIControlStateNormal];
        [self updatePriceValue];
    }
    else if(dialog.tag == Tag_Time)
    {
        pTime = position;
        [_timeBtn setTitle:selectStr forState:UIControlStateNormal];
    }
}

-(void)addBtnClick:(AddReduceView *)addReduceView
{
    if(addReduceView == _handView)
    {
        int hand = [[_handView.textField getTextFieldText] intValue];
        hand ++;
        [_handView.textField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
    }
    else if(addReduceView == _priceView)
    {
        pPrice = 3;
        [_priceBtn setTitle:@"限价" forState:UIControlStateNormal];
        double price = [[_priceView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_priceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(addReduceView == _lossView)
    {
        double price = [[_lossView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_lossView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(addReduceView == _profitView)
    {
        double price = [[_profitView.textField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_profitView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
}

-(void)reduceBtnClick:(AddReduceView *)addReduceView
{
    if(addReduceView == _handView)
    {
        int hand = [[_handView.textField getTextFieldText] intValue];
        if(hand <= 1)
        {
            [ByToast showErrorToast:@"手数不能小于等于0"];
            return;
        }
        hand --;
        [_handView.textField  setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
    }
    else if(addReduceView == _priceView)
    {
        pPrice = 3;
        [_priceBtn setTitle:@"限价" forState:UIControlStateNormal];
        double price = [[_priceView.textField getTextFieldText] doubleValue];
        price -= _model.m_dPriceTick;
        [_priceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(addReduceView == _lossView)
    {
        double price = [[_lossView.textField getTextFieldText] doubleValue];
        price -= _model.m_dPriceTick;
        [_lossView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
    else if(addReduceView == _profitView)
    {
        double price = [[_profitView.textField getTextFieldText] doubleValue];
        price -= _model.m_dPriceTick;
        [_profitView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
    }
}

-(void)textFinished:(double)text
{
    
}

-(void)switchAction : (id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    if(switchButton.isOn)
    {
        _lossView.hidden = NO;
        _lossLabel.hidden = NO;
        _profitView.hidden = NO;
        _profitLabel.hidden = NO;
    }
    else
    {
        _lossView.hidden = YES;
        _lossLabel.hidden = YES;
        _profitView.hidden = YES;
        _profitLabel.hidden = YES;
    }
    
}

#pragma mark 处理主推数据
-(void)updatePushData : (PushModel *)pushModel;
{
    if([pushModel.m_strInstrumentID isEqualToString:_model.m_strInstrumentID])
    {
        [self updatePriceValue];
    }
}

-(void)updatePriceValue
{
    switch (pPrice) {
        case 0:
            [_priceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
            break;
        case 1:
            [_priceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice * 1.1]];
            break;
        case 2:
            [_priceView.textField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice]];
            break;
        default:
            break;
    }
    
}

-(void)showDatePicker
{
    __weak TimeConditionView *weakSelf = self;
    ByDatePicker *datePicker = [[ByDatePicker alloc] initWithDatePickerMode:UIDatePickerModeTime DateFormatter:@"HH:mm" datePickerFinishBlock:^(NSString *dateString) {
        __strong TimeConditionView *strongSelf = weakSelf;
        [strongSelf.timeTextField setTitle:dateString forState:UIControlStateNormal];
     
    }];
    [datePicker show];
}

@end