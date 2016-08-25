//
//  MoneyManageViewController.m
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyManageViewController.h"
#import "MoneyManageDetailViewController.h"
#import "MoneyManageCell.h"
#import "AccessGoldModel.h"
#import "ByDatePicker.h"

#define Item_Height 110
#define DialogHeight IDSPointValue(160)

@interface MoneyManageViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UITextField *startTextField;

@property (strong, nonatomic) UITextField *endTextField;



@end

@implementation MoneyManageViewController
{
    int currentTag;
}

+(void)show : (SlideNavigationController *)controller
{
    MoneyManageViewController *targetCoxntroller = [[MoneyManageViewController alloc]init];
    [controller pushViewController:targetCoxntroller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleCashApplyInfoData:) name:CashApplyInfoData object:nil];
    _datas = [[NSMutableArray alloc]init];
    [self requestCashApplyInfo : @"0" end:@"0"];
    [self initView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CashApplyInfoData object:nil];

}

-(void)initView
{
    [self initNavigationBar];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#333333"];
    _tableView.frame = Default_Frame;
    [self.view addSubview:_tableView];
    
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [self.navBar setTitle:@"出入金管理"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
    [self.navBar setRightImage:[UIImage imageNamed:@"ic_filter"]];

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
    return Item_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [[MoneyManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MoneyManageCell identify]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
      AccessGoldModel *model = [AccessGoldModel mj_objectWithKeyValues:[_datas objectAtIndex:indexPath.row]];
      [cell setData:model];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setRootViewSelect:YES];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        AccessGoldModel *model = [AccessGoldModel mj_objectWithKeyValues:[_datas objectAtIndex:indexPath.row]];
        [MoneyManageDetailViewController show:self model:model];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyManageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setRootViewSelect:NO];
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnRightClickCallBack:(NSInteger)position
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowDate = [formatter stringFromDate:[NSDate date]];
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc]init];
    [alertView setDelegate:self];
    UIView *containView = [[UIView alloc]init];
    containView.frame = CGRectMake(0, 0, SCREEN_WIDTH-60, DialogHeight);
    
    UILabel *startLabel = [[UILabel alloc]init];
    startLabel.text = @"开始时间";
    startLabel.textColor = [UIColor blackColor];
    startLabel.font = [UIFont systemFontOfSize:13.0f];
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.frame = CGRectMake(10, 40, startLabel.contentSize.width, 30);
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
    _startTextField.text = nowDate;
    _startTextField.frame = CGRectMake(startLabel.frame.size.width + 15, 40, containView.size.width - startLabel.contentSize.width - 25, 30);
    [containView addSubview:_startTextField];
    
    UILabel *endLabel = [[UILabel alloc]init];
    endLabel.text = @"结束时间";
    endLabel.textColor = [UIColor blackColor];
    endLabel.font = [UIFont systemFontOfSize:13.0f];
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.frame = CGRectMake(10, _startTextField.size.height + 40 + 20, endLabel.contentSize.width, 30);
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
    _endTextField.text = nowDate;
    _endTextField.frame = CGRectMake(endLabel.frame.size.width + 15, _startTextField.size.height + 40 + 20, containView.size.width - endLabel.contentSize.width - 25, 30);
    [containView addSubview:_endTextField];

    [alertView setButtonTitles:@[@"取消",@"确定"]];
    [alertView setContainerView:containView];
    [alertView show];
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
    __weak MoneyManageViewController *weakSelf = self;
    ByDatePicker *datePicker = [[ByDatePicker alloc] initWithDatePickerMode:UIDatePickerModeDate DateFormatter:@"yyyy-MM-dd" datePickerFinishBlock:^(NSString *dateString) {
        __strong MoneyManageViewController *strongSelf = weakSelf;
        if(currentTag == 0)
        {
            if([self isVaildDate:dateString end:strongSelf.endTextField.text])
            {
                [strongSelf.startTextField setText:dateString];
            }
        }
        else if(currentTag == 1)
        {
            if([self isVaildDate:strongSelf.startTextField.text end:dateString])
            {
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
        NSString *startDateStr = [_startTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endDateStr = [_endTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self requestCashApplyInfo : startDateStr end:endDateStr];
    }
    [alertView close];
}


-(void)requestCashApplyInfo : (NSString *)startDateStr end : (NSString *)endDateStr
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"sessionId"] = [[Account sharedAccount] getSessionId];
    dic[@"strAccountID"] = [[Account sharedAccount]getUid];
    dic[@"startDate"] = startDateStr;
    dic[@"endDate"] = endDateStr;
    NSString *jsonStr = [JSONUtil parse:@"queryAccountCashApplyInfo" params:dic];
    
    
    [[SocketConnect sharedSocketConnect]sendData:jsonStr seq:GYT_CashApplyInfo];
}


-(void)handleCashApplyInfoData : (NSNotification *)notification
{
    BaseRespondModel *respondModel = notification.object;
    _datas = [respondModel.response objectForKey:@"resp"];
    [_tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
