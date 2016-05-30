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

//平仓按钮
@property (strong, nonatomic) UIButton *closeItem;

//手数
@property (strong, nonatomic) InsetTextField *handTextField;

//价格
@property (strong, nonatomic) InsetTextField *priceTextField;

//持仓，挂单，委托，成交 标题
@property (strong, nonatomic) ByTabView *tabView;

//持仓，挂单，委托，成交
@property (strong, nonatomic) ByDynamicTableView *dynamicView;

//数据
@property (strong, nonatomic) ProductModel *model;

@end

@implementation DealView
{
    NSMutableArray *holdDatas;
    DealHoldModel *dealModel;
    NSInteger currentSelect;
}

-(instancetype)initWithData : (CGRect)frame
              model : (ProductModel *)model
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _model = model;
        holdDatas = [[NSMutableArray alloc]init];
        [self initView];
        return self;
    }
    return nil;
}

#pragma mark 初始化
-(void)initView
{
    self.backgroundColor = BACKGROUND_COLOR;
    currentSelect= -1;
    dealModel = [[DealHoldModel alloc]init];
    [self initTopView];
    [self initBottomView];
    [self requestQuery];

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
    _rightLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH/3-5, 25);
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
    
    //名称
    _nameButton = [[UIButton alloc]init];
    [_nameButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _nameButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _nameButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _nameButton.layer.borderWidth = 0.5;
    _nameButton.layer.cornerRadius = 2;
    _nameButton.layer.masksToBounds = YES;
    [_nameButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -SCREEN_WIDTH/2 + 30, 0, 0)];
    [_nameButton setTitle:@"名称: " forState:UIControlStateNormal];
    _nameButton.frame = CGRectMake(10, view.height+5, SCREEN_WIDTH/2+20, 30);
    [self addSubview:_nameButton];
    
    //手数
    _handTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(10,  _nameButton.y + _nameButton.height +5, _nameButton.width/2 -10, 30)];
    _handTextField.hasTitle = YES;
    [_handTextField setInsetTitle:@"手数：" font:[UIFont systemFontOfSize:14.0f]];
    _handTextField.text = @"1";
    _handTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_handTextField];
    
    //价格
    _priceTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(10 + _handTextField.width + 5 , _nameButton.y + _nameButton.height +5, _nameButton.width/2 +5, 30)];
    _priceTextField.hasTitle = YES;
    [_priceTextField setInsetTitle:@"价格：" font:[UIFont systemFontOfSize:14.0f]];
    _priceTextField.text = @"1989";
    _priceTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    _buyItem.frame = CGRectMake(10, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 40)/3, 60);
    _buyItem.layer.masksToBounds = YES;
    _buyItem.layer.cornerRadius = 4;
    
    NSString *buyTxt = [NSString stringWithFormat:@"%.f\n————\n买多",_model.recentPrice];
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
    _sellItem.frame = CGRectMake(10 * 2 + (SCREEN_WIDTH - 40)/3, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 40)/3, 60);
    _sellItem.layer.masksToBounds = YES;
    _sellItem.layer.cornerRadius = 4;


    NSString *sellTxt = [NSString stringWithFormat:@"%.f\n————\n卖空",_model.recentPrice+1];
    [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
    [_sellItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sellItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _sellItem.titleLabel.numberOfLines = 0;
    _sellItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sellItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _sellItem.backgroundColor = [ColorUtil colorWithHexString:@"#2E8B57"];
    [_sellItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_sellItem];
    
    _closeItem = [[UIButton alloc]init];
    _closeItem.frame = CGRectMake(10 * 3 + (SCREEN_WIDTH - 40) * 2/3, _handTextField.y + _handTextField.height + 10, (SCREEN_WIDTH - 40)/3, 60);
    _closeItem.layer.masksToBounds = YES;
    _closeItem.layer.cornerRadius = 4;
    [_closeItem setTitle:@"无仓位\n————\n平仓" forState:UIControlStateNormal];
    [_closeItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _closeItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _closeItem.titleLabel.numberOfLines = 0;
    _closeItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _closeItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _closeItem.backgroundColor = TEXT_COLOR;
    [_closeItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_closeItem];
    
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
}



#pragma mark 持仓数据
-(void)initHoldData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    
    NSArray *titleArray = @[@"品种",@"合约号",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈",@"币种",@"损盈",@"价值",@"保证金",@"今手数",@"今可用",@"投保"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH , SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:holdDatas maxWidth:SCREEN_WIDTH * 2 type:Hold];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    _dynamicView.delegate = self;
    [self addSubview:_dynamicView];
}


-(void)OnItemSelected:(UIView *)dynamicTableView position:(NSInteger)position
{
    currentSelect = position;
    NSLog(@"%d",position);
    DealHoldModel *model =[holdDatas objectAtIndex:position];
    NSString *closeTxt = [NSString stringWithFormat:@"%@\n————\n平仓",model.averagePrice];
    [_closeItem setTitle:closeTxt forState:UIControlStateNormal];
    [_closeItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark 挂单数据
-(void)initHoldingData
{
    if(_dynamicView)
    {
        [_dynamicView removeFromSuperview];
    }
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    DealHoldingModel *model = [[DealHoldingModel alloc]init];
    model.name  = @"郑麦1605";
    model.kaiping = @"全平";
    model.price = @"2020";
    model.handby = @"10";
    model.hand = @"10";

    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:model];
    }
    NSArray *titleArray = @[@"名称",@"开平",@"委托价",@"委托量",@"挂单量"];
    NSArray *widthArray = @[@"2",@"1",@"2",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH type:Holding];
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
    DealHoldByModel *model = [[DealHoldByModel alloc]init];
    model.name = @"郑麦1605";
    model.statu = @"全成";
    model.kaiping = @"买开";
    model.price = @"5040";
    model.handby = @"5";
    model.handDeal = @"5";
    model.handCancel = @"0";
    model.time = @"20:12";

    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:model];
    }
    NSArray *titleArray = @[@"名称",@"状态",@"开平",@"委托价",@"委托量",@"已成交",@"已撤单",@"委托时间"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH * 1.5 type:HoldBy];
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
    DealProfitModel *model = [[DealProfitModel alloc]init];
    model.name = @"郑麦1605";
    model.kaiping = @"全平";
    model.price = @"全平";
    model.hand = @"5";
    model.time = @"19:28";
    
    for(int i= 0 ;i < 20 ; i++)
    {
        [datas addObject:model];
    }
    NSArray *titleArray = @[@"名称",@"开平",@"成交价",@"成交量",@"成交时间"];
    NSArray *widthArray = @[@"1",@"1",@"1",@"1",@"1"];
    _dynamicView = [[ByDynamicTableView alloc]initWithData:CGRectMake(0, _tabView.y+_tabView.height, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT  -(_tabView.y+_tabView.height) - 40) array:datas maxWidth:SCREEN_WIDTH type:Profit];
    [_dynamicView setHeaders:widthArray headers:titleArray];
    [self addSubview:_dynamicView];
}

#pragma mark tabview选择
-(void)OnSelect:(NSInteger)position
{
    [self hideKeyboard];
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

#pragma mark 点击事件处理
-(void)OnClick : (id)sender
{
    UIView *view = sender;
    if(view == _buyItem)
    {
        DealHoldModel *tempModel = [[DealHoldModel alloc]init];
        tempModel.name = _model.name;
        tempModel.buySell = More;
        tempModel.hand = _handTextField.text;
        tempModel.canuse = _handTextField.text;
        tempModel.averagePrice = [NSString stringWithFormat:@"%.f", _model.recentPrice];
        tempModel.profit = @"0";
        
        dealModel = tempModel;
        NSString *message = [NSString stringWithFormat:@"%@，%.f，买，%@手",_model.name,_model.recentPrice,_handTextField.text];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 0;
        [alert show];
    }
    else if(view == _sellItem)
    {
        DealHoldModel *tempModel = [[DealHoldModel alloc]init];

        tempModel.name = _model.name;
        tempModel.buySell = Less;
        tempModel.hand = _handTextField.text;
        tempModel.canuse = _handTextField.text;
        tempModel.averagePrice = [NSString stringWithFormat:@"%.f", _model.recentPrice + 1];
        tempModel.profit = @"0";
        
        dealModel = tempModel;
        
        NSString *message = [NSString stringWithFormat:@"%@，%.f，卖，%@手",_model.name,_model.recentPrice+1,_handTextField.text];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
    else if(view == _closeItem)
    {
        
        if(currentSelect != -1)
        {
            DealHoldModel *model = [holdDatas objectAtIndex:currentSelect];
            NSString *buySell;
            if([model.buySell isEqualToString:More])
            {
                buySell = Sell;
            }
            else{
                buySell = Buy;
            }
            NSString *message = [NSString stringWithFormat:@"%@，%@，%@，平仓，%@手",model.name,model.averagePrice,buySell,model.hand];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 2;
            [alert show];
        }
    }
    
    [self hideKeyboard];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        if(alertView.tag == 0 || alertView.tag == 1)
        {
            [holdDatas addObject:dealModel];
            NSLog(@"%d",[_tabView getCurrent]);
        }
        else if(alertView.tag == 2)
        {
            if(currentSelect != -1)
            {
                DealHoldModel *model = [holdDatas objectAtIndex:currentSelect];
                [holdDatas removeObject:model];
            }
        }
        
        if([_tabView getCurrent] == 0)
        {
            [_dynamicView reloadData :holdDatas];            
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
    [_priceTextField resignFirstResponder];
}


#pragma mark 请求持仓
-(void)requestQuery
{
    [QueryRequest requestQueryInfo:self requestType:XT_CPositionStatics success:^(id responseObject) {
        QueryRespondsModel *model = [QueryRespondsModel mj_objectWithKeyValues:responseObject];
        NSMutableArray *array = model.datas;
        if(!IS_NS_COLLECTION_EMPTY(array))
        {
//            //多种资金
//            for(id obj in array)
//            {
//                MoneyDetailModel *moneyDetailModel = [MoneyDetailModel mj_objectWithKeyValues:obj];
//                _datas = [MoneyDetailModel getData : moneyDetailModel];
//                [_tableView reloadData];
//            }
        }
        else{
            [DialogHelper showSuccessTips:@"暂无持仓信息"];
        }
        
        
    } fail:^(NSError *error) {
        [DialogHelper showTips:@"获取资金信息失败，请重试!"];
    }];
}


#pragma mark 下单
-(void)order
{
 
//    NSMutableDictionary *dic =[JSONUtil parseDic:model];
//    NSString *result = [JSONUtil parse:@"queryData" params:dic];

}

@end
