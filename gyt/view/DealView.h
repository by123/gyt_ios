//
//  DealView.h
//  gyt
//
//  Created by by.huang on 16/4/18.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByTabView.h"
#import "ProductModel.h"
@interface DealView : UIView<ByTabViewDelegate,UIAlertViewDelegate>

-(instancetype)initWithData : (CGRect)frame
              model : (ProductModel *)model;
@end
