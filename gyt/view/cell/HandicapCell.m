//
//  HandicapCell.m
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HandicapCell.h"

@interface HandicapCell()

@property (strong, nonatomic) UILabel *label1;

@property (strong, nonatomic) UILabel *label2;

@property (strong, nonatomic) UILabel *label3;

@property (strong, nonatomic) UILabel *label4;

@property (strong, nonatomic) UILabel *label5;

@property (strong, nonatomic) UIView *lineView;

@end
@implementation HandicapCell


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
    self.backgroundColor = MAIN_COLOR;
    _label1 = [[UILabel alloc]init];
    _label1.textColor = [UIColor whiteColor];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_label1];
    
    _label2 = [[UILabel alloc]init];
    _label2.textColor = [UIColor whiteColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_label2];
    
    _label3 = [[UILabel alloc]init];
    _label3.textColor = [UIColor whiteColor];
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_label3];
    
    _label4 = [[UILabel alloc]init];
    _label4.textColor = [UIColor whiteColor];
    _label4.textAlignment = NSTextAlignmentCenter;
    _label4.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_label4];
    
    _label5 = [[UILabel alloc]init];
    _label5.textColor = [UIColor whiteColor];
    _label5.textAlignment = NSTextAlignmentCenter;
    _label5.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_label5];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = LINE_COLOR;
    _lineView.frame =CGRectMake(0, self.contentView.height - 0.5, SCREEN_WIDTH, 0.5);
    [self.contentView addSubview:_lineView];
}

-(void)setData : (HandicapModel *)model
{
    _label1.text = model.model1.title;
    _label1.frame = CGRectMake(10, 0, _label1.contentSize.width, self.contentView.height);
    
    _label2.text = model.model1.value;
    _label2.frame = CGRectMake(SCREEN_WIDTH / 2 -80, 0, _label2.contentSize.width, self.contentView.height);
    
    _label3.text = model.model2.title;
    _label3.frame = CGRectMake(SCREEN_WIDTH / 2 , 0, _label3.contentSize.width, self.contentView.height);
    
    _label4.text = model.model2.value;
    _label4.frame = CGRectMake(SCREEN_WIDTH- 10 - _label4.contentSize.width, 0,  _label4.contentSize.width, self.contentView.height);
}


-(void)setDetailData : (HandicapModel *)model
             isTitle : (BOOL) isTitle
{
    if(isTitle)
    {
        _label1.text = model.detailModel.timeStamp;
    }
    else
    {
        _label1.text = [self formatTime:model.detailModel.timeStamp];
    }
    _label1.frame = CGRectMake(0, 0,SCREEN_WIDTH * 2/7, self.contentView.height);
    
    _label2.text = model.detailModel.price;
    _label2.frame = CGRectMake(SCREEN_WIDTH * 2/7, 0,SCREEN_WIDTH * 2/7, self.contentView.height);

    _label3.text = model.detailModel.handNow;
    _label3.frame = CGRectMake(SCREEN_WIDTH * 4/7, 0,SCREEN_WIDTH * 1/7, self.contentView.height);

    _label4.text = model.detailModel.hold;
    _label4.frame = CGRectMake(SCREEN_WIDTH * 5/7, 0,SCREEN_WIDTH * 1/7, self.contentView.height);
    
    _label5.text = model.detailModel.kaiping;
    _label5.frame = CGRectMake(SCREEN_WIDTH * 6/7, 0,SCREEN_WIDTH * 1/7, self.contentView.height);

}

-(NSString *)formatTime : (NSString *)timeStamp
{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+(NSString *)identify
{
    return @"HandicapCell";
}

@end
