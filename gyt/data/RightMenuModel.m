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
    [datas addObject:[RightMenuModel build:@"我的资金" image:@"ic_money"]];
//    [datas addObject:[RightMenuModel build:@"我的合约" image:@"ic_warncontract"]];
    [datas addObject:[RightMenuModel build:@"出入金管理" image:@"ic_money"]];
    [datas addObject:[RightMenuModel build:@"自选合约管理" image:@"ic_mycontract"]];
    [datas addObject:[RightMenuModel build:@"系统设置" image:@"ic_setting"]];
    [datas addObject:[RightMenuModel build:@"关于" image:@"ic_about"]];
    [datas addObject:[RightMenuModel build:@"退出帐号" image:@"ic_logout"]];

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
