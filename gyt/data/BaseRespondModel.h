//
//  BaseRespondModel.h
//  gyt
//
//  Created by by.huang on 16/5/13.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorModel.h"

@interface BaseRespondModel : NSObject

@property (assign, nonatomic) int status;

@property (strong, nonatomic) id params;

@property (strong, nonatomic) id response;

@property (strong, nonatomic) ErrorModel *error;


+(BaseRespondModel *) buildModel : (id)respondObject;

@end
