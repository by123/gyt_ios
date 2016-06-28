//
//  ManageViewController.h
//  gyt
//
//  Created by by.huang on 16/6/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"

@interface ManageViewController : BaseViewController<SocketConnectDelegate>

+(void)show : (SlideNavigationController *)controller;

@end
