//
//  MoneyModel.h
//  gyt
//
//  Created by by.huang on 16/5/14.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleContentModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *content;

+(TitleContentModel *)buildData : (NSString *)title
                 content : (NSString *)content;

@end
