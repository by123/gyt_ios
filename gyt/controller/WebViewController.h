//
//  WebViewController.h
//  gyt
//
//  Created by by.huang on 16/8/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>

@property (copy, nonatomic) NSString *titleStr;

@property (copy, nonatomic) NSString *webUrl;

+(void)show : (BaseViewController *)controller
      title : (NSString *) titleStr
        url : (NSString *)webUrl;

@end
