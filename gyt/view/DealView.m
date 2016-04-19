//
//  DealView.m
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DealView.h"
#import "InsetTextField.h"
#import "ByTabView.h"
#import "ByDynamicTableView.h"

@interface DealView()

//权益
@property (strong, nonatomic) UILabel *rightLabel;

//可用资金
@property (strong, nonatomic) UILabel *canUseLabel;

//使用率
@property (strong, nonatomic) UILabel *userPercentLabel;

//买价
@property (strong, nonatomic) UILabel *buyPriceLabel;

//卖价
@property (strong, nonatomic) UILabel *sellPriceLabel;

//自选合约
@property (strong, nonatomic) InsetTextField *textField;

//买入按钮
@property (strong, nonatomic) UIButton *buyItem;

//卖出按钮
@property (strong, nonatomic) UIButton *sellItem;

//开仓按钮
@property (strong, nonatomic) UIButton *openPositionItem;

//平仓按钮
@property (strong, nonatomic) UIButton *closePositionItem;

//平今按钮（只有上海交易所）
@property (strong, nonatomic) UIButton *closeDailyPositionItem;

//手数
@property (strong, nonatomic) InsetTextField *handTextField;

//价格
@property (strong, nonatomic) InsetTextField *priceTextField;

//下单
@property (strong, nonatomic) UIButton *orderButton;

//持仓，挂单，委托，成交 标题
@property (strong, nonatomic) ByTabView *tabView;

//持仓，挂单，委托，成交
@property (strong, nonatomic) ByDynamicTableView *dynamicView;

@end

@implementation DealView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.backgroundColor = LINE_COLOR;
    [self initTopView];
    [self initBottomView];
}


-(void)initTopView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
    [self addSubview:view];
    
    _rightLabel = [[UILabel alloc]init];
    _rightLabel.textColor = TEXT_COLOR;
    _rightLabel.text = @"权益: 9999042";
    _rightLabel.font = [UIFont systemFontOfSize:13.0f];
    _rightLabel.frame = CGRectMake(5, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_rightLabel];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor blackColor];
    line1.frame = CGRectMake(SCREEN_WIDTH/3, 0, 0.5, 25);
    [view addSubview:line1];
    
    _canUseLabel = [[UILabel alloc]init];
    _canUseLabel.textColor = TEXT_COLOR;
    _canUseLabel.text = @"可用: 9998232";
    _canUseLabel.font = [UIFont systemFontOfSize:13.0f];
    _canUseLabel.frame = CGRectMake(SCREEN_WIDTH/3 + 5, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_canUseLabel];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor blackColor];
    line2.frame = CGRectMake(SCREEN_WIDTH * 2/3, 0, 0.5, 25);
    [view addSubview:line2];

    _userPercentLabel = [[UILabel alloc]init];
    _userPercentLabel.textColor = TEXT_COLOR;
    _userPercentLabel.text = @"使用率: 0.01%";
    _userPercentLabel.font = [UIFont systemFontOfSize:13.0f];
    _userPercentLabel.frame = CGRectMake(SCREEN_WIDTH * 2/3 + 5, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_userPercentLabel];
    
    
    _textField = [[InsetTextField alloc]initWithFrame:CGRectMake(10, view.height+5, SCREEN_WIDTH/2-20, 30)];
    _textField.hasTitle = NO;
    _textField.text = @"橡胶1607";
    _textField.delegate = self;
    [self addSubview:_textField];
    
    UIView *priceView = [[UIView alloc]init];
    priceView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];;
    priceView.frame = CGRectMake(SCREEN_WIDTH/2, view.height + 5, SCREEN_WIDTH/2, 30);
    priceView.layer.cornerRadius = 2;
    priceView.layer.masksToBounds = YES;
    [self addSubview:priceView];
    
    _buyPriceLabel = [[UILabel alloc]init];
    _buyPriceLabel.textColor = TEXT_COLOR;
    _buyPriceLabel.text = @"买价:4792";
    _buyPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _buyPriceLabel.frame = CGRectMake(5, 0, SCREEN_WIDTH/4, 30);
    [priceView addSubview:_buyPriceLabel];
    
    _sellPriceLabel = [[UILabel alloc]init];
    _sellPriceLabel.textColor = TEXT_COLOR;
    _sellPriceLabel.text = @"卖价:4794";
    _sellPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _sellPriceLabel.frame = CGRectMake(5 + SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 30);
    [priceView addSubview:_sellPriceLabel];
    
    
    //买入
    _buyItem = [[UIButton alloc]init];
    [_buyItem setTitle:@"买入" forState:UIControlStateNormal];
    [_buyItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyItem.frame = CGRectMake(10, view.height + 40, (SCREEN_WIDTH -20)/2, 30);
    _buyItem.backgroundColor = SELECT_COLOR;
    [_buyItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buyItem];
    
    //卖出
    _sellItem = [[UIButton alloc]init];
    [_sellItem setTitle:@"卖出" forState:UIControlStateNormal];
    [_sellItem setTitleColor:[ColorUtil colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _sellItem.frame = CGRectMake(10 + (SCREEN_WIDTH-20)/2, view.height + 40,  (SCREEN_WIDTH -20)/2, 30);
    _sellItem.backgroundColor = [ColorUtil colorWithHexString:@"#aaaaaa"];
    [_sellItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sellItem];
    
    //开仓
    _openPositionItem= [[UIButton alloc]init];
    [_openPositionItem setTitle:@"开仓" forState:UIControlStateNormal];
    [_openPositionItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _openPositionItem.frame = CGRectMake(10, view.height + 40 + 35, (SCREEN_WIDTH -20)/3, 30);
    _openPositionItem.backgroundColor = SELECT_COLOR;
    [_openPositionItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_openPositionItem];
    
    //平仓
    _closePositionItem = [[UIButton alloc]init];
    [_closePositionItem setTitle:@"平仓" forState:UIControlStateNormal];
    [_closePositionItem setTitleColor:[ColorUtil colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _closePositionItem.frame = CGRectMake(10 + (SCREEN_WIDTH - 20 ) /3, view.height + 40 + 35, (SCREEN_WIDTH - 20 ) /3 , 30);
    _closePositionItem.backgroundColor = [ColorUtil colorWithHexString:@"#aaaaaa"];
    [_closePositionItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closePositionItem];

    //平今
    _closeDailyPositionItem = [[UIButton alloc]init];
    [_closeDailyPositionItem setTitle:@"平今" forState:UIControlStateNormal];
    [_closeDailyPositionItem setTitleColor:[ColorUtil colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    _closeDailyPositionItem.frame = CGRectMake(10 + (SCREEN_WIDTH - 20 ) *2/3, view.height + 40 + 35, (SCREEN_WIDTH - 20 ) /3, 30);
    _closeDailyPositionItem.backgroundColor = [ColorUtil colorWithHexString:@"#aaaaaa"];
    [_closeDailyPositionItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeDailyPositionItem];
    
   
    [self addLineView:CGRectMake(10 + (SCREEN_WIDTH -20)/2, view.height + 40, 0.5, 30)];
    [self addLineView:CGRectMake(10 + (SCREEN_WIDTH - 20)/3, view.height + 40 + 35, 0.5, 30)];
    [self addLineView:CGRectMake(10 + (SCREEN_WIDTH - 20)*2/3, view.height + 40 + 35, 0.5, 30)];
    
    //手数
    _handTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(10, _closeDailyPositionItem.y + _closeDailyPositionItem.height + 5, (SCREEN_WIDTH-30)/2, 30)];
    _handTextField.hasTitle = YES;
    [_handTextField setInsetTitle:@"手数：" font:[UIFont systemFontOfSize:14.0f]];
    _handTextField.text = @"1";
    _handTextField.delegate = self;
    _handTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_handTextField];
    
    //价格
    _priceTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(20 +(SCREEN_WIDTH-30)/2 , _closeDailyPositionItem.y + _closeDailyPositionItem.height + 5, (SCREEN_WIDTH-30)/2, 30)];
    _priceTextField.hasTitle = YES;
    [_priceTextField setInsetTitle:@"价格：" font:[UIFont systemFontOfSize:14.0f]];
    _priceTextField.text = @"1989";
    _priceTextField.delegate = self;
    _priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_priceTextField];
    
    //下单
    _orderButton = [[UIButton alloc]init];
    [_orderButton setTitle:@"下单" forState:UIControlStateNormal];
    [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderButton.backgroundColor = [ColorUtil colorWithHexString:@"#c34648"];
    _orderButton.layer.masksToBounds = YES;
    _orderButton.layer.cornerRadius = 4;
    _orderButton.frame = CGRectMake(10, _priceTextField.y + _priceTextField.height + 10, SCREEN_WIDTH-20, 40);
    [_orderButton addTarget: self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_orderButton];
    
}


-(void)addLineView : (CGRect)rect
{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    lineView.frame = rect;
    [self addSubview:lineView];
}




-(void)initBottomView
{
    NSArray *array = @[@"持仓",@"挂单",@"委托",@"成交"];
    CGRect rect = CGRectMake(0, _orderButton.y + _orderButton.height+10, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self addSubview:_tabView];
    
    [self initHoldData];
}


#pragma mark 持仓数据
-(void)initHoldData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [temp addObject:@"郑麦1605"];
    [temp addObject:@"多"];
    [temp addObject:@"10"];
    [temp addObject:@"10"];
    [temp addObject:@"2726.00"];
    [temp addObject:@"1200"];
    
    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:temp];
    }
    NSArray *titleArray = @[@"名称",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈"];
    NSArray *widthArray = @[@"2",@"1",@"1",@"1",@"2",@"2"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    [self addSubview:_dynamicView];
}

#pragma mark 挂单数据
-(void)initHoldingData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [temp addObject:@"郑麦1605"];
    [temp addObject:@"全平"];
    [temp addObject:@"2020"];
    [temp addObject:@"10"];
    [temp addObject:@"10"];
    
    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:temp];
    }
    NSArray *titleArray = @[@"名称",@"开平",@"委托价",@"委托量",@"挂单量"];
    NSArray *widthArray = @[@"2",@"1",@"2",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    [self addSubview:_dynamicView];

}

#pragma mark 委托数据
-(void)initHoldByData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [temp addObject:@"郑麦1605"];
    [temp addObject:@"1"];
    [temp addObject:@"全平"];
    [temp addObject:@"5040"];
    [temp addObject:@"5"];
    [temp addObject:@"5"];
    [temp addObject:@"0"];
    [temp addObject:@"20:12"];

    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:temp];
    }
    NSArray *titleArray = @[@"名称",@"状态",@"开平",@"委托价",@"委托量",@"已成交",@"已撤单",@"委托时间"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH * 1.5];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    [self addSubview:_dynamicView];
}

#pragma mark 成交数据
-(void)initDealData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [temp addObject:@"郑麦1605"];
    [temp addObject:@"全平"];
    [temp addObject:@"5040"];
    [temp addObject:@"5"];
    [temp addObject:@"19:28"];
    
    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:temp];
    }
    NSArray *titleArray = @[@"名称",@"开平",@"成交价",@"成交量",@"成交时间"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    [self addSubview:_dynamicView];
}

#pragma mark tabview选择
-(void)OnSelect:(NSInteger)position
{
    switch (position) {
        case 0:
            [self initHoldData];
            break;
        case 1:
            [self initHoldingData];
            break;
        case 2:
            [self initHoldByData];
            break;
        case 3:
            [self initDealData];
            break;
        default:
            break;
    }
}


#pragma mark 文本编辑框事件处理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}



#pragma mark 点击事件处理
-(void)OnClick : (id)sender
{
    UIView *view = sender;
    if(view == _buyItem)
    {
        [self changeNormalStatu:_sellItem];
        [self changeSelectStatu:_buyItem];
        _orderButton.backgroundColor = [ColorUtil colorWithHexString:@"#c34648"];
    }
    else if(view == _sellItem)
    {
        [self changeNormalStatu:_buyItem];
        [self changeSelectStatu:_sellItem];
        _orderButton.backgroundColor = [ColorUtil colorWithHexString:@"#449d61"];

    }
    else if(view == _openPositionItem)
    {
        [self changeSelectStatu:_openPositionItem];
        [self changeNormalStatu:_closePositionItem];
        [self changeNormalStatu:_closeDailyPositionItem];
    }
    else if(view == _closePositionItem)
    {
        [self changeNormalStatu:_openPositionItem];
        [self changeSelectStatu:_closePositionItem];
        [self changeNormalStatu:_closeDailyPositionItem];
    }
    else if(view == _closeDailyPositionItem)
    {
        [self changeNormalStatu:_openPositionItem];
        [self changeNormalStatu:_closePositionItem];
        [self changeSelectStatu:_closeDailyPositionItem];
    }
}

-(void)changeSelectStatu : (UIButton *)button
{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = SELECT_COLOR;
}

-(void)changeNormalStatu : (UIButton *)button
{
    [button setTitleColor:[ColorUtil colorWithHexString:@"#262626"] forState:UIControlStateNormal];
    button.backgroundColor = [ColorUtil colorWithHexString:@"#aaaaaa"];
}

@end
