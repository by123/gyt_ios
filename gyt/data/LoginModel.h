//
//  LoginModel.h
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (copy, nonatomic) NSString *sessionId;

@property (copy, nonatomic) NSString *strUserName;

@property (copy, nonatomic) NSString *strPassword;

@property (copy, nonatomic) NSString *strIpAddress;

@property (copy, nonatomic) NSString *strMACAdress;

@property (assign, nonatomic) int clientID;


@end
