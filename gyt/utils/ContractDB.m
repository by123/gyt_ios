
//
//  ContractDB.m
//  gyt
//
//  Created by by.huang on 16/4/20.
//  Copyright © 2016年 by.huang. All rights reserved.
//

#import "ContractDB.h"
#import <FMDatabase.h>

#define DBName @"contract.db"
#define Item_ID @"id"
#define Item_ProductID @"pid"
#define Item_Name @"name"
#define Item_RecentPrice @"recent"
#define Item_UpdownPrice @"price"
#define Item_UpdownPercent @"percent"
#define Item_Inventory @"inventory"
#define Item_DailyInventory @"daily"
#define Item_DealInventory @"deal"
#define Item_MyContract @"mycontract"

@interface ContractDB()

@property (strong, nonatomic)FMDatabase *db;

@end

@implementation ContractDB

SINGLETON_IMPLEMENTION(ContractDB);


#pragma mark 创建数据库
-(BOOL)createDB
{
    _db = [FMDatabase databaseWithPath:[self getDBPath]];
    if (![_db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    [self createTable : DBMyContractTable];
    [self createTable : DBHistoryContractTable];
    [self createTable : DBWarnContractTable];
    return YES;
}

#pragma mark 删除数据库
-(void)deleteDB : (NSString *)tableName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:DBName error:nil];
}

#pragma mark 创建表
-(BOOL)createTable : (NSString *)tableName
{
    BOOL res;
    if ([_db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT)" ,
             tableName,
             Item_ID,
             Item_ProductID,
             Item_Name,
             Item_RecentPrice,
             Item_UpdownPrice,
             Item_UpdownPercent,
             Item_Inventory,
             Item_DailyInventory,
             Item_DealInventory,
             Item_MyContract];
        res = [_db executeUpdate:sqlCreateTable];
    }
    if(res)
    {
        NSLog(@"创建表成功！");
    }
    else
    {
        NSLog(@"创建表失败！");
    }
    return res;
}

#pragma mark 删除表
-(BOOL)deleteTable : (NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
   return [_db executeUpdate:sql];
}

#pragma mark 插入一条数据
-(BOOL)insertItem : (NSString *)tableName
            model : (ProductModel *)model
{
    BOOL res;
    if([self queryItem:tableName pid:model.pid] != nil)
    {
        NSLog(@"数据库已有数据！");
        return NO;
    }
    if([_db open])
    {
        [_db beginTransaction];
        res = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ VALUES (?,?,?,?,?,?,?,?,?,?)",tableName],
               NULL,
               [NSString stringWithFormat:@"%d",model.pid],
               [NSString stringWithFormat:@"%@",model.name],
               [NSString stringWithFormat:@"%f",model.recentPrice],
               [NSString stringWithFormat:@"%f",model.updownPrice],
               [NSString stringWithFormat:@"%f",model.updownPercent],
               model.inventory,
               model.dailyInventory,
               model.dealInventory,
               [NSString stringWithFormat:@"%d",model.isMyContract]
               ];
        [_db commit];
        [_db close];
    }
    if(res)
    {
        NSLog(@"添加数据成功！");
    }
    else
    {
        NSLog(@"添加数据失败！");
    }
    return res;
}

#pragma mark 更新一条数据
-(BOOL)updateItem : (NSString *)tableName
              pid : (int)pid
            model : (ProductModel *)model
{
    BOOL res;
    if([_db open])
    {
        [_db beginTransaction];
        res = [_db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? ,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ? WHERE %@ = ?",tableName,
                                  Item_Name,
                                  Item_RecentPrice,
                                  Item_UpdownPrice,
                                  Item_UpdownPercent,
                                  Item_Inventory,
                                  Item_DailyInventory,
                                  Item_DealInventory,
                                  Item_MyContract,
                                  Item_ProductID
                                  ],
               [NSString stringWithFormat:@"%@",model.name],
               [NSString stringWithFormat:@"%f",model.recentPrice],
               [NSString stringWithFormat:@"%f",model.updownPrice],
               [NSString stringWithFormat:@"%f",model.updownPercent],
               model.inventory,
               model.dailyInventory,
               model.dealInventory,
               [NSString stringWithFormat:@"%d",model.isMyContract],
               [NSString stringWithFormat:@"%d",model.pid]];        
        [_db commit];
        [_db close];
    }
    if(res)
    {
        NSLog(@"更新数据成功！");
    }
    else
    {
        NSLog(@"更新数据失败！");
    }
    return res;

}

#pragma mark 删除一条数据
-(BOOL)deleteItem : (NSString *)tableName
              pid : (int)pid
{
    BOOL res;
    if([_db open])
    {
        res = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,Item_ProductID],[NSString stringWithFormat:@"%d",pid]];
        [_db close];
    }
    if(res)
    {
        NSLog(@"删除数据成功！");
    }
    else
    {
        NSLog(@"删除数据失败！");
    }
    return res;
}

#pragma mark 查找所有
-(NSMutableArray *)queryAll : (NSString *)tableName
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if([_db open])
    {
        FMResultSet *s = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        while ([s next]) {
            ProductModel *model = [[ProductModel alloc]init];
            model.pid = [s intForColumn:Item_ProductID];
            model.name = [s stringForColumn:Item_Name];
            model.recentPrice = [s doubleForColumn:Item_RecentPrice];
            model.updownPrice = [s doubleForColumn:Item_UpdownPrice];
            model.updownPercent = [s doubleForColumn:Item_UpdownPercent];
            model.inventory = [s stringForColumn:Item_Inventory];
            model.dailyInventory = [s stringForColumn:Item_DailyInventory];
            model.dealInventory = [s stringForColumn:Item_DealInventory];
            model.isMyContract = [s boolForColumn:Item_MyContract];
            [array addObject:model];
        }
        [_db close];
    }
    return array;
}

#pragma mark 查找一条数据
-(ProductModel *)queryItem : (NSString *)tableName
                       pid : (int)pid
{
    ProductModel *model = nil;
    if([_db open])
    {
        FMResultSet *s = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        while ([s next]) {
            if(pid == [s intForColumn:Item_ProductID])
            {
                model = [[ProductModel alloc]init];
                model.pid = [s intForColumn:Item_ProductID];
                model.name = [s stringForColumn:Item_Name];
                model.recentPrice = [s doubleForColumn:Item_RecentPrice];
                model.updownPrice = [s doubleForColumn:Item_UpdownPrice];
                model.updownPercent = [s doubleForColumn:Item_UpdownPercent];
                model.inventory = [s stringForColumn:Item_Inventory];
                model.dailyInventory = [s stringForColumn:Item_DailyInventory];
                model.dealInventory = [s stringForColumn:Item_DealInventory];
                model.isMyContract = [s boolForColumn:Item_MyContract];
                break;
            }
        }
        [_db close];
    }
    return model;
}

#pragma mark 获取数据库地址
-(NSString *)getDBPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:DBName];
    return DBPath;
}

@end
