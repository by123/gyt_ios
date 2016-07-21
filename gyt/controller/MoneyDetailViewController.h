//  我的资金详情
//  MoneyDetailViewController.h
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"
#import "TitleContentModel.h"
@interface MoneyDetailViewController : BaseViewController<ByNavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,PushDataHandleDelegate>

+(void)show : (SlideNavigationController *)controller;

@end
