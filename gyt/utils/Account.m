//
//  Accout.m
//  haihua
//
//  Created by by.huang on 16/3/28.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "Account.h"

@implementation Account


SINGLETON_IMPLEMENTION(Account);


- (void)saveAccount : (NSString *)uid
          sessionid : (NSString *)sessionId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:uid forKey:UID];
    [userDefaults setValue:sessionId forKey:SESSIONID];

}


- (void)saveUid : (NSString *)uid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:uid forKey:UID];
}

-(void)savePassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:password forKey:PASSWORD];
}

- (void)saveSessionid : (NSString *)sessionId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:sessionId forKey:SESSIONID];
    
}

-(void)saveAccountInfo:(NSString *)accountInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:accountInfo forKey:ACCOUNTINFO];
}


- (BOOL)isLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefaults objectForKey:UID];
    NSString *sessionId= [userDefaults objectForKey:SESSIONID];
    if(!IS_NS_STRING_EMPTY(uid) && !IS_NS_STRING_EMPTY(sessionId))
    {
        return YES;
    }
    return NO;
}

- (NSString *)getUid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:UID];

}

-(NSString *)getPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:PASSWORD];
}

- (NSString *)getSessionId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:SESSIONID];
}

-(NSString *)getAccountInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accountInfo = [userDefaults objectForKey:ACCOUNTINFO];
    return accountInfo;
}
@end
