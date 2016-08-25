//
//  DealHistoryViewController.m
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "DealHistoryViewController.h"
#import "ByDatePicker.h"
#import "HistoryOrderCell.h"
#import "HistoryTradeCell.h"
#import "QueryHistoryModel.h"
#import "HistoryRequestModel.h"
#import "HistoryOrderModel.h"
#import "HistoryTradeModel.h"
#define DialogHeight IDSPointValue(160)
#define OrderItem_Height 200
#define TradeItem_Height 168


@interface DealHistoryViewController ()

@property (strong, nonatomic) UIButton *orderBtn;

@property (strong, nonatomic) UIButton *tradeBtn;

@property (strong, nonatomic) UITextField *startTextField;

@property (strong, nonatomic) UITextField *endTextField;

@property (strong, nonatomic) UILabel *selectLabel;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;


@end

@implementation DealHistoryViewController
{
    int currentTag;
    int requestType;
    NSString *startDateStr;
    NSString *endDateStr;
}

+(void)show : (SlideNavigationController *)controller
{
    DealHistoryViewController *targetViewController = [[DealHistoryViewController alloc]init];
    [controller pushViewController:targetViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc]init];
    requestType = XT_COrderDetail;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleHistoryData:) name:HistoryData object:nil];
    [self initView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:HistoryData object:nil];
    
}

-(void)initView
{
    [self initNavigationBar];
    [self initBody];
    
    NSString *nowDate = [self getCurrentDate];
    startDateStr = nowDate;
    endDateStr = nowDate;
    
    NSString *formatNowStr = [NSString stringWithFormat:@"%d",[AppUtil getFormatNow]];
    [self requestHistoryInfo:formatNowStr end:formatNowStr type:XT_COrderDetail];
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setRightImage:[UIImage imageNamed:@"ic_history"]];
    [self.navBar setTitle:@"历史交易查询"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)initBody
{
    _selectLabel = [[UILabel alloc]init];
    _selectLabel.frame =CGRectMake(0, StatuBar_HEIGHT + NavigationBar_HEIGHT, SCREEN_WIDTH, 30);
    _selectLabel.textColor = TEXT_COLOR;
    _selectLabel.font = [UIFont systemFontOfSize:14.0f];
    _selectLabel.textAlignment = NSTextAlignmentCenter;
    NSString *nowDateStr = [self getCurrentDate];
    NSString *selectStr = [NSString stringWithFormat:@"委托纪录:%@到%@",nowDateStr,nowDateStr];
    _selectLabel.text = selectStr;
    [self.view addSubview:_selectLabel];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, StatuBar_HEIGHT + NavigationBar_HEIGHT + 30, SCREEN_WIDTH, SCREEN_HEIGHT - (StatuBar_HEIGHT + NavigationBar_HEIGHT + 30));
    _tableView.backgroundColor = BACKGROUND_COLOR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnRightClickCallBack:(NSInteger)position
{
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc]init];
    [alertView setDelegate:self];
    UIView *containView = [[UIView alloc]init];
    containView.frame = CGRectMake(0, 0, SCREEN_WIDTH-60, DialogHeight);
    
    _orderBtn = [[UIButton alloc]init];
    _orderBtn.frame = CGRectMake(0, 0, containView.size.width/2, 40);
    [_orderBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:_orderBtn];
    
    _tradeBtn = [[UIButton alloc]init];
    _tradeBtn.frame = CGRectMake(containView.size.width/2, 0, containView.size.width/2, 40);
    [_tradeBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:_tradeBtn];
    
    if(requestType == XT_COrderDetail)
    {
        [self setOrderBtnClick];
    }
    else if(requestType == XT_CDealDetail)
    {
        [self setTradeBtnClick];
    }
    
    UILabel *startLabel = [[UILabel alloc]init];
    startLabel.text = @"开始时间";
    startLabel.textColor = [UIColor blackColor];
    startLabel.font = [UIFont systemFontOfSize:13.0f];
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.frame = CGRectMake(10, 60, startLabel.contentSize.width, 30);
    [containView addSubview:startLabel];
    
    _startTextField = [[UITextField alloc]init];
    _startTextField.tag = 0;
    _startTextField.textColor = [UIColor blackColor];
    _startTextField.font = [UIFont systemFontOfSize:13.0f];
    _startTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _startTextField.layer.borderWidth = 1;
    _startTextField.layer.cornerRadius = 4;
    _startTextField.layer.masksToBounds = YES;
    _startTextField.textAlignment = NSTextAlignmentCenter;
    _startTextField.delegate = self;
    _startTextField.text = startDateStr;
    _startTextField.frame = CGRectMake(startLabel.frame.size.width + 15, 60, containView.size.width - startLabel.contentSize.width - 25, 30);
    [containView addSubview:_startTextField];
    
    UILabel *endLabel = [[UILabel alloc]init];
    endLabel.text = @"结束时间";
    endLabel.textColor = [UIColor blackColor];
    endLabel.font = [UIFont systemFontOfSize:13.0f];
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.frame = CGRectMake(10, _startTextField.size.height + 60 + 20, endLabel.contentSize.width, 30);
    [containView addSubview:endLabel];
    
    _endTextField = [[UITextField alloc]init];
    _endTextField.tag = 1;
    _endTextField.textColor = [UIColor blackColor];
    _endTextField.font = [UIFont systemFontOfSize:13.0f];
    _endTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _endTextField.layer.borderWidth = 1;
    _endTextField.layer.cornerRadius = 4;
    _endTextField.layer.masksToBounds = YES;
    _endTextField.textAlignment = NSTextAlignmentCenter;
    _endTextField.delegate = self;
    _endTextField.text = endDateStr;
    _endTextField.frame = CGRectMake(endLabel.frame.size.width + 15, _startTextField.size.height + 60 + 20, containView.size.width - endLabel.contentSize.width - 25, 30);
    [containView addSubview:_endTextField];
    
    [alertView setButtonTitles:@[@"取消",@"确定"]];
    [alertView setContainerView:containView];
    [alertView show];
}

- (void)OnClick : (id)sender
{
    UIButton *button = sender;
    if(button == _orderBtn)
    {
        requestType = XT_COrderDetail;
        [self setOrderBtnClick];
    }
    else if(button == _tradeBtn)
    {
        requestType = XT_CDealDetail;
        [self setTradeBtnClick];
    }
}


-(void)setOrderBtnClick
{
    [_orderBtn setTitle:@"委托 √" forState:UIControlStateNormal];
    [_tradeBtn setTitle:@"成交" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    [_tradeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)setTradeBtnClick
{
    [_orderBtn setTitle:@"委托" forState:UIControlStateNormal];
    [_tradeBtn setTitle:@"成交 √" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    [_tradeBtn setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
}

-(NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    currentTag = textField.tag;
    [self showDatePicker];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)showDatePicker
{
    __weak DealHistoryViewController *weakSelf = self;
    ByDatePicker *datePicker = [[ByDatePicker alloc] initWithDatePickerMode:UIDatePickerModeDate DateFormatter:@"yyyy-MM-dd" datePickerFinishBlock:^(NSString *dateString) {
        __strong DealHistoryViewController *strongSelf = weakSelf;
        if(currentTag == 0)
        {
            if([self isVaildDate:dateString end:strongSelf.endTextField.text])
            {
                startDateStr = dateString;
                [strongSelf.startTextField setText:dateString];
            }
        }
        else if(currentTag == 1)
        {
            if([self isVaildDate:strongSelf.startTextField.text end:dateString])
            {
                endDateStr = dateString;
                [strongSelf.endTextField setText:dateString];
            }
        }
    }];
    datePicker.maximumDate = [NSDate date];
    [datePicker show];
}

-(BOOL)isVaildDate : (NSString *)startText end : (NSString *)endText
{
    if(!IS_NS_STRING_EMPTY(startText))
    {
        NSRange range = NSMakeRange(0, 4);
        int startYear = [[startText substringWithRange:range] intValue];
        int endYear = [[endText substringWithRange:range] intValue];
        if(startYear > endYear)
        {
            [ByToast showErrorToast:@"开始时间不能大于结束时间"];
            return NO;
        }
        range = NSMakeRange(5, 2);
        int startMonth = [[startText substringWithRange:range] intValue];
        int endMonth = [[endText substringWithRange:range] intValue];
        if(startMonth > endMonth)
        {
            [ByToast showErrorToast:@"开始时间不能大于结束时间"];
            return NO;
        }
        range = NSMakeRange(8, 2);
        int startDay = [[startText substringWithRange:range] intValue];
        int endDay = [[endText substringWithRange:range] intValue];
        if(startDay > endDay)
        {
            [ByToast showErrorToast:@"开始时间不能大于结束时间"];
            return NO;
        }
    }
    return YES;
}

-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSString *startFormatDate = [AppUtil formateDate:_startTextField.text];
        NSString *endFormatDate =[AppUtil formateDate:_endTextField.text];
        NSString *selectStr;
        if(requestType == XT_COrderDetail)
        {
            selectStr = [NSString stringWithFormat:@"委托纪录:%@到%@",_startTextField.text,_endTextField.text];
        }
        else if(requestType == XT_CDealDetail)
        {
            selectStr = [NSString stringWithFormat:@"成交纪录:%@到%@",_startTextField.text,_endTextField.text];
        }
        _selectLabel.text = selectStr;
        [self requestHistoryInfo:startFormatDate end:endFormatDate type:requestType];
    }
    [alertView close];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        return 0;
    }
    return [_datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(requestType == XT_COrderDetail)
    {
        return OrderItem_Height;
    }
    else
    {
        return TradeItem_Height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(requestType == XT_COrderDetail)
    {
        NSString *identify = [HistoryOrderCell identify];
        HistoryOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(cell == nil)
        {
            cell = [[HistoryOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setData:[_datas objectAtIndex:indexPath.row]];
        return cell;
    }
    else
    {
        NSString *identify = [HistoryTradeCell identify];
        HistoryTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(cell == nil)
        {
            cell = [[HistoryTradeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setData:[_datas objectAtIndex:indexPath.row]];
        return cell;
    }
}



-(void)requestHistoryInfo : (NSString *)startFormatDate end : (NSString *)endFormatDate type : (RequestType)type
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
    UserInfoModel *account = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
    
    QueryHistoryModel *model = [[QueryHistoryModel alloc]init];
    model.metaType = type;
    model.startDate = [startFormatDate intValue];
    model.endDate = [endFormatDate intValue];
    model.account = account;
    
    HistoryRequestModel *requestModel = [[HistoryRequestModel alloc]init];
    requestModel.strSessionID = [[Account sharedAccount] getSessionId];
    requestModel.req = model;

    NSString *jsonStr = [JSONUtil parse:@"queryHistroyData" params:requestModel.mj_keyValues];
    
    NSLog(@"这个->%@",jsonStr);
    
    [[SocketConnect sharedSocketConnect]sendData:jsonStr seq:GYT_QueryHistoryData];
}


-(void)handleHistoryData : (NSNotification *)notification
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    BaseRespondModel *respondModel = notification.object;
    id response = respondModel.response;
    id content = [response objectForKey:@"content"];
    if(requestType == XT_COrderDetail)
    {
        _datas = [HistoryOrderModel mj_objectArrayWithKeyValuesArray:content];
    }
    else if(requestType == XT_CDealDetail)
    {
        _datas = [HistoryTradeModel mj_objectArrayWithKeyValuesArray:content];
    }

    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        [ByToast showWarnToast:@"历史数据为空!"];
    }
    [_tableView reloadData];
}

@end
