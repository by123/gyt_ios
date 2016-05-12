//
//  RightMenuModel.m
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "RightMenuModel.h"

@implementation RightMenuModel

+(NSMutableArray *)getDatas
{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[RightMenuModel build:@"自选合约管理" image:@"ic_mycontract"]];
    [datas addObject:[RightMenuModel build:@"价格预警管理" image:@"ic_warncontract"]];
    [datas addObject:[RightMenuModel build:@"系统设置" image:@"ic_setting"]];
    [datas addObject:[RightMenuModel build:@"关于" image:@"ic_about"]];
    [datas addObject:[RightMenuModel build:@"退出帐号" image:@"ic_logout"]];
    [datas addObject:[RightMenuModel build:@"登录" image:@"ic_about"]];

    return datas;
}

+(RightMenuModel *)build : (NSString *)title
                   image : (NSString *)imageStr
{
    RightMenuModel *model = [[RightMenuModel alloc]init];
    model.title = title;
    model.imageStr = imageStr;
    return model;
}

@end
