//
//  SearchViewController.h
//  gyt
//
//  Created by by.huang on 16/4/27.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

+(void)show : (BaseViewController *)controller
      datas : (NSMutableArray *)datas;

@end
