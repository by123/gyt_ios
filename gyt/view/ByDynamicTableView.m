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
                       type : (DealType)type
{
    if(self == [super initWithFrame:rect])
    {
        self.datas = array;
        self.maxWidth = maxWidth;
        self.type = type;
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
        switch (_type) {
            case Hold:
                [cell setHoldData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
                break;
            case Holding:
                [cell setHoldingData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
                break;
            case HoldBy:
                [cell setHoldByData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
                break;
            case Profit:
                [cell setProfitData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
                break;
            case Warn:
                [cell setWarnData:[_datas objectAtIndex:indexPath.row] maxWidth:_maxWidth];
                break;
                
            default:
                break;
        }
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ProductModel *model = [_datas objectAtIndex:indexPath.row];
    

    if(!model.isSelect)
    {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        ProductModel *addModel = [[ProductModel alloc]init];
        addModel.isDelete = YES;
        addModel.isSelect = YES;
        [_datas insertObject:addModel atIndex:indexPath.row + 1];
        
        [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        model.isSelect = YES;
    }
    else
    {
        if(!model.isDelete)
        {
            [_datas removeObjectAtIndex:indexPath.row+1];
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row+1
                                                     inSection:0]];
            
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            
            model.isSelect = NO;
        }
    }

   
//    if(isSelect)
//    {
//        [_datas removeObject:[_datas objectAtIndex:indexPath.row]];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else
//    {
//        [_datas addObject:[_datas objectAtIndex:indexPath.row]];
//        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }

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

-(void)reloadData : (NSMutableArray *)array
{
    _datas = array;
    [_tableView reloadData];
}


@end
