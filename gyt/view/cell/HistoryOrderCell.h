//
//  HistoryCell.h
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryOrderModel.h"

@interface HistoryOrderCell : UITableViewCell

-(void)setData : (HistoryOrderModel *)model;

+(NSString *)identify;

@end
