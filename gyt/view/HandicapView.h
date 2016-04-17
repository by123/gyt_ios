//
//  HandicapView.h
//  gyt
//
//  Created by by.huang on 16/4/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTopHeight 35
#define kContentHeight SCREEN_HEIGHT - NavigationBar_HEIGHT - StatuBar_HEIGHT - kTopHeight - 40
#define KTabHeight 25

@interface HandicapView : UIView<UITableViewDelegate,UITableViewDataSource>

@end
