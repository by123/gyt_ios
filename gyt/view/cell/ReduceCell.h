//
//  GetCashCell.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"
#import "ByListDialog.h"

@interface ReduceCell : UITableViewCell<ListDialogDelegate>

-(void)setData : (TitleContentModel *)model
    rootView : (UIView *)rootView;

+(NSString *)identify;

@end
