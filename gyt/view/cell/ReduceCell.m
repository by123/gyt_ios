//
//  GetCashCell.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ReduceCell.h"
#import "InsetTextField.h"

@interface ReduceCell()

@property (strong, nonatomic) InsetTextField *insetTextField;

@end

@implementation ReduceCell


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
    _insetTextField = [[InsetTextField alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 40)];
    _insetTextField.hasTitle = YES;
    _insetTextField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_insetTextField];
}

-(void)setData : (TitleContentModel *)model
{
    [_insetTextField setInsetTitle:model.title font:[UIFont systemFontOfSize:14.f]];
    
}

+(NSString *)identify
{
    return @"ReduceCell";
}
@end
