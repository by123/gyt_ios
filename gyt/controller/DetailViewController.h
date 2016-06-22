//
//  DetailViewController.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "PushModel.h"
#import "BottomTabView.h"
#import "TimeView.h"

@interface DetailViewController : BaseViewController<ByNavigationBarDelegate,BottomTabViewDelegate,TimeViewDelegate>


+(void)show : (BaseViewController *)controller
      model : (PushModel *) model
   position : (NSInteger)position;

@end
