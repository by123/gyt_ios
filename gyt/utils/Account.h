//
//  Accout.h
//  haihua
//
//  Created by by.huang on 16/3/28.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACCOUNT_INFO_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account_info.data"]

#define UID @"gyt_uid"
#define PASSWORD @"gyt_password"
#define SESSIONID @"gyt_sessionid"
#define ACCOUNTINFO @"gyt_accountinfo"

@interface Account : NSObject

@property (assign, nonatomic) Boolean autoLogin;

SINGLETON_DECLARATION(Account);

- (void)saveAccount : (NSString *)uid
          sessionid : (NSString *)sessionId;

- (void)saveUid : (NSString *)uid;

- (void)saveSessionid : (NSString *)sessionId;

-(void)saveAccountInfo : (NSString *)accountInfo;

-(void)savePassword : (NSString *)password;

- (BOOL)isLogin;

- (NSString *)getUid;

- (NSString *)getSessionId;

- (NSString *)getAccountInfo;

- (NSString *)getPassword;



@end
