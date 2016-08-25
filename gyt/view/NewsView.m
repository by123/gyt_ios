//
//  NewsView.m
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "NewsView.h"
#import "NewsCell.h"
#import "MJRefresh.h"

#define Item_Height 100
#define Request_Size 10

@interface NewsView()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation NewsView
{
    UIView *selectView;
}


-(instancetype)initWithData : (CGRect)frame
                      model : (PushModel *)model
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _datas = [[NSMutableArray alloc]init];
        [self initView];
        return self;
    }
    return nil;
}

-(void)initView
{
    selectView = [[UIView alloc]init];
    selectView.backgroundColor = SELECT_COLOR;
    
    self.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.frame = self.bounds;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [_tableView setSectionIndexBackgroundColor:SELECT_COLOR];
    [self addSubview:_tableView];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore:)];
    
    [self requestList];
}



#pragma mark 列表处理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        return [_datas count];
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Item_Height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsCell identify]];
    [cell setBackgroundColor:BACKGROUND_COLOR];
    [cell setSelectedBackgroundView:selectView];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [cell setData:[_datas objectAtIndex:indexPath.row]];
    }
    return cell;
}



-(void)uploadMore : (id)sender
{
    [self requestList];
}

#pragma mark 请求数据
-(void)requestList
{
    for(int i =0 ;i < 10 ; i ++)
    {
        NewsModel *model = [[NewsModel alloc]init];
        model.title = @"系统消息";
        model.content = @"中秋节放假通知";
        model.from = @"股一通";
        model.time = @"2016-08-23 10:58";
        [_datas addObject:model];
    }
    [_tableView.footer endRefreshing];
    [_tableView reloadData];
}


@end
