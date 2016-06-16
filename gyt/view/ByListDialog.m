//
//  ByListDialog.m
//  gyt
//
//  Created by by.huang on 16/5/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByListDialog.h"

#define Item_Height 40

@interface ByListDialog()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UIView *selectView;

@property (copy, nonatomic) NSString *title;
@end

@implementation ByListDialog

-(instancetype)initWithData : (NSMutableArray *)array
                      title : (NSString *)title
{
    if(self == [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)])
    {
        self.title= title;
        self.datas = array;
        [self initView];
    }
    return self;
}


-(void)initView
{
    self.backgroundColor = [ColorUtil colorWithHexString:@"#000000" alpha:0.3f];

    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        return;
    }
    
    UIView *rootView = [[UIView alloc]init];
    rootView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 3/4, 30 + 200);
    rootView.backgroundColor =MAIN_COLOR;
    rootView.layer.borderColor = [LINE_COLOR CGColor];
    rootView.layer.borderWidth = 1.0f;
    rootView.layer.masksToBounds = YES;
    rootView.layer.cornerRadius = 4;
    rootView.centerX = SCREEN_WIDTH/2;
    rootView.centerY = SCREEN_HEIGHT/2;
    [self addSubview:rootView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH * 3/4, 30);
    _titleLabel.text = _title;
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [rootView addSubview:_titleLabel];

    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =MAIN_COLOR;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0,30, SCREEN_WIDTH * 3/4, 200);
    [rootView addSubview:_tableView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(0, 30, SCREEN_HEIGHT *3/4, 0.5);
    [rootView addSubview:lineView];
    
    _selectView = [[UIView alloc]init];
    _selectView.backgroundColor = SELECT_COLOR;
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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ByListDialog"];
    cell.backgroundColor = [UIColor clearColor];
    if(!IS_NS_COLLECTION_EMPTY(_datas))
    {
        cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
        cell.textLabel.textColor = TEXT_COLOR;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setSelectedBackgroundView:_selectView];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate)
    {
        [_delegate OnListDialogItemClick:[_datas objectAtIndex:indexPath.row] dialog:self];
        [self removeFromSuperview];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
