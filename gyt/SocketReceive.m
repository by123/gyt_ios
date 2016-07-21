//
//  SocketReceive.m
//  gyt
//
//  Created by by.huang on 16/7/21.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "SocketReceive.h"
#import "PushModel.h"

@implementation SocketReceive

SINGLETON_IMPLEMENTION_N(SocketReceive)

-(void)regiseterSocketReceive;
{
    [[SocketConnect sharedSocketConnect]setDelegate:self];
}

-(void)unRegisterSocketReceive
{
//    [[SocketConnect sharedSocketConnect]setDelegate:nil];
}


-(void)OnReceiveSuccess:(id)respondObject
{
    PackageModel *packageModel = respondObject;
    BaseRespondModel *respondModel = [BaseRespondModel buildModel:respondObject];
    if(packageModel.cmd == NET_CMD_NOTIFICATION)
    {
        //行情主推
        if([respondModel.method isEqualToString:PushQuoteData])
        {
            id params = respondModel.params;
            id data  = [params objectForKey:@"data"];
            PushModel *pushModel = [PushModel mj_objectWithKeyValues:data];
            [self sendReciveData:pushModel name:PushQuoteData];
        }
    }
}

-(void)OnReceiveFail:(NSError *)error
{
    
}


-(void)sendReciveData : (id)data
                 name : (NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:data];
}

@end
