//
//  HandicapCell.h
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandicapModel.h"
@interface HandicapCell : UITableViewCell

-(void)setData : (HandicapModel *)model;

-(void)setDetailData : (HandicapModel *)model
             isTitle : (BOOL) isTitle;

+(NSString *)identify ;

@end
