//
//  GetCashCell.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ReduceCell.h"
#import "InsetTextField.h"
#import "ByListDialog.h"
#import "AccessGoldModel.h"


@interface ReduceCell()

@property (strong, nonatomic) InsetTextField *insetTextField;

@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIView *rootView;

typedef void (^ReduceCellBlock)(ReduceCell *cell);


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
    _insetTextField.textAlignment = NSTextAlignmentCenter;
    _insetTextField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_insetTextField];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 40)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _button.layer.borderColor = [[UIColor blackColor] CGColor];
    _button.layer.borderWidth = 0.5;
    _button.layer.cornerRadius = 2;
    _button.layer.masksToBounds = YES;
    [_button setHidden:YES];
    [_button addTarget:self action:@selector(OnClickList:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];
}


-(void)OnClickList : (id)sender
{
    if(_button.tag == 0)
    {
      
        NSMutableArray *array = [[NSMutableArray alloc]init];;
        
        for(int i = 1 ; i<= 13; i ++)
        {
            NSString *temp =  [AccessGoldModel getMoneyType:i];
            [array addObject:temp];
        }
        ByListDialog *dialog = [[ByListDialog alloc]initWithData:array];
        dialog.delegate = self;
        dialog.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.rootView addSubview:dialog];
    }
}

-(void)OnListDialogItemClick:(id)data
{
    NSString *title = data;
    [_button setTitle:title forState:UIControlStateNormal];
}

-(void)setData : (TitleContentModel *)model
      rootView : (UIView *)rootView
{
    self.rootView = rootView;
    if(model.canList)
    {
        [_button setHidden:NO];
        _button.tag = 0;
        [_insetTextField setInsetTitle:model.title font:[UIFont systemFontOfSize:14.f]];
        [_insetTextField setInsetImage:[UIImage imageNamed:@"ic_arrow_down"]];
    }
    else
    {
        [_button setHidden:YES];
        [_insetTextField setInsetTitle:model.title font:[UIFont systemFontOfSize:14.f]];
    }
    
}



+(NSString *)identify
{
    return @"ReduceCell";
}
@end
