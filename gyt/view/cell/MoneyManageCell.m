//
//  MoneyManageCell.m
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "MoneyManageCell.h"

@interface MoneyManageCell()

@property (strong, nonatomic) UIButton *rootView;

//流水号
@property (strong , nonatomic) UILabel *idNumLabel;

//出/入金金额
@property (strong , nonatomic) UILabel *goldLabel;

//币种
@property (strong , nonatomic) UILabel *goldTypeLabel;

//申请日期
@property (strong , nonatomic) UILabel *dateLabel;

//申请状态
@property (strong , nonatomic) UILabel *statuLabel;

@end

@implementation MoneyManageCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.backgroundColor = [UIColor clearColor];
    
    _rootView = [[UIButton alloc]init];
    [_rootView setBackgroundImage:[AppUtil imageWithColor:[ColorUtil colorWithHexString:@"#444444"]] forState:UIControlStateNormal];
    [_rootView setBackgroundImage:[AppUtil imageWithColor:SELECT_COLOR] forState:UIControlStateSelected];
    _rootView.frame = CGRectMake(10, 10, SCREEN_WIDTH -20 , 100);
    _rootView.userInteractionEnabled = NO;
    [self.contentView addSubview:_rootView];
    
    _idNumLabel = [[UILabel alloc]init];
    [self setProperty:_idNumLabel];
    [_rootView addSubview:_idNumLabel];
    
    _goldLabel = [[UILabel alloc]init];
    [self setProperty:_goldLabel];
    [_rootView addSubview:_goldLabel];
    
    _goldTypeLabel = [[UILabel alloc]init];
    [self setProperty:_goldTypeLabel];
    [_rootView addSubview:_goldTypeLabel];
    
    _dateLabel = [[UILabel alloc]init];
    [self setProperty:_dateLabel];
    [_rootView addSubview:_dateLabel];
    
    _statuLabel = [[UILabel alloc]init];
    [self setProperty:_statuLabel];
    [_rootView addSubview:_statuLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 35, SCREEN_WIDTH - 20, 0.5);
    lineView.backgroundColor = LINE_COLOR;
    [_rootView addSubview:lineView];
}


-(void)setRootViewSelect : (BOOL)isSelect
{
    [_rootView setSelected:isSelect];
}

-(void)setProperty : (UILabel *)label
{
    label.textColor = TEXT_COLOR;
    label.font = [UIFont systemFontOfSize:13.0f];
}

-(void)setData : (AccessGoldModel *)model
{
    //流水号
    _idNumLabel.text = [NSString stringWithFormat:@"流水号：%@",model.m_strSerialNo];
    _idNumLabel.frame = CGRectMake(5, 10, _idNumLabel.contentSize.width, _idNumLabel.contentSize.height);
    
    //出入金
    _goldLabel.text = [NSString stringWithFormat:@"%@：%f",[Constant getCashType:model.m_nCashType],model.m_dCashValue];
    _goldLabel.frame = CGRectMake(5, 45, _goldLabel.contentSize.width, _goldLabel.contentSize.height);
    
    
    //币种
    _goldTypeLabel.text = [NSString stringWithFormat:@"币种：%@",[Constant getMoneyType:model.m_nMoneyType]];
    _goldTypeLabel.frame = CGRectMake(SCREEN_WIDTH -25- _goldTypeLabel.contentSize.width , 45, _goldTypeLabel.contentSize.width, _goldTypeLabel.contentSize.height);
    
    //申请日期
    _dateLabel.text =[NSString stringWithFormat:@"%@ %@",[AppUtil getFormatDate:model.m_applyDate], [AppUtil getFormatTime:model.m_applyTime]];
    _dateLabel.frame = CGRectMake(5, 70, _dateLabel.contentSize.width, _dateLabel.contentSize.height);
    
    //状态
    _statuLabel.text = [NSString stringWithFormat:@"状态：%@",[Constant getCashApplicationStatus:model.m_nStatus]];
    _statuLabel.frame = CGRectMake(SCREEN_WIDTH - 25 - _statuLabel.contentSize.width, 70, _statuLabel.contentSize.width, _statuLabel.contentSize.height);
    


}

+(NSString *)identify
{
    return @"MoneyManageCell";
}

@end
