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

#define Item_Height 40

@interface ReduceViewController ()

@property (strong, nonatomic) UIButton *applyBtn;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation ReduceViewController

+(void)show : (BaseViewController *)controller
{
    ReduceViewController *targetController = [[ReduceViewController alloc]init];
    [controller.navigationController pushViewController:targetController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc]init];
    _datas = [AccessGoldModel getData];
    [self initView];
}

-(void)initView
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self initNavigationBar];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [ColorUtil colorWithHexString:@"#333333"];
    _tableView.frame = CGRectMake(0,NavigationBar_HEIGHT + StatuBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationBar_HEIGHT + StatuBar_HEIGHT) - 40);
    [self.view addSubview:_tableView];
    
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
    ReduceCell *cell = [[ReduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:
                         [ReduceCell identify]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [cell setData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)OnLeftClickCallback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 提交提现申请
-(void)getCash
{
    AccessGoldModel *model = [[AccessGoldModel alloc]init];
    model.m_nMoneyType = MoneyType_RMB;
    
    NSMutableDictionary *dic = [JSONUtil parseStr:model];
    NSString *jsonStr = [JSONUtil parse:Request_CashApplyInfo params:dic];
    [self requsetGetCash :jsonStr];
}

#pragma mark 请求提现
-(void)requsetGetCash : (NSString *)jsonStr
{
    [[HttpRequest sharedHttpRequest] post:jsonStr view:self.view success:^(id responseObject) {
        BaseRespondModel *model = [BaseRespondModel mj_objectWithKeyValues:responseObject];
        [DialogHelper showSuccessTips:@"提现申请成功"];
//        {"content": [], "error": {"ErrorMsg": "\u4e0emobileService\u8fde\u63a5\u8d85\u65f6", "ErrorID": -103}}
        
    } fail:^(NSError *error) {
        
        [DialogHelper showTips:@"提交提现申请失败"];

    }];
    
}
@end
