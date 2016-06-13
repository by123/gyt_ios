//
//  ContractDB.h
//  gyt
//
//  Created by by.huang on 16/4/20.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushModel.h"

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
            model : (PushModel *)model;
//更新一条数据
-(BOOL)updateItem : (NSString *)tableName
     instrumentid : (NSString *)instrumentID
            model : (PushModel *)model;

//删除一条数据
-(BOOL)deleteItem : (NSString *)tableName
     instrumentid : (NSString *)instrumentID;
//查找所有
-(NSMutableArray *)queryAll : (NSString *)tableName;

//查找一条数据
-(PushModel *)queryItem : (NSString *)tableName
              instrumentid : (NSString *)instrumentID;
//



@end
