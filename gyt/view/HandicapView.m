//
//  HandicapView.m
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HandicapView.h"
#import "HandicapCell.h"
#import "HandicapModel.h"
#import "HandicapDetailModel.h"


@interface HandicapView()

@property (strong, nonatomic) UITableView *handicapTableView;

@property (strong, nonatomic) NSMutableArray *handicapDatas;

@property (strong, nonatomic) ByTabView *tabView;

@property (strong, nonatomic) PushModel *model;

@end

@implementation HandicapView
{
    Boolean isLeft;
}

-(instancetype)initWithData : (PushModel *)model
{
    self = [super init];
    if(self)
    {
        self.model = model;
        [self initView];
        return self;
    }
    return nil;
}

#pragma mark 初始化
-(void)initView
{
    _handicapDatas = [[NSMutableArray alloc]init];
//    [self initTopView];
    [self initTableView];
}

//-(void)initTopView
//{
//    NSArray *array = @[@"盘口",@"成交明细"];
//    _tabView = [[ByTabView alloc]initWithTitles:CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight) array:array];
//    _tabView.backgroundColor = [ColorUtil colorWithHexString:@"#444444"];
//    _tabView.delegate = self;
//    [self addSubview:_tabView];
//}

-(void)OnSelect:(NSInteger)position
{
    if(position == 0)
    {
        isLeft = YES;
        [self changeLeftView];
    }
    else if(position == 1)
    {
        isLeft = NO;
        [self changeRightView];
    }
}

-(void)initTableView
{
    _handicapTableView = [[UITableView alloc]init];
    _handicapTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT - kTopHeight);
    _handicapTableView.backgroundColor = BACKGROUND_COLOR;
    _handicapTableView.scrollEnabled = NO;
    _handicapTableView.delegate = self;
    _handicapTableView.dataSource = self;
    [_handicapTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_handicapTableView];
    
    isLeft = YES;
    [self changeLeftView];
}

-(void)changeLeftView
{
    [self buildData];
    [_handicapTableView reloadData];
}

-(void)changeRightView
{
    [self buildDetailData];
    [_handicapTableView reloadData];
}


#pragma mark 构建盘口数据
-(void)buildData
{
    [_handicapDatas removeAllObjects];
    [_handicapDatas addObject:[HandicapModel build:@"卖价" value1:[NSString stringWithFormat:@"%.2f",_model.m_dBidPrice1] title2 :@"买量" value2:[NSString stringWithFormat:@"%d",_model.m_nAskVolume1]]];
    [_handicapDatas addObject:[HandicapModel build:@"买价" value1:[NSString stringWithFormat:@"%.2f",_model.m_dAskPrice1] title2:@"卖量" value2:[NSString stringWithFormat:@"%d",_model.m_nBidVolume1]]];
    NSString *updown = [NSString stringWithFormat:@"%.2f/%.2f",_model.m_dOpenPrice - _model.m_dLastPrice,(_model.m_dOpenPrice - _model.m_dLastPrice ) * 100 / _model.m_dOpenPrice];
    updown  = [updown stringByAppendingString:@"%"];
    if(_model.m_dOpenPrice == 0)
    {
        updown = @"--";
    }
    [_handicapDatas addObject:[HandicapModel build:@"最新" value1:[NSString stringWithFormat:@"%.2f",_model.m_dLastPrice] title2:@"涨跌" value2:updown]];
    [_handicapDatas addObject:[HandicapModel build:@"开盘" value1:[NSString stringWithFormat:@"%.2f",_model.m_dOpenPrice] title2:@"成交量" value2:[NSString stringWithFormat:@"%d",_model.m_nVolume]]];
    [_handicapDatas addObject:[HandicapModel build:@"最高" value1:[NSString stringWithFormat:@"%.2f",_model.m_dHighestPrice] title2:@"持仓量" value2:[NSString stringWithFormat:@"%d",_model.m_dOpenInterest]]];
    [_handicapDatas addObject:[HandicapModel build:@"最低" value1:[NSString stringWithFormat:@"%.2f",_model.m_dLowestPrice] title2:@"日增仓" value2:[NSString stringWithFormat:@"%d",_model.m_dOpenInterest - _model.m_dPreOpenInterest]]];
    [_handicapDatas addObject:[HandicapModel build:@"均价" value1:[NSString stringWithFormat:@"%.2f",_model.m_dAveragePrice] title2:@"外盘" value2:@"--"]];
    [_handicapDatas addObject:[HandicapModel build:@"结算" value1:@"--"
        title2:@"内盘" value2:@"--"]];
    [_handicapDatas addObject:[HandicapModel build:@"昨结" value1:@"--" title2:@"涨停" value2:@"--"]];
    [_handicapDatas addObject:[HandicapModel build:@"昨收" value1:@"--" title2:@"跌停" value2:@"--"]];
}

#pragma mark 构建成交明细数据
-(void)buildDetailData
{
    [_handicapDatas removeAllObjects];
    [_handicapDatas addObject:[HandicapModel buildDetail:@"时间" price:@"价位" handnow:@"现手" hold:@"增仓" kaiping:@"开平"]];
    for(int i =0 ;i < 30 ;i ++)
    {
        [_handicapDatas addObject:[HandicapModel buildDetail:@"1460883120" price:@"5542" handnow:@"22" hold:@"-16" kaiping:@"多开"]];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!IS_NS_COLLECTION_EMPTY(_handicapDatas))
    {
        return [_handicapDatas count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HandicapCell *cell = [[HandicapCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HandicapCell identify]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_handicapDatas))
    {
        HandicapModel *model = [_handicapDatas objectAtIndex:indexPath.row];
        if(isLeft)
        {
            [cell setData:model];
        }
        else
        {
            if(indexPath.row == 0)
            {
                [cell setDetailData:model isTitle:YES];
            }
            else
            {
                [cell setDetailData:model isTitle:NO];
            }
        }
 
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}


-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    if(packageModel.cmd == NET_CMD_NOTIFICATION)
    {
        [[PushDataHandle sharedPushDataHandle] handlePushData:packageModel.result delegate :self];
    }
}


-(void)pushResult:(id)data
{
    if([data isKindOfClass:[PushModel class]])
    {
        PushModel *model = data;
        if([model.m_strInstrumentID isEqualToString:_model.m_strInstrumentID])
        {
            _model = model;
            [self buildData];
            [_handicapTableView reloadData];
        }
    }
}


@end
