
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
#import "DealHoldingModel.h"
#import "DealHoldByModel.h"
#import "DealProfitModel.h"
#import "QueryRequest.h"
#import "OrderRequestModel.h"
#import "MoneyDetailModel.h"

@interface DealView()

//权益
@property (strong, nonatomic) UILabel *rightLabel;

//可用资金
@property (strong, nonatomic) UILabel *canUseLabel;

//使用率
@property (strong, nonatomic) UILabel *userPercentLabel;

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
@property (strong, nonatomic) ByTextField *priceTextField;

//持仓，挂单，委托，成交 标题
@property (strong, nonatomic) ByTabView *tabView;

//持仓，挂单，委托，成交
@property (strong, nonatomic) ByDynamicTableView *dynamicView;

//数据
@property (strong, nonatomic) ProductModel *model;

@property (strong, nonatomic) MoneyDetailModel *moneyModel;

@property (strong, nonatomic) UIView *rootView;

@end

@implementation DealView
{
    NSMutableArray *holdDatas;
    NSMutableArray *holdingDatas;
    NSMutableArray *holdByDatas;
    NSMutableArray *holdProfileDatas;
    DealHoldModel *dealModel;
    NSInteger currentItemSelect;
    NSInteger currentTabSelect;
}

-(instancetype)initWithData : (CGRect)frame
              model : (ProductModel *)model
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
    dealModel = [[DealHoldModel alloc]init];
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
    [_nameButton setTitle:@"CN 1606" forState:UIControlStateNormal];
    _nameButton.frame = CGRectMake(10, view.height+5, SCREEN_WIDTH/2+20, 30);
    [self addSubview:_nameButton];
    
    //手数
    _handTextField = [[ByTextField alloc]initWithType:NumberInt frame:CGRectMake(10,  _nameButton.y + _nameButton.height +5, _nameButton.width/2 -10, 30) rootView:_rootView title:@"手数："];
    [_handTextField setTextFiledText:@"1"];
    [self addSubview:_handTextField];
    
    //价格
    _priceTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(10 + _handTextField.width + 5 , _nameButton.y + _nameButton.height +5, _nameButton.width/2 +5, 30) rootView:_rootView title:@"价格:"];
    [_priceTextField setTextFiledText:@"9140"];
    
    __weak DealView *weakSelf = self;
    _priceTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        if(isCompelete)
        {
            NSString *buyTxt = [NSString stringWithFormat:@"%@\n—————————\n买多",text];
            [weakSelf.buyItem setTitle:buyTxt forState:UIControlStateNormal];
            
            NSString *sellTxt = [NSString stringWithFormat:@"%@\n—————————\n卖空",text];
            [weakSelf.sellItem setTitle:sellTxt forState:UIControlStateNormal];
        }
    };
    [self addSubview:_priceTextField];
    
    
    UIView *priceView = [[UIView alloc]init];
    priceView.backgroundColor = [ColorUtil colorWithHexString:@"#262626"];;
    priceView.frame = CGRectMake(_priceTextField.x + _priceTextField.width+5 , view.height + 5, SCREEN_WIDTH - 25 - _nameButton.width, 65);
    priceView.layer.cornerRadius = 4;
    priceView.layer.masksToBounds = YES;
    [self addSubview:priceView];
    
    _currentPriceLabel = [[UILabel alloc]init];
    _currentPriceLabel.textColor = TEXT_COLOR;
    _currentPriceLabel.text = [NSString stringWithFormat:@"新:%.f",_model.recentPrice];
    _currentPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _currentPriceLabel.frame = CGRectMake(5, 2.5, _currentPriceLabel.contentSize.width, 20);
    [priceView addSubview:_currentPriceLabel];
    
    _currentCountLabel = [[UILabel alloc]init];
    _currentCountLabel.textColor = TEXT_COLOR;
    _currentCountLabel.text = @"12323";
    _currentCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _currentCountLabel.frame = CGRectMake(priceView.size.width - _currentCountLabel.contentSize.width-5, 2.5, _currentPriceLabel.contentSize.width, 20);
    [priceView addSubview:_currentCountLabel];
    
    _buyPriceLabel = [[UILabel alloc]init];
    _buyPriceLabel.textColor = TEXT_COLOR;
    _buyPriceLabel.text = [NSString stringWithFormat:@"买:%.f",_model.recentPrice];
    _buyPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _buyPriceLabel.frame = CGRectMake(5, 22.5, _buyPriceLabel.contentSize.width, 20);
    [priceView addSubview:_buyPriceLabel];
    
    _buyCountLabel = [[UILabel alloc]init];
    _buyCountLabel.textColor = TEXT_COLOR;
    _buyCountLabel.text = @"2000";
    _buyCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _buyCountLabel.frame = CGRectMake(priceView.size.width - _buyCountLabel.contentSize.width-5, 22.5, _buyCountLabel.contentSize.width, 20);
    [priceView addSubview:_buyCountLabel];
    
    _sellPriceLabel = [[UILabel alloc]init];
    _sellPriceLabel.textColor = TEXT_COLOR;
    _sellPriceLabel.text = [NSString stringWithFormat:@"卖:%.f",_model.recentPrice+1];
    _sellPriceLabel.font = [UIFont systemFontOfSize:13.0f];
    _sellPriceLabel.frame = CGRectMake(5, 42.5, _sellPriceLabel.contentSize.width, 20);
    [priceView addSubview:_sellPriceLabel];
    
    _sellCountLabel = [[UILabel alloc]init];
    _sellCountLabel.textColor = TEXT_COLOR;
    _sellCountLabel.text = @"120";
    _sellCountLabel.font = [UIFont systemFontOfSize:13.0f];
    _sellCountLabel.frame = CGRectMake(priceView.size.width - _sellCountLabel.contentSize.width-5, 42.5, _sellCountLabel.contentSize.width, 20);
    [priceView addSubview:_sellCountLabel];

    
    
    _buyItem = [[UIButton alloc]init];
    _buyItem.frame = CGRectMake(10, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 30)/2, 60);
    _buyItem.layer.masksToBounds = YES;
    _buyItem.layer.cornerRadius = 4;
    
    NSString *buyTxt = [NSString stringWithFormat:@"%.f\n—————————\n买多",9140.0f];
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


    NSString *sellTxt = [NSString stringWithFormat:@"%.f\n—————————\n卖空",9141.0f];
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



#pragma mark 持仓数据
-(void)initHoldData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    
    NSArray *titleArray = @[@"品种",@"合约号",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈",@"币种",@"损盈",@"价值",@"保证金",@"今手数",@"今可用",@"投保"];
    NSArray *widthArray = @[@"2",@"1",@"1",@"1",@"1",@"2",@"2",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH , SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdDatas maxWidth:SCREEN_WIDTH * 2.5 type:Hold];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];
}


-(void)OnItemSelected:(UIView *)dynamicTableView position:(NSInteger)position
{
//    currentSelect = position;
//    DealHoldModel *model =[holdDatas objectAtIndex:position];
//    NSString *closeTxt = [NSString stringWithFormat:@"%.f\n————\n平仓",model.m_dOpenPrice];
//    [_closeItem setTitle:closeTxt forState:UIControlStateNormal];
//    [_closeItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
//            [self requestQuery:XT_CPositionStatics];
            break;
        case 2:
            [self initHoldByData];
            [self requestQuery:XT_COrderDetail];
            break;
        case 3:
            [self initDealData];
//            [self requestQuery:XT_CDealDetail];
            break;
        default:
            break;
    }
}

#pragma mark 点击事件处理
-(void)OnClick : (id)sender
{
    UIView *view = sender;
    NSString *name = _nameButton.titleLabel.text;
    NSString * price = [_priceTextField getTextFieldText];
    NSString * hand = [_handTextField getTextFieldText];
    
    if(view == _buyItem)
    {
        NSString *message = [NSString stringWithFormat:@"%@，%@，买，%@手",name,price,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 0;
        [alert show];
    }
    else if(view == _sellItem)
    {
        NSString *message = [NSString stringWithFormat:@"%@，%@，卖，%@手",name,price,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
    
    [self hideKeyboard];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        if(alertView.tag == 0 || alertView.tag == 1)
        {
            NSLog(@"%d",[_tabView getCurrent]);
        }
        else if(alertView.tag == 2)
        {
            if(currentItemSelect != -1)
            {
                DealHoldModel *model = [holdDatas objectAtIndex:currentItemSelect];
                [holdDatas removeObject:model];
            }
        }
//        if([_tabView getCurrent] == 0)
//        {
//            [_dynamicView reloadData :holdDatas];            
//        }
//        
        [self order];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

-(void)hideKeyboard
{
    [_handTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
}



#pragma mark 请求持仓，委托，成交
-(void)requestQuery : (RequestType)type
{
    NSString *jsonStr = [QueryRequest buildQueryInfo:type];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:type];
}


#pragma mark 请求下单
-(void)order
{
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    
    OrderRequestModel *orderModel = [[OrderRequestModel alloc]init];
    orderModel.strSessionID = [[Account sharedAccount]getSessionId];
    orderModel.account = account;
    NSString *name = _nameButton.titleLabel.text;
    double price = [[_priceTextField getTextFieldText] doubleValue];
    double hand = [[_handTextField getTextFieldText] doubleValue];
    
    orderModel.info = [OrderModel buildOrderModel:name orderPrice:price orderNum:hand direction:ENTRUST_BUY offsetFlag:EOFF_THOST_FTDC_OF_Open];
    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr delegate:self seq:GYT_ORDER];
}


#pragma mark 接收数据
-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];

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
                [holdDatas addObject:holdModel];
            }
            [self reloadData:holdDatas];

        }
        else
        {
            [DialogHelper showTips:@"无持仓数据"];
        }
    }
    else if(packageModel.seq == XT_COrderDetail && !IS_NS_STRING_EMPTY(packageModel.result))
    {
        [holdByDatas removeAllObjects];
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:respondModel.response];
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
            for(id obj in array)
            {
                DealHoldByModel *holdByModel = [DealHoldByModel mj_objectWithKeyValues:obj];
                [holdByDatas addObject:holdByModel];
            }
            [self reloadData:holdByDatas];
        }
    }
    else if(packageModel.seq == XT_CDealDetail && !IS_NS_STRING_EMPTY(packageModel.result))
    {
        
    }
    else if(packageModel.seq == GYT_ORDER)
    {
        id data = [respondModel.response objectForKey:@"res"];
        DealHoldByModel *holdByModel = [DealHoldByModel mj_objectWithKeyValues:data];
        holdByModel.m_tag = [OrderTagModel mj_objectWithKeyValues:holdByModel.m_tag];
        if(holdByModel != nil)
        {
            [holdByDatas addObject:holdByModel];
            [self reloadData:holdByDatas];
            [DialogHelper showSuccessTips:@"下单成功"];
        }
        else
        {
            [DialogHelper showTips:@"下单失败"];
        }
    }
}

#pragma mark 更新数据
-(void)reloadData : (NSMutableArray *)data
{
    if([data isKindOfClass:[DealHoldModel class]] && (currentTabSelect == 0 || currentTabSelect == 1))
    {
        [_dynamicView reloadData:data];
    }
    else if([data isKindOfClass:[DealHoldByModel class]] && currentTabSelect == 2)
    {
        [_dynamicView reloadData:data];
    }
    else if([data isKindOfClass:[DealProfitModel class]] && currentTabSelect == 3)
    {
        [_dynamicView reloadData:data];
    }
 
}

@end
