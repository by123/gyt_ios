//
//  ByTableView.m
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByDynamicTableView.h"
#import "DynamicCell.h"

#define ItemHeight 30

@interface ByDynamicTableView()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) NSArray *titleDatas;

@property (strong, nonatomic) NSArray *widthDatas;

@property (strong, nonatomic) UIScrollView *scrollView;


@end

@implementation ByDynamicTableView

-(instancetype)initWithData : (CGRect)rect
                      array : (NSMutableArray *)array
                   maxWidth : (int) maxWidth
{
    if(self == [super initWithFrame:rect])
    {
        self.datas = array;
        self.maxWidth = maxWidth;
        [self initView];
    }
    return self;
}

-(void)setHeaders : (NSArray *)widths
          headers : (NSArray *)headers
{
    self.titleDatas = headers;
    self.widthDatas = widths;
    [self initTopView];
}


-(void)initView
{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame =self.bounds;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(_maxWidth, self.bounds.size.height)];
    [self addSubview:_scrollView];

    _tableView = [[UITableView alloc]init];
    _tableView.frame =CGRectMake(0, ItemHeight, _maxWidth, self.bounds.size.height - ItemHeight);

    _tableView.backgroundColor = [UIColor redColor];
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollView addSubview:_tableView];
}

-(void)initTopView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [ColorUtil colorWithHexString:@"#666666"];
    titleView.frame = CGRectMake(0, 0, _maxWidth, ItemHeight);
    [_scrollView addSubview:titleView];
    int count = 0;
    if(!IS_NS_COLLECTION_EMPTY(_widthDatas))
    {
        for(NSString *temp in _widthDatas)
        {
            int tempInt = [temp intValue];
            count +=tempInt;
        }
    }
    
    int currentWidth = 0;
    for(int i = 0 ; i< _titleDatas.count ; i++ )
    {
        UILabel *label = [[UILabel alloc]init];
        label.textColor= BACKGROUND_COLOR;
        label.font = [UIFont systemFontOfSize:13.0f];
        int width =  [[_widthDatas objectAtIndex:i] intValue] * _maxWidth / count;
        label.frame = CGRectMake(currentWidth, 0, width, 30);
        label.text = [_titleDatas objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        [titleView addSubview:label];
        currentWidth += width;
        
//        UIView *lineView = [[UIView alloc]init];
//        lineView.backgroundColor = LINE_COLOR;
//        lineView.frame = CGRectMake(0, 30- 0.5, _maxWidth, 0.5);
//        [titleView addSubview:lineView];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        return _datas.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCell *cell  = [[DynamicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DynamicCell identify] widths:_widthDatas];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        [cell setData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offset = scrollView.contentOffset.x;
    if(offset < 0)
    {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
    }
    if(offset > _maxWidth)
    {
        [scrollView setContentOffset:CGPointMake(_maxWidth, scrollView.contentOffset.y)];
    }
}

@end
