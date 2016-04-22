//
//  RightMenuModel.h
//  gyt
//
//  Created by by.huang on 16/4/22.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightMenuModel : NSObject

@property (copy , nonatomic) NSString *title;

@property (copy, nonatomic) NSString *imageStr;

+(NSMutableArray *)getDatas;


+(RightMenuModel *)build : (NSString *)title
                   image : (NSString *)imageStr;

@end
