//
//  ShortCutView.m
//  gyt
//
//  Created by by.huang on 16/6/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ShortCutView.h"
#import "ByTextField.h"
#import "UserInfoModel.h"
#import "OrderRequestModel.h"

#define View_Height 160
#define View_Width SCREEN_WIDTH-60

@interface ShortCutView()

@property (strong, nonatomic) ByTextField *handTextField;

@property (strong, nonatomic) UIView *parentView;

@property (strong, nonatomic) UIButton *closeButton;

@property (strong, nonatomic) UIButton *priceButton;

@property (strong, nonatomic) UILabel *priceLabel;

@property (strong, nonatomic) UIButton *buyItem;

@property (strong, nonatomic) UIButton *sellItem;


@property (strong, nonatomic) PushModel *model;

@end

@implementation ShortCutView
{
    EEntrustBS director;
}

-(instancetype)initWithView : (UIView *)parentView
                      model : (PushModel *)model
{
    self.parentView = parentView;
    self.model = model;
    if(self.parentView == nil)
    {
        return self;
    }
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if(self == [super initWithFrame:rect])
    {
        self.backgroundColor = [ColorUtil colorWithHexString:@"#222222" alpha:0.5f];
        [self initView];
    }
    return  self;
}

-(void)initView
{
    self.userInteractionEnabled = YES;
    
    UIView *rootView = [[UIView alloc]init];
    [rootView setUserInteractionEnabled:YES];
    rootView.frame =  CGRectMake(30, (SCREEN_HEIGHT-View_Height)/2-100, View_Width, View_Height);
    rootView.layer.masksToBounds = YES;
    rootView.layer.cornerRadius = 4;
    rootView.layer.borderColor = [LINE_COLOR CGColor];
    rootView.layer.borderWidth = 1;
    rootView.backgroundColor = MAIN_COLOR;
    [self addSubview:rootView];
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = _model.m_strInstrumentID;
    nameLabel.textColor = TEXT_COLOR;
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.frame = CGRectMake(0, 0, View_Width, 50);
    [rootView addSubview:nameLabel];
    
    _handTextField = [[ByTextField alloc]initWithType:NumberInt frame:CGRectMake(10,  50 , (rootView.size.width-30)/2 ,35) rootView:self.parentView title:@"手数："];
    [_handTextField setTextFiledText:@"1"];
    [rootView addSubview:_handTextField];
    
    
    _closeButton = [[UIButton alloc]init];
    [_closeButton setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    _closeButton.frame = CGRectMake(View_Width - 40, 10, 30, 30);
    [_closeButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_closeButton];
    //
    _priceButton = [[UIButton alloc]init];
    _priceButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _priceButton.layer.borderWidth = 0.5;
    _priceButton.layer.cornerRadius = 2;
    _priceButton.layer.masksToBounds = YES;
    _priceButton.frame = CGRectMake(20 + (rootView.size.width-30)/2 ,50,  (rootView.size.width-30)/2, 35);
    [_priceButton addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_priceButton];
    
    UILabel *priceTitleLabel = [[UILabel alloc]init];
    priceTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    priceTitleLabel.textColor = TEXT_COLOR;
    priceTitleLabel.text = @"价格：";
    priceTitleLabel.textAlignment = NSTextAlignmentCenter;
    priceTitleLabel.frame = CGRectMake(5, 0, priceTitleLabel.contentSize.width, 35);
    [_priceButton addSubview:priceTitleLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.font = [UIFont systemFontOfSize:14.0f];
    _priceLabel.textColor = TEXT_COLOR;
    _priceLabel.text = @"对手价 ▼";
    _priceLabel.tag = 0;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.frame = CGRectMake(5, 0, (rootView.size.width-30)/2 -10, 35);
    [_priceButton addSubview:_priceLabel];
    
    
    //
    _buyItem = [[UIButton alloc]init];
    _buyItem.frame = CGRectMake(10, 95, (rootView.size.width-30)/2, 55);
    _buyItem.layer.masksToBounds = YES;
    _buyItem.layer.cornerRadius = 4;
    NSString *buyTxt = [NSString stringWithFormat:@"%.2f\n—————\n买多",_model.m_dAskPrice1];
    [_buyItem setTitle:buyTxt forState:UIControlStateNormal];
    [_buyItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _buyItem.titleLabel.numberOfLines = 0;
    _buyItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _buyItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _buyItem.backgroundColor = [ColorUtil colorWithHexString:@"#CD5555"];
    [_buyItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:_buyItem];
    
    _sellItem = [[UIButton alloc]init];
    _sellItem.frame = CGRectMake(20 + (rootView.size.width-30)/2,95, (rootView.size.width-30)/2, 55);
    _sellItem.layer.masksToBounds = YES;
    _sellItem.layer.cornerRadius = 4;
    NSString *sellTxt = [NSString stringWithFormat:@"%.2f\n—————\n卖空",_model.m_dBidPrice1];
    [_sellItem setTitle:sellTxt forState:UIControlStateNormal];
    [_sellItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sellItem.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _sellItem.titleLabel.numberOfLines = 0;
    _sellItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sellItem.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _sellItem.backgroundColor = [ColorUtil colorWithHexString:@"#2E8B57"];
    [_sellItem addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rootView addSubview:_sellItem];
    

}


-(void)OnClick : (id)sender
{
    NSString * hand = [_handTextField getTextFieldText];

    UIButton *button = sender;
    if(button == _closeButton)
    {
        [self removeFromSuperview];
    }
    else if(button == _priceButton)
    {
        switch (_priceLabel.tag) {
            case 0:
                _priceLabel.text = @"市价 ▼";
                _priceLabel.tag = 1;
                break;
            case 1:
                _priceLabel.text = @"对手价 ▼";
                _priceLabel.tag = 0;
                break;
            default:
                break;
        }
    }
    else if(button == _buyItem)
    {
        director = ENTRUST_BUY;
        NSString *message = [NSString stringWithFormat:@"%@，%.2f，买，%@手",_model.m_strInstrumentID,_model.m_dAskPrice1,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 0;
        [alert show];
    }
    else if(button == _sellItem)
    {
        director = ENTRUST_SELL;
        NSString *message = [NSString stringWithFormat:@"%@，%.2f，卖，%@手",_model.m_strInstrumentID,_model.m_dBidPrice1,hand];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认下单吗？" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
       [self order];
    }

}

#pragma mark 请求下单
-(void)order
{
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    OrderRequestModel *orderModel = [[OrderRequestModel alloc]init];
    orderModel.strSessionID = [[Account sharedAccount]getSessionId];
    orderModel.account = account;
    double hand = [[_handTextField getTextFieldText] doubleValue];
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
    
    NSMutableDictionary *dic =[JSONUtil parseDic:orderModel];
    NSString *jsonStr = [JSONUtil parse:@"order" params:dic];
    
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_ORDER];
}

-(void)OnReceiveSuccess:(id)respondObject
{
//    PackageModel *packageModel = respondObject;
//    BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];


}




@end
