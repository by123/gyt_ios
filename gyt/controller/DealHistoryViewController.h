//
//  DealHistoryViewController.h
//  gyt
//
//  Created by by.huang on 16/8/24.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"

@interface DealHistoryViewController : BaseViewController<CustomIOSAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

+(void)show : (SlideNavigationController *)controller;

@end
