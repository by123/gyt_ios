//
//  Test.h
//  gyt
//
//  Created by by.huang on 16/6/16.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

SINGLETON_DECLARATION(Test);

@property (strong, nonatomic) NSString *host;

@property (assign, nonatomic) int port;


@end
