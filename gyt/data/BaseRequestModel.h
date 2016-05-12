//
//  BaseRequestModel.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequestModel : NSObject

@property (copy, nonatomic) NSString *rpcname;

@property (strong, nonatomic) NSMutableDictionary *rpcparams;

@end
