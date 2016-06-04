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
    if(self == [super init])
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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    if(IS_NS_COLLECTION_EMPTY(_datas))
    {
        return;
    }
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(SCREEN_WIDTH /8, SCREEN_HEIGHT / 6-30, SCREEN_WIDTH * 3/4, 30);
    _titleLabel.backgroundColor = MAIN_COLOR;
    _titleLabel.text = _title;
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_titleLabel];

    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = MAIN_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(SCREEN_WIDTH /8,SCREEN_HEIGHT / 6, SCREEN_WIDTH * 3/4, SCREEN_HEIGHT * 2 /3);
    [self addSubview:_tableView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LINE_COLOR;
    lineView.frame = CGRectMake(SCREEN_WIDTH/8, SCREEN_HEIGHT / 6, SCREEN_HEIGHT *3/4, 0.5);
    [self addSubview:lineView];
    
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
        [_delegate OnListDialogItemClick:[_datas objectAtIndex:indexPath.row]];
        [self removeFromSuperview];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
