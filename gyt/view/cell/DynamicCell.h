//
//  DynamicCell.h
//  gyt
//
//  Created by by.huang on 16/4/19.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widths :(NSArray *)widths;

-(void)setData : (NSMutableArray *)array
      maxWidth : (int)maxWidth;

+(NSString *)identify ;

@end
