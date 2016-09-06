//
//  ByListSelect.h
//  gyt
//
//  Created by by.huang on 16/8/31.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ByListSelect : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *datas;

@property (copy, nonatomic) NSString *title;

-(instancetype)initWithDatas : (NSMutableArray *)datas
                       title : (NSString *)title;

@end
