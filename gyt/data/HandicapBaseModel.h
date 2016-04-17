//
//  HandicapBaseModel.h
//  gyt
//
//  Created by by.huang on 16/4/17.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandicapBaseModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *value;

+(HandicapBaseModel *) build : (NSString *)title
                       value : (NSString *)value;
@end
