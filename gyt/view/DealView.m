
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

//价格按钮
@property (strong, nonatomic) UIButton *priceButton;

//价格
@property (strong, nonatomic) UILabel *priceLabel;

//自定义价格框
@property (strong, nonatomic) ByTextField *myTextField;

//最小变动
@property (strong, nonatomic) UILabel *perLabel;

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
    //停止价格联动
    Boolean stopChange;
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

        [self initView];
        return self;
    }
    return nil;
}

#pragma mark 初始化

-(void)initView
{
    self.backgroundColor = BACKGROUND_COLOR;
    currentItemSelect= 0;
    currentModel = [[DealHoldModel alloc]init];
    [self initTopView];
    [self initBottomView];
//    [self requestQuery:XT_CPositionStatics];

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
    _userPercentLabel.text = @"使用率: 0.01%";
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
    [_myTextField setTextFiledText:@"0"];
    __weak DealView *weakSelf = self;
    _myTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        NSString *buyTxt =[NSString stringWithFormat:@"%@\n—————————\n买入",text];
        NSString *sellTxt = [NSString stringWithFormat:@"%@\n—————————\n卖出",text];
        [weakSelf.buyItem setTitle:buyTxt forState:UIControlStateNormal];
        [weakSelf.sellItem setTitle:sellTxt forState:UIControlStateNormal];
    };
    [_myTextField setHidden:YES];
    [self addSubview:_myTextField];
    
    
    _perLabel = [[UILabel alloc]init];
    _perLabel.text = [NSString stringWithFormat:@"最小变动:%.2f",_model.m_dPriceTick];
    _perLabel.textColor = TEXT_COLOR;
    _perLabel.font =[UIFont systemFontOfSize:13.0f];
    _perLabel.textAlignment = NSTextAlignmentCenter;
    _perLabel.frame = CGRectMake(_myTextField.x + _myTextField.width + 5, _addHandBtn.y + _addHandBtn.height + 5, _perLabel.contentSize.width, 30);
    [_perLabel setHidden:YES];
    [self addSubview:_perLabel];
    
    
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


-(void)OnExpandView:(BOOL)isExpand
{
    isExpandView = isExpand;
    [self updateDealView];
}


#pragma mark 点击合约，更新交易面板
-(void)updateDealView
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
    
    //更新买入，平仓按钮
    if(!stopChange)
    {
        NSString *sellTxt;
        NSString *buyTxt;
        if(currentModel &&isExpandView)
        {
            if(currentModel.m_nDirection == ENTRUST_BUY){
                buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",_model.m_dAskPrice1];
                sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n平仓",_model.m_dBidPrice1];
            }
            else{
                buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n平仓",_model.m_dAskPrice1];
                sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",_model.m_dBidPrice1];
            }
        }
        else{
            buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",_model.m_dAskPrice1];
            sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",_model.m_dBidPrice1];
        }
        [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
        [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
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


    //
}


#pragma mark 持仓数据
-(void)initHoldData
{
    if(_holdTableView == nil)
    {
        NSArray *titleArray = @[@"合约号",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈",@"保证金",@"今手数"];
        NSArray *widthArray = @[@"2",@"1",@"1",@"1",@"2",@"2",@"1",@"1"];
       
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
        _holdTableView.expandView = _expandView;
        [self addSubview:_holdTableView];
    }
}


-(void)OnItemSelected:(UIView *)dynamicTableView position:(NSInteger)position
{
    currentItemSelect = position;
    
    switch (currentTabSelect) {
        case 0:
            if(!IS_NS_COLLECTION_EMPTY(holdDatas))
            {
                DealHoldModel *model = [holdDatas objectAtIndex:position];
                currentModel = model;
                [self updateDealView];
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

#pragma mark tabview选择
-(void)OnSelect:(NSInteger)position
{
    [self hideKeyboard];
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

#pragma mark 点击事件处理
-(void)OnClick : (id)sender
{
    UIView *view = sender;
    NSString * hand = [_handTextField getTextFieldText];
    
    if(view == _buyItem)
    {
        NSString *text = _buyItem.titleLabel.text;
        NSRange range;
        range.location = 0;
        range.length = text.length - 11;
        double price = [[text substringWithRange:range] doubleValue];
        
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
//            double price;
//            if(stopChange)
//            {
//                price = _model.m_dLowestPrice;
//            }
//            else
//            {
//                price = _model.m_dAskPrice1;
//            }
            NSString *message = [NSString stringWithFormat:@"%@，%.2f，买，%@手",_model.m_strInstrumentID,price,hand];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 0;
            [alert show];
        }
    }
    else if(view == _sellItem)
    {
        NSString *text = _sellItem.titleLabel.text;
        NSRange range;
        range.location = 0;
        range.length = text.length - 11;
        double price = [[text substringWithRange:range] doubleValue];
        
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
//            double price;
//            if(stopChange)
//            {
//                price = _model.m_dHighestPrice;
//            }
//            else
//            {
//                price = _model.m_dBidPrice1;
//            }
            NSString *message = [NSString stringWithFormat:@"%@，%.2f，卖，%@手",_model.m_strInstrumentID,price,hand];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 1;
            [alert show];
        }
    }
    else if(view == _nameButton)
    {
        NSMutableArray *array = [[ContractDB sharedContractDB] queryAll:DBMyContractTable];
        if(IS_NS_COLLECTION_EMPTY(array))
        {
            [DialogHelper showTips:@"您还没有自选合约"];
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
        [array addObject:@"自定义"];
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:array title:@"价格"];
        dialog.tag = 1;
        dialog.delegate = self;
        [self.rootView addSubview:dialog];
    }
    else if(view == _handReverseBtn)
    {
        [DialogHelper showTips:@"开发中"];
    }
    else if(view == _conditionBtn)
    {
        [DialogHelper showTips:@"开发中"];
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
            [DialogHelper showTips:@"手数不能小于等于0"];
            return;
        }
        hand --;
        [_handTextField setTextFiledText:[NSString stringWithFormat:@"%d",hand]];
    }
    
    [self hideKeyboard];
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
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

-(void)hideKeyboard
{
    [_handTextField resignFirstResponder];
}


-(void)OnListDialogItemClick:(id)data dialog:(ByListDialog *)dialog
{
    if(dialog.tag == 0)
    {
      [_nameButton setTitle:data forState:UIControlStateNormal];
      currentModel.m_strInstrumentID = data;
      [self updateDealView];
    }
    else if(dialog.tag == 1)
    {
        _priceLabel.text = data;
        NSString *sellTxt;
        NSString *buyTxt;
        if([data isEqualToString:@"对手价"])
        {
            stopChange = NO;
            buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",_model.m_dAskPrice1];
            sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",_model.m_dBidPrice1];
            [_myTextField setHidden:YES];
            [_perLabel setHidden:YES];
        }
        else if ([data isEqualToString:@"市价"])
        {
            stopChange = YES;
            buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",_model.m_dLowestPrice];
            sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",_model.m_dHighestPrice];
            [_myTextField setHidden:YES];
            [_perLabel setHidden:YES];
        }
        else if([data isEqualToString:@"自定义"])
        {
            stopChange = YES;
            buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买入",0.00f];
            sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖出",0.00f];
            [_myTextField setHidden:NO];
            [_perLabel setHidden:NO];
        }
        [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
        [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
    }
}


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
    
    if(model != nil)
    {
        if(hand > model.m_nCanCloseVol)
        {
            [DialogHelper showTips:@"平仓数量大于可用数量"];
            return;
        }
        //平仓
        if(model.m_nDirection == ENTRUST_BUY)
        {
            model.m_nDirection = ENTRUST_SELL;
        }
        else
        {
            model.m_nDirection = ENTRUST_BUY;
        }
        orderModel.info = [OrderModel buildOrderModel :model.m_strProductID  instrumentID:model.m_strInstrumentID orderPrice:model.m_dLastPrice orderNum:hand direction:model.m_nDirection offsetFlag:EOFF_THOST_FTDC_OF_Close];
    }
    else
    {
        double price;
        //下单
        if(director == ENTRUST_BUY)
        {
           
            NSString *text = _buyItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
//            price = _model.m_dAskPrice1;
//            if(stopChange)
//            {
//                price = _model.m_dLowestPrice;
//            }
        }
        else
        {
            NSString *text = _sellItem.titleLabel.text;
            NSRange range;
            range.location = 0;
            range.length = text.length - 11;
            price = [[text substringWithRange:range] doubleValue];
//            price = _model.m_dBidPrice1;
//            if(stopChange)
//            {
//                price = _model.m_dHighestPrice;
//            }
        }
        orderModel.info = [OrderModel buildOrderModel : _model.m_strProductID instrumentID:_model.m_strInstrumentID  orderPrice:price orderNum:hand direction:director offsetFlag:EOFF_THOST_FTDC_OF_Open];
    }

    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_ORDER];
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

}


#pragma mark 接收数据
-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];

    //持仓
    if(packageModel.seq == XT_CPositionStatics && !IS_NS_STRING_EMPTY(packageModel.result))
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
//                    [holdDatas addObject:holdModel];
                }
            }
            [self reloadData:holdDatas];

        }
    }
    //委托
    else if(packageModel.seq == XT_COrderDetail && !IS_NS_STRING_EMPTY(packageModel.result))
    {
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
                    if(holdingModel.m_nOrderStatus == ENTRUST_STATUS_REPORTED)
                    {
//                        [holdingDatas addObject:holdingModel];
                        [holdingDatas insertObject:holdingModel atIndex:0];

                    }
                }
                [self reloadData:holdingDatas];
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
//                    [holdByDatas addObject:holdByModel];
                    
                     [holdByDatas insertObject:holdByModel atIndex:0];

                }
                [self reloadData:holdByDatas];
            }
        }
    }
    //成交
    else if(packageModel.seq == XT_CDealDetail && !IS_NS_STRING_EMPTY(packageModel.result))
    {
        [holdProfileDatas removeAllObjects];
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
            for(id obj in array)
            {
                DealProfitModel *profitModel = [DealProfitModel mj_objectWithKeyValues:obj];
//                [holdProfileDatas addObject:profitModel];
                [holdProfileDatas insertObject:profitModel atIndex:0];

            }
            [self reloadData:holdProfileDatas];
        }
    }
    else if(packageModel.seq == GYT_ORDER)
    {
        
    }
    else if(packageModel.seq == GYT_CANCEL)
    {
        NSLog(@"撤单成功返回->%@",packageModel.result);
        [DialogHelper showSuccessTips:@"提交撤单申请成功"];
    }
    else if(packageModel.cmd == NET_CMD_NOTIFICATION)
    {
        [[PushDataHandle sharedPushDataHandle] handlePushData:packageModel.result delegate :self];
    }
}


-(void)pushResult:(id)data
{
    if([data isKindOfClass:[DealHoldByModel class]])
    {
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
//                    [_holdingTableView reloadOneRow:i];
                }
            }
            if(!hasModel)
            {
//                [holdingDatas addObject:model];
                [holdingDatas insertObject:model atIndex:0];
            }
            [self reloadData:holdingDatas];
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
//                [holdByDatas addObject:model];
                [holdByDatas insertObject:model atIndex:0];

            }
            [self reloadData:holdByDatas];

        }

    }
    else if([data isKindOfClass:[DealProfitModel class]])
    {
        DealProfitModel *model = data;
//        [holdProfileDatas addObject:model];
        [holdProfileDatas insertObject:model atIndex:0];

        [self reloadData:holdProfileDatas];
    }
    else if([data isKindOfClass:[DealHoldModel class]])
    {
        DealHoldModel *model = data;
        for(DealHoldModel *tempModel in holdDatas)
        {
            if([tempModel.m_strInstrumentID isEqualToString:model.m_strInstrumentID] && (tempModel.m_nDirection == model.m_nDirection))
            {
                [holdDatas removeObject:tempModel];
                if(model.m_nPosition != 0)
                {
                    [holdDatas insertObject:model atIndex:0];
//                    [holdDatas addObject:model];
                }
                break;
            }
        }
//        NSLog(@"持仓手数->%d",holdDatas.count);
        [self reloadData:holdDatas];

    }
    else if([data isKindOfClass:[PushModel class]])
    {
        PushModel *model = data;
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
            [self updateDealView];
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


#pragma mark 更新数据
-(void)reloadData : (NSMutableArray *)data
{
    if(!IS_NS_COLLECTION_EMPTY(data))
    {
        if([[data objectAtIndex:0] isKindOfClass:[DealHoldModel class]] && currentTabSelect == 0)
        {
            [_holdTableView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealHoldingModel class]] && currentTabSelect == 1)
        {
            [_holdingTableView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealHoldByModel class]] && currentTabSelect == 2)
        {
            [_holdByTableView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealProfitModel class]] && currentTabSelect == 3)
        {
            [_dealTableView reloadData:data];
        }
    }
 
}



@end
