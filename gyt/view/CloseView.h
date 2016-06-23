//
//  CloseView.h
//  gyt
//
//  Created by by.huang on 16/6/23.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealHoldModel.h"

@interface CloseView : UIView

-(instancetype)initWithView : (UIView *)parentView
                      model : (DealHoldModel *)model;
@end
