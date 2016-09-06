//
//  TipsViewController.h
//  gyt
//
//  Created by by.huang on 16/9/1.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"


@interface TipsViewController : BaseViewController

@property (assign, nonatomic) TipsType type;

@property (copy, nonatomic) NSString *content;

+(void)show : (BaseViewController *)controller
      content : (NSString *) content
        type : (TipsType)type;

@end
