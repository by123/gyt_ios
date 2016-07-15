//
//  BaseViewController.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ReduceViewController.h"
#import "AccessGoldModel.h"
#import "ReduceCell.h"
#import "MoneyDetailModel.h"
#import "ByTextField.h"
#import "InsetTextField.h"

#define Item_Height 50

@interface ReduceViewController ()


@property (strong, nonatomic) UIButton *applyBtn;

@property (strong, nonatomic) ByTextField *cashTextField;

@property (strong, nonatomic) UILabel *cashRMBLabel;

@property (strong, nonatomic) InsetTextField *submitterTextField;

@property (strong, nonatomic)  MoneyDetailModel *moneyModel;

@end

@implementation ReduceViewController

+(void)show : (BaseViewController *)controller
{
    ReduceViewController *targetController = [[ReduceViewController alloc]init];
    [controller.navigationController pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SocketConnect sharedSocketConnect] setDelegate:self];
    NSString *moneyDetailStr = [[NSUserDefaults standardUserDefaults] objectForKey:MoneyInfo];
    _moneyModel = [MoneyDetailModel mj_objectWithKeyValues:moneyDetailStr];
    [self initView];
}

-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    [self initBody];
    
    _applyBtn = [[UIButton alloc]init];
    _applyBtn.backgroundColor = SELECT_COLOR;
    [_applyBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _applyBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
    [_applyBtn addTarget:self action:@selector(getCash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyBtn];
    
}

-(void)initNavigationBar
{
    [self showNavigationBar];
    self.navBar.delegate = self;
    [ self.navBar.rightBtn setHidden:YES];
    [self.navBar setTitle:@"期货转银行"];
    [self.navBar setLeftImage:[UIImage imageNamed:@"ic_back"]];
}

-(void)initBody
{
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.textColor = TEXT_COLOR;
    rightLabel.text = [NSString stringWithFormat:@"权益：%.f",_moneyModel.m_dCurBalance];
    rightLabel.font = [UIFont systemFontOfSize:13.0f];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.frame = CGRectMake(0, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH/2, 25);
    [self.view addSubview:rightLabel];
    
    UILabel *canUseLabel = [[UILabel alloc]init];
    canUseLabel.textColor = TEXT_COLOR;
    canUseLabel.text = [NSString stringWithFormat:@"可用：%.f",_moneyModel.m_dAvailable];
    canUseLabel.font = [UIFont systemFontOfSize:13.0f];
    canUseLabel.textAlignment = NSTextAlignmentCenter;
    canUseLabel.frame = CGRectMake(SCREEN_WIDTH/2, NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH/2, 25);
    [self.view addSubview:canUseLabel];
    

    _cashTextField = [[ByTextField alloc]initWithType:NumberFloat frame:CGRectMake(10,NavigationBar_HEIGHT + StatuBar_HEIGHT + 30,SCREEN_WIDTH - 20,40) rootView:self.view title:@"金额(美元)："];
    [_cashTextField setTextFiledText:@"0"];
    __weak ReduceViewController *weakSelf = self;
    _cashTextField.block = ^(BOOL isCompelete,NSString *text)
    {
        double value = [text doubleValue];
        weakSelf.cashRMBLabel.text = [NSString stringWithFormat:@"人民币：%.2f",value * 6.8];
    };
    [self.view addSubview:_cashTextField];
    
    _cashRMBLabel = [[UILabel alloc]init];
    _cashRMBLabel.textColor = TEXT_COLOR;
    _cashRMBLabel.text = [NSString stringWithFormat:@"人民币：%.2f",0.0f];
    _cashRMBLabel.font = [UIFont systemFontOfSize:13.0f];
    _cashRMBLabel.textAlignment = NSTextAlignmentRight;
    _cashRMBLabel.frame = CGRectMake(10, NavigationBar_HEIGHT + StatuBar_HEIGHT + 75, SCREEN_WIDTH - 20, 20);
    [self.view addSubview:_cashRMBLabel];
    
    _submitterTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(10, NavigationBar_HEIGHT + StatuBar_HEIGHT + 100, SCREEN_WIDTH - 20,40)];
    [self.view addSubview:_submitterTextField];
    _submitterTextField.hasTitle = YES;
    _submitterTextField.textAlignment = NSTextAlignmentRight;
    [_submitterTextField setInsetTitle:@"申请人姓名：" font:[UIFont systemFontOfSize:13.0f]];
}

-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 提交提现申请
-(void)getCash
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    double cash = [[_cashTextField getTextFieldText] doubleValue];
    if(cash == 0)
    {
        [ByToast showErrorToast:@"请输入提现金额"];
        return;
    }
    if(cash > _moneyModel.m_dCurBalance)
    {
        [ByToast showErrorToast:@"输入金额大于可提现金额"];
        return;
    }
    NSString *submitter = _submitterTextField.text;
    if(IS_NS_STRING_EMPTY(submitter))
    {
        [ByToast showErrorToast:@"请输入申请人姓名"];
        return;
    }
    AccessGoldModel *model = [[AccessGoldModel alloc]init];
    model.m_strTargetId =  [[Account sharedAccount]getUid];
    model.m_nTargetType = CashInOutTargetType_Account;
    model.m_nCashType = CashType_Out;
    model.m_dCashValue = cash;
    model.m_nPayType = PayType_OFF_LINE;
    model.m_nStatus = CashApplicationStatus_Submit;
    model.m_strSubmitter =submitter;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"sessionId"] = [[Account sharedAccount]getSessionId];
    dic[@"cashApplyInfo"] = [JSONUtil parseDic:model];
    NSString *jsonStr = [JSONUtil parse:@"commitCashApplyInfo" params:dic];
    [[SocketConnect sharedSocketConnect] sendData:jsonStr seq:GYT_CommitCashApplyInfo];
}

-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.seq == GYT_CommitCashApplyInfo)
    {
        if([BaseRespondModel isSuccess:respondObject])
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"出金申请成功" message:@"我们将会在2-3个工作日内完成审核，请耐心等待，谢谢配合！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}



-(void)OnReceiveFail:(NSError *)error
{
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_submitterTextField resignFirstResponder];
    [_cashTextField resignFirstResponder];
}

@end
