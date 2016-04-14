//
//  MainTabelCell.h
//  gyt
//
//  Created by by.huang on 16/4/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ProductModel.h"
@interface MainTableCell : UITableViewCell

-(void)setData : (ProductModel *)model
        updown : (UpdownType) updownType
     inventore : (InventoryType) inventoryType;

+(NSString *)identify ;

@end
