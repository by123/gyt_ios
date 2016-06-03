//
//  PackageModel.h
//  gyt
//
//  Created by by.huang on 16/6/1.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageModel : NSObject

@property (assign, nonatomic) uint32_t len;

@property (assign, nonatomic) int64_t seq;

@property (assign, nonatomic) uint16_t cmd;

@property (assign, nonatomic) uint16_t tag;

@property (strong, nonatomic) id result;

@end
