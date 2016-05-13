//
//  HttpRequest.m
//  gyt
//
//  Created by by.huang on 16/5/12.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "HttpRequest.h"
@implementation HttpRequest

SINGLETON_IMPLEMENTION(HttpRequest);


-(void)post : (NSString *) jsonStr
       view : (UIView *)view
    success : (SuccessCallback)success
       fail : (FailCallback)fail
{
    __weak MBProgressHUD *hua = [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Root_Url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Contsetent-Type"];
    [request setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    NSOperation *operation =[manager HTTPRequestOperationWithRequest:request
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *text = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"%@",[NSString stringWithFormat:@"网络请求－－－－－－－－－－－－－－－－－请求成功->%@",text]);
         success(responseObject);
         [hua setHidden:YES];
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"网络请求－－－－－－－－－－－－－－－－－请求失败!");
         fail(error);
         [hua setHidden:YES];
     }];
    [manager.operationQueue addOperation:operation];

}
@end
