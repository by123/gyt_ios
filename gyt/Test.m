//
//  Test.m
//  gyt
//
//  Created by by.huang on 16/6/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "Test.h"

@implementation Test

SINGLETON_IMPLEMENTION(Test);

-(instancetype)init
{
    if(self == [super init])
    {
        self.host = Host;
        self.port = Port;
    }
    return self;
}



@end
