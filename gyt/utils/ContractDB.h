//
//  ContractDB.h
//  gyt
//
//  Created by by.huang on 16/4/20.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

#define DBMyContractTable @"mycontract"
#define DBHistoryContractTable @"historycontract"
#define DBWarnContractTable @"warncontract"
#define DBSearchContractTable @"searchcontract"

@interface ContractDB : NSObject

SINGLETON_DECLARATION(ContractDB);

//创建数据库
-(BOOL)createDB;

//删除数据库
-(void)deleteDB : (NSString *)tableName;

//创建表
-(BOOL)createTable : (NSString *)tableName;

//删除表
-(BOOL)deleteTable : (NSString *)tableName;

//插入一条数据
-(BOOL)insertItem : (NSString *)tableName
            model : (ProductModel *)model;
//更新一条数据
-(BOOL)updateItem : (NSString *)tableName
              pid : (int)pid
            model : (ProductModel *)model;

//删除一条数据
-(BOOL)deleteItem : (NSString *)tableName
              pid : (int)pid;
//查找所有
-(NSMutableArray *)queryAll : (NSString *)tableName;

//查找一条数据
-(ProductModel *)queryItem : (NSString *)tableName
                       pid : (int)pid;
//



@end
