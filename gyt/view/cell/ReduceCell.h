//
//  GetCashCell.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"

@interface ReduceCell : UITableViewCell

-(void)setData : (TitleContentModel *)model;

+(NSString *)identify;

@end
