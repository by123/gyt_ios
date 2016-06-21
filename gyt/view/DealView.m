
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

//价格
@property (strong, nonatomic) UIButton *priceButton;

//持仓，挂单，委托，成交 标题
@property (strong, nonatomic) ByTabView *tabView;

//持仓，挂单，委托，成交
@property (strong, nonatomic) ByDynamicTableView *dynamicView;

//数据
@property (strong, nonatomic) PushModel *model;

@property (assign, nonatomic) NSInteger position;

@property (strong, nonatomic) MoneyDetailModel *moneyModel;

@property (strong, nonatomic) UIView *rootView;

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
}

-(instancetype)initWithData : (CGRect)frame
              model : (PushModel *)model
               view : (UIView *)rootView
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _model = model;
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
    currentItemSelect= -1;
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
    _nameButton.frame = CGRectMake(10, view.height+5, SCREEN_WIDTH/2+20, 30);
    [_nameButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nameButton];
    
    //手数
    _handTextField = [[ByTextField alloc]initWithType:NumberInt frame:CGRectMake(10,  _nameButton.y + _nameButton.height +5, _nameButton.width/2 -10, 30) rootView:_rootView title:@"手数："];
    [_handTextField setTextFiledText:@"1"];
    [self addSubview:_handTextField];
    
    //价格
    _priceButton = [[UIButton alloc]init];
    [_priceButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _priceButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _priceButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _priceButton.layer.borderWidth = 0.5;
    _priceButton.layer.cornerRadius = 2;
    _priceButton.layer.masksToBounds = YES;
    [_priceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_priceButton setTitle:@"价格: 对手价" forState:UIControlStateNormal];
    _priceButton.frame = CGRectMake(10 + _handTextField.width + 5 , _nameButton.y + _nameButton.height +5, _nameButton.width/2 +5, 30);
    [_priceButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_priceButton];
//    _priceTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(10 + _handTextField.width + 5 , _nameButton.y + _nameButton.height +5, _nameButton.width/2 +5, 30) rootView:_rootView title:@"价格:"];
//    [_priceTextField setTextFiledText:@"对手价"];
//    
//    __weak DealView *weakSelf = self;
//    _priceTextField.block = ^(BOOL isCompelete,NSString *text)
//    {
//        if(isCompelete)
//        {
//            NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买多",weakSelf.model.m_dAskPrice1];
//            [weakSelf.buyItem setTitle:buyTxt forState:UIControlStateNormal];
//            
//            NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖空",weakSelf.model.m_dBidPrice1];
//            [weakSelf.sellItem setTitle:sellTxt forState:UIControlStateNormal];
//        }
//    };
//    [self addSubview:_priceTextField];
    
    
    _priceView = [[UIView alloc]init];
    _priceView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];;
    _priceView.frame = CGRectMake(_priceButton.x + _priceButton.width+5 , view.height + 5, SCREEN_WIDTH - 15 - _nameButton.width, 65);
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
    _buyItem.frame = CGRectMake(10, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 30)/2, 60);
    _buyItem.layer.masksToBounds = YES;
    _buyItem.layer.cornerRadius = 4;
    
    NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买多",_model.m_dAskPrice1];
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
    _sellItem.frame = CGRectMake(10 * 2 + (SCREEN_WIDTH - 30)/2, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 30)/2, 60);
    _sellItem.layer.masksToBounds = YES;
    _sellItem.layer.cornerRadius = 4;


    NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖空",_model.m_dBidPrice1];
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
    CGRect rect = CGRectMake(0, _sellItem.y + _sellItem.height+10, SCREEN_WIDTH, 40);
    _tabView = [[ByTabView alloc]initWithTitles:rect array:array];
    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];
    _tabView.delegate = self;
    [self addSubview:_tabView];
    
    [self initHoldData];
    [self requestQuery:XT_CPositionStatics];

}

#pragma mark 动态数据
-(void)updateData : (PushModel *)model
{
//    [_priceTextField setTextFiledText:[NSString stringWithFormat:@"%.2f",model.m_dLastPrice]];
    NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————————\n买多",model.m_dAskPrice1];
    [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
    NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————————\n卖空",model.m_dBidPrice1];
    [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
    
    int width = _priceView.size.width;
    _currentPriceLabel.text = [NSString stringWithFormat:@"新:%.2f",model.m_dLastPrice];
    _currentPriceLabel.frame = CGRectMake(5, 2.5,(width - 10)/2, 20);

    _currentCountLabel.text = [NSString stringWithFormat:@"%d",model.m_nVolume];
    _currentCountLabel.textAlignment = NSTextAlignmentRight;
    _currentCountLabel.frame = CGRectMake(width/2, 2.5, width/2, 20);

    _buyPriceLabel.text = [NSString stringWithFormat:@"买:%.2f",model.m_dBidPrice1];
    _buyPriceLabel.frame = CGRectMake(5, 22.5, (width - 10)/2, 20);

    
    _buyCountLabel.text = [NSString stringWithFormat:@"%d",model.m_nBidVolume1];
    _buyCountLabel.textAlignment = NSTextAlignmentRight;
    _buyCountLabel.frame = CGRectMake(width/2, 22.5, width/2, 20);

    _sellPriceLabel.text = [NSString stringWithFormat:@"卖:%.2f",model.m_dAskPrice1];
    _sellPriceLabel.frame = CGRectMake(5, 42.5, (width - 10)/2, 20);

    _sellCountLabel.text = [NSString stringWithFormat:@"%d",model.m_nAskVolume1];
    _sellCountLabel.textAlignment = NSTextAlignmentRight;
    _sellCountLabel.frame = CGRectMake(width/2, 42.5, width/2, 20);
    
}


#pragma mark 持仓数据
-(void)initHoldData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    
    NSArray *titleArray = @[@"品种",@"合约号",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈",@"币种",@"损盈",@"价值",@"保证金",@"今手数",@"今可用",@"投保"];
    NSArray *widthArray = @[@"1",@"2",@"1",@"1",@"1",@"2",@"2",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH , SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdDatas maxWidth:SCREEN_WIDTH * 2.5 type:Hold];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];
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
                NSString *message = [NSString stringWithFormat:@"%@，平仓价：%.2f",model.m_strInstrumentID,model.m_dLastPrice];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认平仓吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 3;
                [alert show];
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
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
  
    NSArray *titleArray = @[@"时间",@"合约",@"状态",@"买卖",@"委托价",@"委托量",@"可撤",@"已成交",@"投保",@"预止损",@"合同号",@"主场号"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdingDatas maxWidth:SCREEN_WIDTH*2.5 type:Holding];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];

}

#pragma mark 委托数据
-(void)initHoldByData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSArray *titleArray = @[@"时间",@"合约",@"状态",@"买卖",@"委托价",@"委托量",@"可撤",@"已成交",@"投保",@"合同号",@"主场号"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdByDatas maxWidth:SCREEN_WIDTH * 2 type:HoldBy];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];
}

#pragma mark 成交数据
-(void)initDealData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSArray *titleArray = @[@"时间",@"合约",@"买卖",@"成交价",@"成交量",@"合同号",@"主场号"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
                             
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdProfileDatas maxWidth:SCREEN_WIDTH*1.5 type:Profit];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];
}


#pragma mark tabview选择
-(void)OnSelect:(NSInteger)position
{
    [self hideKeyboard];
    currentTabSelect = position;
    switch (position) {
        case 0:
            [self initHoldData];
            [self requestQuery:XT_CPositionStatics];
            break;
        case 1:
            [self initHoldingData];
            [self requestQuery:XT_COrderDetail];
            break;
        case 2:
            [self initHoldByData];
            [self requestQuery:XT_COrderDetail];
            break;
        case 3:
            [self initDealData];
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
        director = ENTRUST_BUY;
        NSString *message = [NSString stringWithFormat:@"%@，%.2f，买，%@手",_model.m_strInstrumentID,_model.m_dAskPrice1,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 0;
        [alert show];
    }
    else if(view == _sellItem)
    {
        director = ENTRUST_SELL;
        NSString *message = [NSString stringWithFormat:@"%@，%.2f，卖，%@手",_model.m_strInstrumentID,_model.m_dBidPrice1,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
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
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:array title:@"价格"];
        dialog.tag = 1;
        dialog.delegate = self;
        [self.rootView addSubview:dialog];
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
    }
    else if(dialog.tag == 1)
    {
        [_priceButton setTitle:[NSString stringWithFormat:@"价格: %@",data] forState:UIControlStateNormal];
    }
}

#pragma mark 请求持仓，委托，成交
-(void)requestQuery : (RequestType)type
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:type];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:type];
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
        //平仓
        if(model.m_nDirection == ENTRUST_BUY)
        {
            model.m_nDirection = ENTRUST_SELL;
        }
        else
        {
            model.m_nDirection = ENTRUST_BUY;
        }
        orderModel.info = [OrderModel buildOrderModel :model.m_strProductID  instrumentID:model.m_strInstrumentID orderPrice:model.m_dLastPrice orderNum:model.m_nCanCloseVol direction:model.m_nDirection offsetFlag:EOFF_THOST_FTDC_OF_Close];
    }
    else
    {
        double price;
        //下单
        if(director == ENTRUST_BUY)
        {
            price = _model.m_dAskPrice1;
        }
        else
        {
            price = _model.m_dBidPrice1;
        }
        orderModel.info = [OrderModel buildOrderModel : _model.m_strProductID instrumentID:_model.m_strInstrumentID  orderPrice:price orderNum:hand direction:director offsetFlag:EOFF_THOST_FTDC_OF_Open];
    }

    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:GYT_ORDER];
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
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:GYT_CANCEL];

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
                    [holdDatas addObject:holdModel];
                }
            }
            [self reloadData:holdDatas];

        }
    }
    //委托
    else if(packageModel.seq == XT_COrderDetail && !IS_NS_STRING_EMPTY(packageModel.result))
    {
        [holdByDatas removeAllObjects];
        [holdingDatas removeAllObjects];
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
            if(currentTabSelect == 1)
            {
                for(id obj in array)
                {
                    DealHoldingModel *holdingModel = [DealHoldingModel mj_objectWithKeyValues:obj];
                    OrderTagModel *tagModel = [[OrderTagModel alloc]init];
                    tagModel.m_strRealTag = holdingModel.m_strOrderRef;
                    holdingModel.m_tag = tagModel;
                    if(holdingModel.m_nOrderStatus == ENTRUST_STATUS_REPORTED)
                    {
                        [holdingDatas addObject:holdingModel];
                    }
                }
                [self reloadData:holdingDatas];
            }
            else if(currentTabSelect == 2)
            {
                for(id obj in array)
                {
                    DealHoldByModel *holdByModel = [DealHoldByModel mj_objectWithKeyValues:obj];
                    OrderTagModel *tagModel = [[OrderTagModel alloc]init];
                    tagModel.m_strRealTag = holdByModel.m_strOrderRef;
                    holdByModel.m_tag = tagModel;
                    [holdByDatas addObject:holdByModel];
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
                [holdProfileDatas addObject:profitModel];
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
                    [_dynamicView reloadOneRow:i];
                }
            }
            if(!hasModel)
            {
                [holdingDatas addObject:model];
                [self reloadData:holdingDatas];
            }
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
                    [_dynamicView reloadOneRow:i];
                }
            }
            if(!hasModel)
            {
                [holdByDatas addObject:model];
                [self reloadData:holdByDatas];
            }
        }

    }
    else if([data isKindOfClass:[DealProfitModel class]])
    {
        DealProfitModel *model = data;
        [holdProfileDatas addObject:model];
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
                [holdDatas addObject:model];
                break;
            }
        }
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
            [self updateData:_model];
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
            [_dynamicView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealHoldingModel class]] && currentTabSelect == 1)
        {
            [_dynamicView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealHoldByModel class]] && currentTabSelect == 2)
        {
            [_dynamicView reloadData:data];
        }
        else if([[data objectAtIndex:0] isKindOfClass:[DealProfitModel class]] && currentTabSelect == 3)
        {
            [_dynamicView reloadData:data];
        }
    }
 
}



@end
