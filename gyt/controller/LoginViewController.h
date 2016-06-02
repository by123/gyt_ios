//
//  LoginViewController.h
//  gyt
//
//  Created by by.huang on 16/5/11.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"
@interface LoginViewController : BaseViewController<SocketConnectDelegate,SlideNavigationControllerDelegate>

+(void)show : (BaseViewController *)controller;

@end

