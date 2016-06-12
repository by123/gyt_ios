//  入金界面
//  AddViewController.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface AddViewController : BaseViewController<ByNavigationBarDelegate,UIWebViewDelegate>

+(void)show : (BaseViewController *)controller
       type : (CashType) type;

@end
