//
//  ByListSelect.m
//  gyt
//
//  Created by by.huang on 16/8/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ByListSelect.h"
#define ItemHeight 35

@interface ByListSelect()

@property (strong, nonatomic) UIButton *selectBtn;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ByListSelect
{
    Boolean isOpen;
}

-(instancetype)initWithDatas : (NSMutableArray *)datas
                       title : (NSString *)title
{
    if(self == [super init])
    {
        self.datas = datas;
        self.title = title;
        [self initView];
    }
    return self;
}

-(void)initView
{

    self.frame = CGRectMake(0, 0, 100, ItemHeight + ItemHeight *[_datas count]);
    
    _selectBtn = [[UIButton alloc]init];
    [_selectBtn setBackgroundImage:[AppUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_selectBtn setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#ffffff" alpha:0.2f]] forState:UIControlStateSelected];
    [_selectBtn setTitle:_title forState:UIControlStateNormal];
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBtn.frame = CGRectMake(0, 0, 100, ItemHeight);
    [_selectBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectBtn];
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, ItemHeight, 100, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
}

-(void)OnClick : (id)sender
{
    if(isOpen)
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            _tableView.frame = CGRectMake(0, ItemHeight, 100, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            _tableView.frame = CGRectMake(0, ItemHeight, 100, ItemHeight * [_datas count]);
        } completion:^(BOOL finished) {
            
        }];
    }
    isOpen = !isOpen;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ByListSelectCell"];
    cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.3f animations:^{
        
        _tableView.frame = CGRectMake(0, ItemHeight, 100, 0);
    } completion:^(BOOL finished) {
        
    }];
    [_selectBtn setTitle:[_datas objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    isOpen = NO;
}

@end
