//  出入金管理
//  MoneyManageViewController.h
//  gyt
//
//  Created by by.huang on 16/5/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"

@interface MoneyManageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CustomIOSAlertViewDelegate,UITextFieldDelegate>

+(void)show : (SlideNavigationController *)controller;

@end
