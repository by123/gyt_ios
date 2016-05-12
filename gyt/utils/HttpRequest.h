//
//  HttpRequest.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

SINGLETON_DECLARATION(HttpRequest);

typedef void (^SuccessCallback)(id responseObject);

typedef void (^FailCallback)(NSError *error);


-(void)post : (NSString *) jsonStr
       view : (UIView *)view
    success : (SuccessCallback)success
       fail : (FailCallback)fail;

@end
