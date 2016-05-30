//
//  QueryRequestModel.m
//  gyt
//
//  Created by by.huang on 16/5/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "QueryRequestModel.h"

@implementation QueryRequestModel

-(instancetype)init
{
    if(self == [super init])
    {
        NSString *accountInfoStr =  [[Account sharedAccount] getAccountInfo];
        UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:accountInfoStr];
        self.account = model;
    }
    return self;
}
@end
