//
//  DynamicCell.h
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealHoldModel.h"
#import "DealHoldingModel.h"
#import "DealHoldByModel.h"
#import "DealProfitModel.h"

@interface DynamicCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widths :(NSArray *)widths;



-(void)setHoldData : (DealHoldModel *)model
            maxWidth : (int)maxWidth;

-(void)setHoldingData : (DealHoldingModel *)model
             maxWidth : (int)maxWidth;

-(void)setHoldByData : (DealHoldByModel *)model
             maxWidth : (int)maxWidth;

-(void)setProfitData : (DealProfitModel *)model
             maxWidth : (int)maxWidth;


+(NSString *)identify ;

@end
