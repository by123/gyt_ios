//
//  SearchCell.h
//  gyt
//
//  Created by by.huang on 16/4/28.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushModel.h"

@interface SearchCell : UITableViewCell


-(void)setData : (PushModel *)model;

+(NSString *)identify;

@end
