//
//  DetailViewController.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductModel.h"
#import "BottomTabView.h"

@interface DetailViewController : BaseViewController<ByNavigationBarDelegate,BottomTabViewDelegate>


+(void)show : (BaseViewController *)controller
      model : (ProductModel *) model;

@end
