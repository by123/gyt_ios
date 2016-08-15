
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
#import "DialogHelper.h"
#import "DealHoldModel.h"
#import "DealHoldByModel.h"
#import "DealProfitModel.h"
#import "QueryRequest.h"
#import "OrderRequestModel.h"
#import "MoneyDetailModel.h"
#import "ByListDialog.h"
#import "ContractDB.h"
#import "DealHoldingModel.h"
#import "PushDataModel.h"
#import "CloseView.h"

typedef NS_ENUM(NSInteger,PriceType)
{
    //对手价
    Rival = 0,
    //市价
    Market,
    //最新价
    Lastest,
    //限价
    Limit,
    //手动输入
    HandIn
};


@interface DealView()

//权益
@property (strong, nonatomic) UILabel *rightLabel;

//可用资金
@property (strong, nonatomic) UILabel *canUseLabel;

//使用率
@property (strong, nonatomic) UILabel *userPercentLabel;

//价格显示区
@property (strong, nonatomic) UIView *priceView;

//最新价
@property (strong, nonatomic) UILabel *currentPriceLabel;

//最新购买量
@property (strong, nonatomic) UILabel *currentCountLabel;

//买价
@property (strong, nonatomic) UILabel *buyPriceLabel;

//买量
@property (strong, nonatomic) UILabel *buyCountLabel;

//卖价
@property (strong, nonatomic) UILabel *sellPriceLabel;

//卖量
@property (strong, nonatomic) UILabel *sellCountLabel;

//自选合约
@property (strong, nonatomic) UIButton *nameButton;

//买入按钮
@property (strong, nonatomic) UIButton *buyItem;

//卖出按钮
@property (strong, nonatomic) UIButton *sellItem;

//手数
@property (strong, nonatomic) ByTextField *handTextField;

//增加手数
@property (strong, nonatomic) UIButton *addHandBtn;

//减少手数
@property (strong, nonatomic) UIButton *reduceHandBtn;

//增加一个tick价格
@property (strong, nonatomic) UIButton *addPriceBtn;

//减少一个tick价格
@property (strong, nonatomic) UIButton *reducePriceBtn;

//价格按钮
@property (strong, nonatomic) UIButton *priceButton;

//价格
@property (strong, nonatomic) UILabel *priceLabel;

//自定义价格框
@property (strong, nonatomic) ByTextField *myTextField;

//最小变动
//@property (strong, nonatomic) UILabel *perLabel;

//持仓，挂单，委托，成交 标题
@property (strong, nonatomic) ByTabView *tabView;

//持仓，挂单，委托，成交
//@property (strong, nonatomic) ByDynamicTableView *dynamicView;
@property (strong, nonatomic) ByDynamicTableView *holdTableView;
@property (strong, nonatomic) ByDynamicTableView *holdingTableView;
@property (strong, nonatomic) ByDynamicTableView *holdByTableView;
@property (strong, nonatomic) ByDynamicTableView *dealTableView;



//数据
@property (strong, nonatomic) PushModel *model;

@property (strong, nonatomic) NSMutableArray *datas;

@property (assign, nonatomic) NSInteger position;

@property (strong, nonatomic) MoneyDetailModel *moneyModel;

@property (strong, nonatomic) UIView *rootView;

//扩展view
@property (strong, nonatomic) UIView *expandView;

@property (strong, nonatomic) UIButton *handReverseBtn;

@property (strong, nonatomic) UIButton *conditionBtn;


@end

@implementation DealView
{
    NSMutableArray *holdDatas;
    NSMutableArray *holdingDatas;
    NSMutableArray *holdByDatas;
    NSMutableArray *holdProfileDatas;
    DealHoldModel *currentModel;
    NSInteger currentItemSelect;
    NSInteger currentTabSelect;
    EEntrustBS director;
    Boolean isExpandView;
    PriceType priceType;
}

-(instancetype)initWithData : (CGRect)frame
                      datas : (NSMutableArray *)datas
                      model : (PushModel *)model
                       view : (UIView *)rootView
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _model = model;
        _datas = datas;
        _rootView = rootView;
        holdDatas = [[NSMutableArray alloc]init];
        holdingDatas = [[NSMutableArray alloc]init];
        holdByDatas = [[NSMutableArray alloc]init];
        holdProfileDatas = [[NSMutableArray alloc]init];
        NSString *moneyDetailStr = [[NSUserDefaults standardUserDefaults] objectForKey:MoneyInfo];
        _moneyModel = [MoneyDetailModel mj_objectWithKeyValues:moneyDetailStr];
        priceType = Rival;
        [self initView];
        return self;
    }
    return nil;
}

#pragma mark 初始化

-(void)initView
{
    self.backgroundColor = BACKGROUND_COLOR;
    currentItemSelect= -1;
    currentModel = [[DealHoldModel alloc]init];
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
    _rightLabel.text = [NSString stringWithFormat:@"权益：%.f",_moneyModel.m_dCurBalance];
    _rightLabel.font = [UIFont systemFontOfSize:13.0f];
    _rightLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_rightLabel];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor blackColor];
    line1.frame = CGRectMake(SCREEN_WIDTH/3, 0, 0.5, 25);
    [view addSubview:line1];
    
    _canUseLabel = [[UILabel alloc]init];
    _canUseLabel.textColor = TEXT_COLOR;
    _canUseLabel.text = [NSString stringWithFormat:@"可用：%.f",_moneyModel.m_dAvailable];
    _canUseLabel.font = [UIFont systemFontOfSize:13.0f];
    _canUseLabel.frame = CGRectMake(SCREEN_WIDTH/3 + 5, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_canUseLabel];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor blackColor];
    line2.frame = CGRectMake(SCREEN_WIDTH * 2/3, 0, 0.5, 25);
    [view addSubview:line2];

    _userPercentLabel = [[UILabel alloc]init];
    _userPercentLabel.textColor = TEXT_COLOR;
    _userPercentLabel.text = [NSString stringWithFormat:@"总权益:%.f",_moneyModel.m_dBalance];
    _userPercentLabel.font = [UIFont systemFontOfSize:13.0f];
    _userPercentLabel.frame = CGRectMake(SCREEN_WIDTH * 2/3 + 5, 0, SCREEN_WIDTH/3-5, 25);
    [view addSubview:_userPercentLabel];
    
    //名称
    _nameButton = [[UIButton alloc]init];
    [_nameButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _nameButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _nameButton.layer.borderWidth = 0.5;
    _nameButton.layer.cornerRadius = 2;
    _nameButton.layer.masksToBounds = YES;
    [_nameButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_nameButton setTitle:_model.m_strInstrumentID forState:UIControlStateNormal];
    _nameButton.frame = CGRectMake(10, view.height+5, SCREEN_WIDTH/2, 30);
    [_nameButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nameButton];
    
    
    //手数
    _handTextField = [[ByTextField alloc]initWithType:NumberInt frame:CGRectMake(10,  _nameButton.y + _nameButton.height +5, _nameButton.width/2 + 10, 30) rootView:_rootView title:@"手数："];
    [_handTextField setTextFiledText:@"1"];
    [self addSubview:_handTextField];
    
    
    //增加手数
    _addHandBtn = [[UIButton alloc]init];
    _addHandBtn.frame = CGRectMake(_handTextField.x+_handTextField.width + 5, _handTextField.y, 30, 30);
    [_addHandBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addHandBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addHandBtn.layer.masksToBounds = YES;
    _addHandBtn.layer.cornerRadius = 4;
    _addHandBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _addHandBtn.backgroundColor = SELECT_COLOR;
    [_addHandBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addHandBtn];
    
    //减少手数
    _reduceHandBtn = [[UIButton alloc]init];
    _reduceHandBtn.frame = CGRectMake(_addHandBtn.x+_addHandBtn.width + 5, _handTextField.y, 30, 30);
    [_reduceHandBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reduceHandBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reduceHandBtn.layer.masksToBounds = YES;
    _reduceHandBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reduceHandBtn.layer.cornerRadius = 4;
    _reduceHandBtn.backgroundColor = SELECT_COLOR;
    [_reduceHandBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceHandBtn];
    
    //价格
    _priceButton = [[UIButton alloc]init];
    [_priceButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _priceButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _priceButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _priceButton.layer.borderWidth = 0.5;
    _priceButton.layer.cornerRadius = 2;
    _priceButton.layer.masksToBounds = YES;
    [_priceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    _priceButton.frame = CGRectMake(10 , _handTextField.y + _handTextField.height +5, _nameButton.width/2 +10, 30);
    [_priceButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_priceButton];

    
    UILabel *priceTitleLabel = [[UILabel alloc]init];
    priceTitleLabel.text = @"价格:";
    priceTitleLabel.textColor = TEXT_COLOR;
    priceTitleLabel.font = [UIFont systemFontOfSize:13.0f];
    priceTitleLabel.textAlignment = NSTextAlignmentCenter;
    priceTitleLabel.frame = CGRectMake(5, 0, priceTitleLabel.contentSize.width, 30);
    [_priceButton addSubview:priceTitleLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.text = @"对手价";
    _priceLabel.textColor = TEXT_COLOR;
    _priceLabel.font = [UIFont systemFontOfSize:13.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.frame = CGRectMake(0, 0, _nameButton.width/2-5, 30);
    [_priceButton addSubview:_priceLabel];
    
    //自定义价格
    _myTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(_priceButton.x + _priceButton.width + 5,  _handTextField.y + _handTextField.height +5, _nameButton.width/2 , 30) rootView:_rootView title:nil];
    [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
    __weak DealView *weakSelf = self;
    _myTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        priceType = HandIn;
        weakSelf.priceLabel.text = @"限价";
        double value = [text doubleValue];
        [weakSelf isValidPrice:value];
        [weakSelf updateBuySellBtn:value sell:value];
    };
    [self addSubview:_myTextField];
    
    //增加价格
    _addPriceBtn = [[UIButton alloc]init];
    _addPriceBtn.frame = CGRectMake(_myTextField.x+_myTextField.width + 5, _priceButton.y, 30, 30);
    [_addPriceBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addPriceBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _addPriceBtn.layer.masksToBounds = YES;
    _addPriceBtn.layer.cornerRadius = 4;
    _addPriceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _addPriceBtn.backgroundColor = SELECT_COLOR;
    [_addPriceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addPriceBtn];
    
    //减少手数
    _reducePriceBtn = [[UIButton alloc]init];
    _reducePriceBtn.frame = CGRectMake(_addPriceBtn.x+_addPriceBtn.width + 5, _priceButton.y, 30, 30);
    [_reducePriceBtn setTitle:@"－" forState:UIControlStateNormal];
    [_reducePriceBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _reducePriceBtn.layer.masksToBounds = YES;
    _reducePriceBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _reducePriceBtn.layer.cornerRadius = 4;
    _reducePriceBtn.backgroundColor = SELECT_COLOR;
    [_reducePriceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reducePriceBtn];
    
    
//    _perLabel = [[UILabel alloc]init];
//    _perLabel.text = [NSString stringWithFormat:@"最小变动:%.2f",_model.m_dPriceTick];
//    _perLabel.textColor = TEXT_COLOR;
//    _perLabel.font =[UIFont systemFontOfSize:13.0f];
//    _perLabel.textAlignment = NSTextAlignmentCenter;
//    _perLabel.frame = CGRectMake(_myTextField.x + _myTextField.width + 5, _addHandBtn.y + _addHandBtn.height + 5, _perLabel.contentSize.width, 30);
//    [_perLabel setHidden:YES];
//    [self addSubview:_perLabel];
    
    
    _priceView = [[UIView alloc]init];
    _priceView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];;
    _priceView.frame = CGRectMake(_nameButton.x + _nameButton.width+5 , view.height + 5, SCREEN_WIDTH - 15 - _nameButton.width, 65);
    _priceView.layer.cornerRadius = 4;
    _priceView.layer.masksToBounds = YES;
    [self addSubview:_priceView];
    
    _currentPriceLabel = [[UILabel alloc]init];
    _currentPriceLabel.textColor = TEXT_COLOR;
    _currentPriceLabel.text = [NSString stringWithFormat:@"新:%.2f",_model.m_dLastPrice];
    _currentPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _currentPriceLabel.frame = CGRectMake(5, 2.5, _currentPriceLabel.contentSize.width, 20);
    [_priceView addSubview:_currentPriceLabel];
    
    _currentCountLabel = [[UILabel alloc]init];
    _currentCountLabel.textColor = TEXT_COLOR;
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nVolume];
    _currentCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _currentCountLabel.frame = CGRectMake(_priceView.size.width - _currentCountLabel.contentSize.width-5, 2.5, _currentPriceLabel.contentSize.width, 20);
    [_priceView addSubview:_currentCountLabel];
    
    _buyPriceLabel = [[UILabel alloc]init];
    _buyPriceLabel.textColor = TEXT_COLOR;
    _buyPriceLabel.text = [NSString stringWithFormat:@"买:%.2f",_model.m_dBidPrice1];
    _buyPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _buyPriceLabel.frame = CGRectMake(5, 22.5, _buyPriceLabel.contentSize.width, 20);
    [_priceView addSubview:_buyPriceLabel];
    
    _buyCountLabel = [[UILabel alloc]init];
    _buyCountLabel.textColor = TEXT_COLOR;
    _buyCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nBidVolume1];
    _buyCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _buyCountLabel.frame = CGRectMake(_priceView.size.width - _buyCountLabel.contentSize.width-5, 22.5, _buyCountLabel.contentSize.width, 20);
    [_priceView addSubview:_buyCountLabel];
    
    _sellPriceLabel = [[UILabel alloc]init];
    _sellPriceLabel.textColor = TEXT_COLOR;
    _sellPriceLabel.text = [NSString stringWithFormat:@"卖:%.2f",_model.m_dAskPrice1];
    _sellPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _sellPriceLabel.frame = CGRectMake(5, 42.5, _sellPriceLabel.contentSize.width, 20);
    [_priceView addSubview:_sellPriceLabel];
    
    _sellCountLabel = [[UILabel alloc]init];
    _sellCountLabel.textColor = TEXT_COLOR;
    _sellCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nAskVolume1];;
    _sellCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _sellCountLabel.frame = CGRectMake(_priceView.size.width - _sellCountLabel.contentSize.width-5, 42.5, _sellCountLabel.contentSize.width, 20);
    [_priceView addSubview:_sellCountLabel];

    
    _buyItem = [[UIButton alloc]init];
    _buyItem.frame = CGRectMake(10, _priceButton.y + _priceButton.height + 10, (SCREEN_WIDTH - 30)/2, 60);
    _buyItem.layer.masksToBounds = YES;
    _buyItem.layer.cornerRadius = 4;
    
    NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",_model.m_dAskPrice1];
    [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
    [_buyItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _buyItem.titleLabel.numberOfLines = 0;
    _buyItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _buyItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _buyItem.backgroundColor = [ColorUtil colorWithHexString:@"#CD5555"];
    [_buyItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buyItem];
    
    _sellItem = [[UIButton alloc]init];
    _sellItem.frame = CGRectMake(10 * 2 + (SCREEN_WIDTH - 30)/2, _priceButton.y + _priceButton.height + 10, (SCREEN_WIDTH - 30)/2, 60);
    _sellItem.layer.masksToBounds = YES;
    _sellItem.layer.cornerRadius = 4;


    NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",_model.m_dBidPrice1];
    [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
    [_sellItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sellItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _sellItem.titleLabel.numberOfLines = 0;
    _sellItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sellItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _sellItem.backgroundColor = [ColorUtil colorWithHexString:@"#2E8B57"];
    [_sellItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_sellItem];
    
}



-(void)initBottomView
{
    NSArray *array = @[@"持仓",@"挂单",@"委托",@"成交"];
    CGRect rect = CGRectMake(0, _sellItem.y + _sellItem.height+10, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self addSubview:_tabView];
    
    [self initHoldData];
    [self initHoldingData];
    [self initHoldByData];
    [self initDealData];
    
    [self showTableView:Hold];
    
    [self requestQuery:XT_CPositionStatics];

}


#pragma mark 持仓数据
-(void)initHoldData
{
    if(_holdTableView == nil)
    {
        NSArray *titleArray = @[@"合约号",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈",@"保证金",@"今手数"];
        NSArray *widthArray = @[@"2",@"1",@"1",@"1",@"2",@"2",@"2",@"1"];
       
         _holdTableView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH , SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdDatas maxWidth:SCREEN_WIDTH * 1.5 type:Hold];
        [_holdTableView setHeaders:widthArray headers:titleArray];
        
        _expandView = [[UIView alloc]init];
        _expandView.backgroundColor = SELECT_COLOR;
        _expandView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 1.5, 40);
        
        _conditionBtn = [[UIButton alloc]init];
        _conditionBtn.frame = CGRectMake(SCREEN_WIDTH - 130, 4, 60, 32);
        _conditionBtn.layer.masksToBounds = YES;
        _conditionBtn.layer.cornerRadius = 4;
        _conditionBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_conditionBtn setTitle:@"止损止盈" forState:UIControlStateNormal];
        [_conditionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _conditionBtn.backgroundColor = TEXT_COLOR;
        [_conditionBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_expandView addSubview:_conditionBtn];
        
        _handReverseBtn = [[UIButton alloc]init];
        _handReverseBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 4, 60, 32);
        _handReverseBtn.layer.masksToBounds = YES;
        _handReverseBtn.layer.cornerRadius = 4;
        _handReverseBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_handReverseBtn setTitle:@"反手" forState:UIControlStateNormal];
        [_handReverseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _handReverseBtn.backgroundColor = TEXT_COLOR;
        [_handReverseBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_expandView addSubview:_handReverseBtn];
        
        
        _holdTableView.delegate = self;
//        _holdTableView.expandView = _expandView;
        [self addSubview:_holdTableView];
    }
}


#pragma mark 挂单数据
-(void)initHoldingData
{
    NSArray *titleArray = @[@"时间",@"合约",@"状态",@"买卖",@"委托价",@"委托量",@"可撤",@"已成交",@"投保",@"预止损",@"合同号",@"主场号"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    if(_holdingTableView == nil)
    {
        _holdingTableView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdingDatas maxWidth:SCREEN_WIDTH*2.5 type:Holding];
        [_holdingTableView setHeaders:widthArray headers:titleArray];
        _holdingTableView.delegate = self;
        [self addSubview:_holdingTableView];
    }
}

#pragma mark 委托数据
-(void)initHoldByData
{
    if(_holdByTableView == nil)
    {
        NSArray *titleArray = @[@"时间",@"合约",@"状态",@"买卖",@"委托价",@"委托量",@"可撤",@"已成交",@"投保",@"合同号",@"主场号"];
        NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        
        _holdByTableView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdByDatas maxWidth:SCREEN_WIDTH * 2 type:HoldBy];
        [_holdByTableView setHeaders:widthArray headers:titleArray];
        _holdByTableView.delegate = self;
        [self addSubview:_holdByTableView];
    }
}

#pragma mark 成交数据
-(void)initDealData
{
    if(_dealTableView == nil)
    {
        NSArray *titleArray = @[@"时间",@"合约",@"买卖",@"成交价",@"成交量",@"合同号",@"主场号"];
        NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        
        _dealTableView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdProfileDatas maxWidth:SCREEN_WIDTH*1.5 type:Profit];
        [_dealTableView setHeaders:widthArray headers:titleArray];
        _dealTableView.delegate = self;
        [self addSubview:_dealTableView];
    }
}


-(void)showTableView : (DealType)type
{
    _holdTableView.hidden = YES;
    _holdingTableView.hidden = YES;
    _holdByTableView.hidden = YES;
    _dealTableView.hidden = YES;
    switch (type) {
        case Hold:
            _holdTableView.hidden = NO;
            break;
        case Holding:
            _holdingTableView.hidden = NO;
            break;
        case HoldBy:
            _holdByTableView.hidden = NO;
            break;
        case Profit:
            _dealTableView.hidden = NO;
            break;
        default:
            break;
    }
}


#pragma mark ----交互块-----

#pragma mark 点击事件处理
-(void)OnClick : (id)sender
{
    UIView *view = sender;
    NSString * hand = [_handTextField getTextFieldText];
    
    if(view == _buyItem)
    {
        double price = [self getRealPrice:_buyItem.titleLabel.text];
        if([self isValidPrice:price])
        {
            if([_buyItem.titleLabel.text myContainsString:@"平仓"])
            {
                director = ENTRUST_BUY;
                NSString *message = [NSString stringWithFormat:@"%@，%.2f，平仓，%@手",_model.m_strInstrumentID,price,hand];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认平仓吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 3;
                [alert show];
            }
            else
            {
                director = ENTRUST_BUY;
                
                NSString *message = [NSString stringWithFormat:@"%@，%.2f，买，%@手",_model.m_strInstrumentID,price,hand];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 0;
                [alert show];
            }
        }
  
    }
    else if(view == _sellItem)
    {
        double price = [self getRealPrice:_sellItem.titleLabel.text];
        if([self isValidPrice:price])
        {
            if([_sellItem.titleLabel.text myContainsString:@"平仓"])
            {
                director = ENTRUST_SELL;
                NSString *message = [NSString stringWithFormat:@"%@，%.2f，平仓，%@手",_model.m_strInstrumentID,price,hand];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认平仓吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 3;
                [alert show];
            }
            else
            {
                director = ENTRUST_SELL;
                
                NSString *message = [NSString stringWithFormat:@"%@，%.2f，卖，%@手",_model.m_strInstrumentID,price,hand];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1;
                [alert show];
            }
        }
    }
    else if(view == _nameButton)
    {
        NSMutableArray *array = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
        if(IS_NS_COLLECTION_EMPTY(array))
        {
            [ByToast showErrorToast:@"您还没有自选合约"];
            return;
        }
        NSMutableArray *temps = [[NSMutableArray alloc]init];
        for(PushModel *model in array)
        {
            [temps addObject:model.m_strInstrumentID];
        }
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:temps title:@"自选合约"];
        dialog.tag = 0;
        dialog.delegate = self;
        [self.rootView addSubview:dialog];
    }
    else if(view == _priceButton)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:@"对手价"];
        [array addObject:@"市价"];
        [array addObject:@"最新价"];
        [array addObject:@"限价"];
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:array title:@"价格"];
        dialog.tag = 1;
        dialog.delegate = self;
        [self.rootView addSubview:dialog];
    }
    else if(view == _handReverseBtn)
    {
        [ByToast showErrorToast:@"开发中"];
    }
    else if(view == _conditionBtn)
    {
        [ByToast showErrorToast:@"开发中"];
    }
    else if(view == _addHandBtn)
    {
        int hand = [[_handTextField getTextFieldText] integerValue];
        hand ++;
        [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
    }
    else if(view == _reduceHandBtn)
    {
        int hand = [[_handTextField getTextFieldText] integerValue];
        if(hand <= 1)
        {
            [ByToast showErrorToast:@"手数不能小于等于0"];
            return;
        }
        hand --;
        [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
    }
    else if(view == _addPriceBtn)
    {
        priceType = HandIn;
        _priceLabel.text = @"限价";
        double price = [[_myTextField getTextFieldText] doubleValue];
        price += _model.m_dPriceTick;
        [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateBuySellBtn:price sell:price];

    }
    else if(view == _reducePriceBtn)
    {
        priceType = HandIn;
        _priceLabel.text = @"限价";
        double price = [[_myTextField getTextFieldText] doubleValue];
        price -= _model.m_dPriceTick;
        [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",price]];
        [self updateBuySellBtn:price sell:price];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        if(alertView.tag == 0 || alertView.tag == 1)
        {
            [self order : nil];
        }
        else if(alertView.tag == 2)
        {
            DealHoldByModel *model = [holdingDatas objectAtIndex:currentItemSelect];
            [self cancelOrder:model];
        }
        else if(alertView.tag == 3)
        {
            [self order : currentModel];
            if(currentTabSelect == 0)
            {
                [_holdTableView performClose];
            }
        }
    }
    
}



#pragma mark 价格选择
-(void)OnListDialogItemClick:(id)data position:(NSInteger)position dialog:(ByListDialog *)dialog
{
    if(dialog.tag == 0)
    {
      [_nameButton setTitle:data forState:UIControlStateNormal];
      currentModel.m_strInstrumentID = data;
      [self updateView];
      [self updateBuySellItem];
    }
    else if(dialog.tag == 1)
    {
        _priceLabel.text = data;
        priceType = position;
        switch (position) {
                //对手价
            case Rival:
                [self updateBuySellBtn:_model.m_dAskPrice1 sell:_model.m_dBidPrice1];
                [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
                break;
                //市价
            case Market:
                [self updateBuySellBtn:_model.m_dLastPrice * 1.1 sell:_model.m_dLastPrice * 0.9];
                [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice * 1.1]];
                break;
                //最新价
            case Lastest:
                [self updateBuySellBtn:_model.m_dLastPrice sell:_model.m_dLastPrice];
                [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice]];
                break;
                //限价
            case Limit:
                [self updateBuySellBtn:0 sell:0];
                [_myTextField setTextFiledText:@"0.00"];
                [_myTextField becomeFocus];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark 刷新按钮
-(void)onRefresh : (UIView *)view
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 5.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self OnSelect:currentTabSelect];
}

#pragma mark tab选中
-(void)OnSelect:(NSInteger)position
{
    [_holdTableView performClose];
    currentTabSelect = position;
    switch (position) {
        case 0:
            [self showTableView:Hold];
            [self requestQuery:XT_CPositionStatics];
            break;
        case 1:
            [self showTableView:Holding];
            [self requestQuery:XT_COrderDetail];
            break;
        case 2:
            [self showTableView:HoldBy];
            [self requestQuery:XT_COrderDetail];
            break;
        case 3:
            [self showTableView:Profit];
            [self requestQuery:XT_CDealDetail];
            break;
        default:
            break;
    }
}

#pragma mark item选中
-(void)OnItemSelected:(UIView *)dynamicTableView position:(NSInteger)position
{
    currentItemSelect = position;
    switch (currentTabSelect) {
        case 0:
            if(!IS_NS_COLLECTION_EMPTY(holdDatas))
            {
                DealHoldModel *model = [holdDatas objectAtIndex:position];
                currentModel = model;
                [self updateView];
                [self updateBuySellItem];
            }
            break;
        case 1:
            if(!IS_NS_COLLECTION_EMPTY(holdingDatas))
            {
                DealHoldingModel *model = [holdingDatas objectAtIndex:position];
                NSString *message = [NSString stringWithFormat:@"%@，委托价：%.2f",model.m_strInstrumentID,model.m_dLimitPrice];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认撤单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 2;
                [alert show];
            }
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    
}


#pragma mark item展开状态
-(void)OnExpandView:(BOOL)isExpand
{
    isExpandView = isExpand;
}


#pragma mark ---数据请求----

#pragma mark 请求持仓，委托，成交
-(void)requestQuery : (RequestType)type
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:type];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:type];
}


#pragma mark 请求下单
-(void)order : (DealHoldModel *)model
{
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    OrderRequestModel *orderModel = [[OrderRequestModel alloc]init];
    orderModel.strSessionID = [[Account sharedAccount]getSessionId];
    orderModel.account = account;
    double hand = [[_handTextField getTextFieldText] doubleValue];
    double price = 0.0f;
    if(model != nil)
    {
        if(hand > model.m_nCanCloseVol)
        {
            [ByToast showErrorToast:@"平仓数量大于可用数量"];
            return;
        }
        //平仓
        if(model.m_nDirection == ENTRUST_BUY)
        {
            model.m_nDirection = ENTRUST_SELL;
            NSString *text = _sellItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
            
        }
        else
        {
            model.m_nDirection = ENTRUST_BUY;
            NSString *text = _buyItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
        }
        orderModel.info = [OrderModel buildOrderModel :model.m_strProductID  instrumentID:model.m_strInstrumentID orderPrice:price orderNum:hand direction:model.m_nDirection offsetFlag:EOFF_THOST_FTDC_OF_Close];
    }
    else
    {
        //下单
        if(director == ENTRUST_BUY)
        {
            NSString *text = _buyItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
        }
        else
        {
            NSString *text = _sellItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
        }
        orderModel.info = [OrderModel buildOrderModel : _model.m_strProductID instrumentID:_model.m_strInstrumentID  orderPrice:price orderNum:hand direction:director offsetFlag:EOFF_THOST_FTDC_OF_Open];
    }

    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_ORDER];
    
    NSString *content = [NSString stringWithFormat:@"成功发出委托 %@ %.2f %.f手",_model.m_strInstrumentID,price,hand];
    [ByToast showWarnToast:content];
    
}


#pragma mark 撤单
-(void)cancelOrder : (DealHoldByModel *)order
{
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    
    OrderRequestModel *orderModel = [[OrderRequestModel alloc]init];
    orderModel.strSessionID = [[Account sharedAccount]getSessionId];
    orderModel.account = account;
    orderModel.order = (OrderModel *)order;
    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"cancel" params:dic];
    
    NSLog(@"数据->%@",jsonStr);
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_CANCEL];
    
    [ByToast showWarnToast:@"发出撤单申请"];

}


#pragma mark 处理持仓数据
-(void)handlePositionStaticsData : (BaseRespondModel *)respondModel
{
    [holdDatas removeAllObjects];
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    NSMutableArray *array = model.datas;
    if(!IS_NS_COLLECTION_EMPTY(array))
    {
        for(id obj in array)
        {
            DealHoldModel *holdModel = [DealHoldModel mj_objectWithKeyValues:obj];
            if(holdModel.m_nOpenVolume != 0)
            {
                [holdDatas insertObject:holdModel atIndex:0];
            }
        }
        [self reloadData:holdDatas type:Hold];
    }
}

#pragma mark 处理挂单和委托数据
-(void)handleOrderDetailData: (BaseRespondModel *)respondModel
{
    NSLog(@"结果->%@",[respondModel mj_JSONString]);
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    NSMutableArray *array = model.datas;
    if(!IS_NS_COLLECTION_EMPTY(array))
    {
        if(currentTabSelect == 1)
        {
            [holdingDatas removeAllObjects];
            for(id obj in array)
            {
                DealHoldingModel *holdingModel = [DealHoldingModel mj_objectWithKeyValues:obj];
                OrderTagModel *tagModel = [[OrderTagModel alloc]init];
                tagModel.m_strRealTag = holdingModel.m_strOrderRef;
                holdingModel.m_tag = tagModel;
                if(holdingModel.m_nOrderStatus == ENTRUST_STATUS_REPORTED && [AppUtil getFormatNow] == holdingModel.m_nInsertDate)
                {
                    [holdingDatas insertObject:holdingModel atIndex:0];
                }
            }
            [self reloadData:holdingDatas type:Holding];
        }
        else if(currentTabSelect == 2)
        {
            [holdByDatas removeAllObjects];
            for(id obj in array)
            {
                DealHoldByModel *holdByModel = [DealHoldByModel mj_objectWithKeyValues:obj];
                OrderTagModel *tagModel = [[OrderTagModel alloc]init];
                tagModel.m_strRealTag = holdByModel.m_strOrderRef;
                holdByModel.m_tag = tagModel;
                
                if([AppUtil getFormatNow] == holdByModel.m_nInsertDate)
                {
                    [holdByDatas insertObject:holdByModel atIndex:0];
                }
                
            }
            [self reloadData:holdByDatas type:HoldBy];
        }
    }
}


#pragma mark 处理成交数据
-(void)handleDealDetailData : (BaseRespondModel *)respondModel
{
    [holdProfileDatas removeAllObjects];
    QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
    NSMutableArray *array = model.datas;
    if(!IS_NS_COLLECTION_EMPTY(array))
    {
        for(id obj in array)
        {
            DealProfitModel *profitModel = [DealProfitModel mj_objectWithKeyValues:obj];
            if([AppUtil getFormatNow] == profitModel.m_strTradeDate)
            {
                [holdProfileDatas insertObject:profitModel atIndex:0];
            }
        }
        [self reloadData:holdProfileDatas type:Profit];
    }
}

#pragma mark 处理下单数据
-(void)handleOrderData : (BaseRespondModel *)respondModel
{
    
}

#pragma mark 处理撤单数据
-(void)handleCancelData : (BaseRespondModel *)respondModel
{
    [ByToast showNormalToast:@"撤单申请成功"];
}

#pragma mark 处理主推数据
-(void)handlePushData:(PackageModel *)packageModel
{
    [[PushDataHandle sharedPushDataHandle] handlePushData:packageModel.result delegate :self];

}

#pragma mark 处理主推数据
-(void)handlePushQuoteData:(PackageModel *)packageModel
{
    [[PushDataHandle sharedPushDataHandle] handlePushData:packageModel.result delegate :self];
}


-(void)pushResult:(id)data
{
    if([data isKindOfClass:[DealHoldByModel class]])
    {
        NSLog(@"#############委托变化#############");
        if(currentTabSelect == 1)
        {
            Boolean hasModel = NO;
            DealHoldingModel *model = data;
            for(int i = 0; i < [holdingDatas count]; i++)
            {
                DealHoldingModel *temp = [holdingDatas objectAtIndex:i];
                if([temp.m_strOrderRef isEqualToString:model.m_strOrderRef])
                {
                    temp.m_nOrderStatus = model.m_nOrderStatus;
                    hasModel = YES;
                    if(temp.m_nOrderStatus == ENTRUST_STATUS_CANCELED)
                    {
                        [holdingDatas removeObjectAtIndex:i];
                    }
                    break;
                }
                
            }
            if(!hasModel)
            {
                OrderTagModel *tagModel = [[OrderTagModel alloc]init];
                tagModel.m_strRealTag = model.m_strOrderRef;
                model.m_tag = tagModel;
                [holdingDatas insertObject:model atIndex:0];
            }
            [self reloadData:holdingDatas type:Holding];
        }
        else if(currentTabSelect == 2)
        {
            Boolean hasModel = NO;
            DealHoldByModel *model = data;
            for(int i = 0; i < [holdByDatas count]; i++)
            {
                DealHoldByModel *temp = [holdByDatas objectAtIndex:i];
                if([temp.m_strOrderRef isEqualToString:model.m_strOrderRef])
                {
                    temp.m_nOrderStatus = model.m_nOrderStatus;
                    hasModel = YES;
                }
            }
            if(!hasModel)
            {
                [holdByDatas insertObject:model atIndex:0];
            }
            [self reloadData:holdByDatas type:HoldBy];

        }

    }
    else if([data isKindOfClass:[DealProfitModel class]])
    {
        NSLog(@"#############成交变化#############");
        DealProfitModel *model = data;
        [holdProfileDatas insertObject:model atIndex:0];
        [self reloadData:holdProfileDatas type:Profit];
        NSString *content = [NSString stringWithFormat:@"委托已成交 %@ %.2f %d手",model.m_strInstrumentID,model.m_dPrice,model.m_nVolume];
        [ByToast showNormalToast:content];
    }
    else if([data isKindOfClass:[DealHoldModel class]])
    {
        NSLog(@"#############持仓变化#############");
        DealHoldModel *model = data;
        
        NSLog(@"持仓手数->%d",model.m_nPosition);
        BOOL hasModel = NO;
        for(int i = 0 ; i < [holdDatas count]; i ++ )
        {
            DealHoldModel *tempModel = [holdDatas objectAtIndex:i];
            if([tempModel.m_strInstrumentID isEqualToString:model.m_strInstrumentID] )
            {
                hasModel = YES;
                if(model.m_nPosition != 0)
                {
                    [holdDatas replaceObjectAtIndex:i withObject:model];
                }
                else
                {
                    if([currentModel.m_strInstrumentID isEqualToString:tempModel.m_strInstrumentID])
                    {
                        //by测试观察
                        currentModel = nil;
                    }
                    [holdDatas removeObjectAtIndex:i];
                }
                break;
            }
        }
        if(!hasModel)
        {
            [holdDatas addObject:model];
        }
        [self reloadData:holdDatas type:Hold];

    }
    else if([data isKindOfClass:[PushModel class]])
    {
//        NSLog(@"#############行情变化#############");
        PushModel *model = data;
//        [self updateUpDown : model];
        if([model.m_strInstrumentID isEqualToString:_model.m_strInstrumentID])
        {
            _model.m_dLastPrice = model.m_dLastPrice;
            _model.m_dOpenPrice = model.m_dOpenPrice;
            _model.m_nVolume = model.m_nVolume;
            _model.m_dAskPrice1 = model.m_dAskPrice1;
            _model.m_dBidPrice1 = model.m_dBidPrice1;
            _model.m_dHighestPrice = model.m_dHighestPrice;
            _model.m_dLowestPrice = model.m_dLowestPrice;
            _model.m_nAskVolume1 = model.m_nAskVolume1;
            _model.m_nBidVolume1 = model.m_nBidVolume1;
            
            [self updateView];
            [self updateBuySellItem];
            
            
        }
    }
    else if([data isKindOfClass:[MoneyDetailModel class]])
    {
        MoneyDetailModel *model = data;
        [[NSUserDefaults standardUserDefaults]setValue:model.mj_JSONString forKey:MoneyInfo];
        _rightLabel.text = [NSString stringWithFormat:@"权益：%.f",model.m_dCurBalance];
        _canUseLabel.text = [NSString stringWithFormat:@"可用：%.f",model.m_dAvailable];
    }

}



#pragma mark ----UI更新-----

#pragma mark 更新数据
-(void)reloadData : (NSMutableArray *)data
             type : (DealType) type
{
//    if(!IS_NS_COLLECTION_EMPTY(data))
//    {
        if(type == Hold && currentTabSelect == 0)
        {
            [_holdTableView reloadData:data position:currentItemSelect];
        }
        else if(type == Holding && currentTabSelect == 1)
        {
            [_holdingTableView reloadData:data position:currentItemSelect];
        }
        else if(type == HoldBy && currentTabSelect == 2)
        {
            [_holdByTableView reloadData:data position:currentItemSelect];
        }
        else if(type == Profit && currentTabSelect == 3)
        {
            [_dealTableView reloadData:data position:currentItemSelect];
        }
//    }
 
}


#pragma mark 更新买卖按钮
-(void)updateBuySellBtn : (double)buyPrice
                   sell : (double )sellPrice
{
    NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",buyPrice];
    NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",sellPrice];
//    if(isExpandView)
//    {
        double tempBuyPrice = 0.0f;
        double tempSellPrice = 0.0f;
        switch (priceType) {
            case Rival:
                tempBuyPrice = _model.m_dAskPrice1;
                tempSellPrice = _model.m_dBidPrice1;
                break;
            case Lastest:
                tempBuyPrice = _model.m_dLastPrice;
                tempSellPrice = _model.m_dLastPrice;
                break;
            case Market:
                tempBuyPrice = _model.m_dLastPrice * 1.1;
                tempSellPrice = _model.m_dLastPrice * 0.9;
                break;
            case Limit:
                tempBuyPrice = [[_myTextField getTextFieldText] doubleValue];
                tempSellPrice = [[_myTextField getTextFieldText] doubleValue];
                break;
            case HandIn:
                tempBuyPrice = [[_myTextField getTextFieldText] doubleValue];
                tempSellPrice = [[_myTextField getTextFieldText] doubleValue];
                break;
            default:
                break;
        }
        int direction = currentModel.m_nDirection;
            switch (direction) {
                case ENTRUST_BUY:
                    sellTxt=[NSString stringWithFormat:@"%.2f\n—————————\n平仓",tempSellPrice];
                    break;
                case ENTRUST_SELL:
                    buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n平仓",tempBuyPrice] ;
                    break;
                default:
                    break;
            }
//    }
    [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
    [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
}


#pragma mark 更新交易面板
-(void)updateView
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        for(PushModel *model in _datas)
        {
            if([model.m_strInstrumentID isEqualToString:currentModel.m_strInstrumentID])
            {
                _model = model;
                break;
            }
        }
    }
    //更新合约id
    [_nameButton setTitle:_model.m_strInstrumentID forState:UIControlStateNormal];
    
    //更新价格
    int width = _priceView.size.width;
    _currentPriceLabel.text = [NSString stringWithFormat:@"新:%.2f",_model.m_dLastPrice];
    _currentPriceLabel.frame = CGRectMake(5, 2.5,(width - 10)/2+10, 20);
    
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nVolume];
    _currentCountLabel.textAlignment = NSTextAlignmentRight;
    _currentCountLabel.frame = CGRectMake(width/2, 2.5, width/2, 20);
    
    _buyPriceLabel.text = [NSString stringWithFormat:@"买:%.2f",_model.m_dBidPrice1];
    _buyPriceLabel.frame = CGRectMake(5, 22.5, (width - 10)/2+10, 20);
    
    
    _buyCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nBidVolume1];
    _buyCountLabel.textAlignment = NSTextAlignmentRight;
    _buyCountLabel.frame = CGRectMake(width/2, 22.5, width/2, 20);
    
    _sellPriceLabel.text = [NSString stringWithFormat:@"卖:%.2f",_model.m_dAskPrice1];
    _sellPriceLabel.frame = CGRectMake(5, 42.5, (width - 10)/2+10, 20);
    
    _sellCountLabel.text = [NSString stringWithFormat:@"%d",_model.m_nAskVolume1];
    _sellCountLabel.textAlignment = NSTextAlignmentRight;
    _sellCountLabel.frame = CGRectMake(width/2, 42.5, width/2, 20);
    
}

#pragma mark 更新浮动盈亏(弃用)
//-(void)updateUpDown : (PushModel *)model
//{
//    if(!IS_NS_COLLECTION_EMPTY(holdDatas))
//    {
//        for(DealHoldModel *holdModel in holdDatas)
//        {
//            if([model.m_strInstrumentID isEqualToString:holdModel.m_strInstrumentID] && model.m_dLastPrice != holdModel.m_dLastPrice)
//            {
//                holdModel.m_dLastPrice = model.m_dLastPrice;
//                [_holdTableView reloadData:holdDatas position:currentItemSelect];
//                break;
//            }
//        }
//    }
//}


#pragma mark 根据选择价格类型，更新买入卖出按钮价格
-(void)updateBuySellItem
{
    double price = [[_myTextField getTextFieldText]doubleValue];
    switch (priceType) {
        case Lastest:
            [self updateBuySellBtn:_model.m_dLastPrice sell:_model.m_dLastPrice];
            [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice]];
            break;
        case Rival:
            [self updateBuySellBtn:_model.m_dAskPrice1 sell:_model.m_dBidPrice1];
            [_myTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1]];
            break;
        case Market:
            [self updateBuySellBtn:_model.m_dLastPrice * 1.1 sell:_model.m_dLastPrice * 0.9];
            break;
        case Limit:
            [self updateBuySellBtn:price sell:price];
            break;
        case HandIn:
            [self updateBuySellBtn:price sell:price];
            break;
        default:
            break;
    }

 
}



#pragma mark -----功能块-------

#pragma mark 价格设置是否合理
-(Boolean)isValidPrice : (double)price
{
    int tempPrice = (int) (price * 100);
    int tempPrice1 = (int) (_model.m_dPriceTick * 100);
    if (fmod(tempPrice, tempPrice1) == 0)
    {
        return YES;
    }
    [ByToast showErrorToast:@"价格设置不是最小变动的整数倍"];
    return NO;

}

#pragma mark 获得当前的实际价格
-(double)getRealPrice : (NSString *)text
{
    NSRange range;
    range.location = 0;
    range.length = text.length - 11;
    double price = [[text substringWithRange:range] doubleValue];
    return price;
}

@end
