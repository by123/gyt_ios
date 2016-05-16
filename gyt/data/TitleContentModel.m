//
//  MoneyModel.m
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "TitleContentModel.h"

@implementation TitleContentModel

+(TitleContentModel *)buildData : (NSString *)title
                 content : (NSString *)content
{
    TitleContentModel *model = [[TitleContentModel alloc]init];
    model.title = title;
    model.content = content;
    return model;
}
@end
