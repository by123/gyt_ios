//
//  PushRequestModel.h
//  gyt
//
//  Created by by.huang on 16/6/6.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushRequestModel : NSObject

@property (copy, nonatomic) NSString *sessionId;

@property (assign, nonatomic) int platformID;

@property (strong, nonatomic) NSMutableArray *market;

@property (strong, nonatomic) NSMutableArray *code;

@end
