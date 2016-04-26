//
//  NewsModel.h
//  gyt
//
//  Created by by.huang on 16/4/26.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

//新闻id
@property (assign , nonatomic) int nid;

//标题
@property (copy, nonatomic) NSString *title;

//内容
@property (copy, nonatomic) NSString *content;

//时间
@property (copy , nonatomic) NSString *time;

//来自
@property (copy, nonatomic) NSString *from;

@end
