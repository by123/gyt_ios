//
//  ByTableView.m
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByDynamicTableView.h"
#import "DynamicCell.h"
#import "UIFolderTableView.h"

#define ItemHeight 40

@interface ByDynamicTableView()

@property (strong, nonatomic) UIFolderTableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) NSArray *titleDatas;

@property (strong, nonatomic) NSArray *widthDatas;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *backGroudView;


@property (strong, nonatomic) NSDictionary *currentCate;
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@end

@implementation ByDynamicTableView

-(instancetype)initWithData : (CGRect)rect
                      array : (NSMutableArray *)array
                   maxWidth : (int) maxWidth
                       type : (DealType)type
{
    self = [super initWithFrame:rect];
    if(self)
    {
        self.datas = array;
        self.maxWidth = maxWidth;
        self.type = type;
        [self initView];
        return self;
    }
    return nil;
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
    _backGroudView = [[UIView alloc]init];
    _backGroudView.backgroundColor = SELECT_COLOR;
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame =self.bounds;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(_maxWidth, self.bounds.size.height)];
    [self addSubview:_scrollView];

    _tableView = [[UIFolderTableView alloc]init];
    _tableView.frame =CGRectMake(0, 30, _maxWidth, self.bounds.size.height - 30);
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollView addSubview:_tableView];
}

-(void)initTopView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [ColorUtil colorWithHexString:@"#666666"];
    titleView.frame = CGRectMake(0, 0, _maxWidth, 30);
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
    [cell setSelectedBackgroundView:_backGroudView];
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
                NSLog(@"这是什么鬼->%d",indexPath.row);
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
    [cell setBackgroundColor:BACKGROUND_COLOR];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_expandView)
    {
        UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
        [folderTableView openFolderAtIndexPath:indexPath WithContentView:_expandView
                                     openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                         
                                         _isExpand= YES;
                                         if(_delegate)
                                         {
                                             [_delegate OnExpandView:YES];
                                         }
                                         // opening actions
                                         //                                    [self CloseAndOpenACtion:indexPath];
                                     }
                                    closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                        
                                        // closing actions
                                        //                                    [self CloseAndOpenACtion:indexPath];
                                        //[cell changeArrowWithUp:NO];
                                    }
                               completionBlock:^{
                                   // completed actions
                                   _isExpand = NO;
                                   if(_delegate)
                                   {
                                       [_delegate OnExpandView:NO];
                                   }
                                   self.tableView.scrollEnabled = YES;
                               }];
    }
    if(_delegate)
    {
        [_delegate OnItemSelected:self position:indexPath.row];
    }
}

//-(void)CloseAndOpenACtion:(NSIndexPath *)indexPath
//{
//    if ([indexPath isEqual:self.selectIndex]) {
//        self.isOpen = NO;
//        [self didSelectCellRowFirstDo:NO nextDo:NO];
//        self.selectIndex = nil;
//    }
//    else
//    {
//        if (!self.selectIndex) {
//            self.selectIndex = indexPath;
//            [self didSelectCellRowFirstDo:YES nextDo:NO];
//            
//        }
//        else
//        {
//            [self didSelectCellRowFirstDo:NO nextDo:YES];
//        }
//    }
//}
//- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
//{
//    self.isOpen = firstDoInsert;
//    
//    if (nextDoInsert) {
//        self.isOpen = YES;
//        self.selectIndex = [self.tableView indexPathForSelectedRow];
//        [self didSelectCellRowFirstDo:YES nextDo:NO];
//    }
//}

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
//    _datas = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    [_tableView reloadData];
}


-(void)reloadOneRow:(NSInteger)position
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:position inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}



@end
