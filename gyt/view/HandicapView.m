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

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIButton *leftButton;

@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) UITableView *handicapTableView;

@property (strong, nonatomic) NSMutableArray *handicapDatas;

@end

@implementation HandicapView
{
    Boolean isLeft;
}

-(instancetype)init
{
    if(self == [super init])
    {
        [self initView];
    }
    return self;
}

#pragma mark 初始化
-(void)initView
{
    _handicapDatas = [[NSMutableArray alloc]init];
    [self initTopView];
    [self initTableView];
}

-(void)initTopView
{
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight);
    _topView.backgroundColor = LINE_COLOR;
    [self addSubview:_topView];
    
    _leftButton = [[UIButton alloc]init];
    [_leftButton setTitle:@"盘口" forState:UIControlStateNormal];
    [_leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, kTopHeight);
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _leftButton.backgroundColor = [UIColor clearColor];
    [_leftButton addTarget:self action:@selector(OnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc]init];
    [_rightButton setTitle:@"成交明细" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, kTopHeight);
    _rightButton.backgroundColor = [UIColor clearColor];
    [_rightButton addTarget:self action:@selector(OnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_rightButton];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = SELECT_COLOR;
    _lineView.frame = CGRectMake(0, kTopHeight - 2, SCREEN_WIDTH/2, 2);
    [_topView addSubview:_lineView];
}

-(void)initTableView
{
    _handicapTableView = [[UITableView alloc]init];
    _handicapTableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, kContentHeight);
    _handicapTableView.backgroundColor = SUB_COLOR;
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
    [_handicapDatas addObject:[HandicapModel build:@"卖价" value1:@"11975" title2 :@"买量" value2:@"2"]];
    [_handicapDatas addObject:[HandicapModel build:@"买价" value1:@"11970" title2:@"卖量" value2:@"2"]];
    [_handicapDatas addObject:[HandicapModel build:@"最新" value1:@"11975" title2:@"涨跌" value2:@"-170/1.。40%"]];
    [_handicapDatas addObject:[HandicapModel build:@"开盘" value1:@"11875" title2:@"成交量" value2:@"10728"]];
    [_handicapDatas addObject:[HandicapModel build:@"最高" value1:@"11985" title2:@"持仓量" value2:@"45972"]];
    [_handicapDatas addObject:[HandicapModel build:@"最低" value1:@"11855" title2:@"日增仓" value2:@"-912"]];
    [_handicapDatas addObject:[HandicapModel build:@"均价" value1:@"11926" title2:@"外盘" value2:@"5250/49%"]];
    [_handicapDatas addObject:[HandicapModel build:@"结算" value1:@"--"
        title2:@"内盘" value2:@"5478/51%"]];
    [_handicapDatas addObject:[HandicapModel build:@"昨结" value1:@"12145" title2:@"涨停" value2:@"12870"]];
    [_handicapDatas addObject:[HandicapModel build:@"昨收" value1:@"11930" title2:@"跌停" value2:@"11415"]];
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

-(void)OnClicked : (id)sender
{
    UIButton *button = sender;
    if(button == _leftButton)
    {
        isLeft = YES;
        [self changeLeftView];
        [_leftButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(0, kTopHeight - 2, SCREEN_WIDTH/2, 2);
 
    }
    else if(button == _rightButton)
    {
        isLeft = NO;
        [self changeRightView];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(SCREEN_WIDTH/2, kTopHeight - 2, SCREEN_WIDTH/2, 2);
    }
}


@end
