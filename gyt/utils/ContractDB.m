
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
#define Item_ExchangeID @"m_strExchangeID"
#define Item_ExchangeName @"m_strExchangeName"
#define Item_ProductID @"m_strProductID"
#define Item_ProductName @"m_strProductName"
#define Item_InstrumentID @"m_strInstrumentID"
#define Item_InstrumentName @"m_strInstrumentName"
#define Item_ExpireDate @"m_strExpireDate"
#define Item_AllowTrade @"m_bAllowTrade"
#define Item_volumeMultiple @"m_volumeMultiple"
#define Item_preClose @"m_preClose"
#define Item_moneyType @"m_moneyType"
#define Item_LastSettlementPrice @"m_dLastSettlementPrice"
#define Item_UpStopPrice @"m_dUpStopPrice"
#define Item_DownStopPrice @"m_dDownStopPrice"
#define Item_IsMain @"m_nIsMain"
#define Item_DealVolum @"m_lDealVolum"
#define Item_PriceTick @"m_dPriceTick"
#define Item_LastPrice @"m_dLastPrice"
#define Item_OpenPrice @"m_dOpenPrice"
#define Item_Volume @"m_nVolume"
#define Item_MyContract @"isMyContract"


//#define Item_ProductID @"pid"
//#define Item_Name @"name"
//#define Item_RecentPrice @"recent"
//#define Item_UpdownPrice @"price"
//#define Item_UpdownPercent @"percent"
//#define Item_Inventory @"inventory"
//#define Item_DailyInventory @"daily"
//#define Item_DealInventory @"deal"
//#define Item_MyContract @"mycontract"



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
    [self createTable : DBSearchContractTable];
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
    BOOL res = NO;
    if ([_db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT,'%@' TEXT)" ,
             tableName,
             Item_ID,
             Item_ExchangeID,
             Item_ExchangeName,
             Item_ProductID,
             Item_ProductName,
             Item_InstrumentID,
             Item_InstrumentName,
             Item_ExpireDate,
             Item_AllowTrade,
             Item_volumeMultiple,
             Item_preClose,
             Item_moneyType,
             Item_LastSettlementPrice,
             Item_UpStopPrice,
             Item_DownStopPrice,
             Item_IsMain,
             Item_DealVolum,
             Item_PriceTick,
             Item_LastPrice,
             Item_OpenPrice,
             Item_Volume,
             Item_MyContract
];
        

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
    BOOL res = NO;
    if([_db open])
    {
        NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
        res = [_db executeUpdate:sql];
        [_db close];
    }
    return res;
}

#pragma mark 插入一条数据
-(BOOL)insertItem : (NSString *)tableName
            model : (PushModel *)model
{
    BOOL res = NO;
    if([self queryItem:tableName instrumentid:model.m_strInstrumentID] != nil)
    {
        NSLog(@"数据库已有数据！");
        return NO;
    }
    if([_db open])
    {
        [_db beginTransaction];
        res = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",tableName],
               NULL,
               model.m_strExchangeID,
               model.m_strExchangeName,
               model.m_strProductID,
               model.m_strProductName,
               model.m_strInstrumentID,
               model.m_strInstrumentName,
               model.m_strExpireDate,
               [NSString stringWithFormat:model.m_bAllowTrade ? @"YES": @"NO"],
               [NSString stringWithFormat:@"%d",model.m_volumeMultiple],
               [NSString stringWithFormat:@"%f",model.m_preClose],
               [NSString stringWithFormat:@"%ld",(long)model.m_moneyType],
               [NSString stringWithFormat:@"%f",model.m_dLastSettlementPrice],
               [NSString stringWithFormat:@"%f",model.m_dUpStopPrice],
               [NSString stringWithFormat:@"%f",model.m_dDownStopPrice],
               [NSString stringWithFormat:@"%d",model.m_nIsMain],
               [NSString stringWithFormat:@"%ld",model.m_lDealVolum],
               [NSString stringWithFormat:@"%f",model.m_dPriceTick],
               [NSString stringWithFormat:@"%f",model.m_dLastPrice],
               [NSString stringWithFormat:@"%f",model.m_dOpenPrice],
               [NSString stringWithFormat:@"%d",model.m_nVolume],
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
     instrumentid : (NSString *)instrumentID
            model : (PushModel *)model
{
    if([self queryItem:tableName instrumentid:model.m_strInstrumentID] == nil)
    {
        NSLog(@"数据不存在！");
        return NO;
    }
    BOOL res = NO;
    if([_db open])
    {
        [_db beginTransaction];
        res = [_db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? ,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ? ,%@ = ? WHERE %@ = ?",tableName,
              Item_ExchangeID,
              Item_ExchangeName,
              Item_ProductID,
              Item_ProductName,
              Item_InstrumentID,
              Item_InstrumentName,
              Item_ExpireDate,
              Item_AllowTrade,
              Item_volumeMultiple,
              Item_preClose,
              Item_moneyType,
              Item_LastSettlementPrice,
              Item_UpStopPrice,
              Item_DownStopPrice,
              Item_IsMain,
              Item_DealVolum,
              Item_PriceTick,
              Item_LastPrice,
              Item_OpenPrice,
              Item_Volume,
              Item_MyContract,
              Item_InstrumentID
              ],
               model.m_strExchangeID,
               model.m_strExchangeName,
               model.m_strProductID,
               model.m_strProductName,
               model.m_strInstrumentID,
               model.m_strInstrumentName,
               model.m_strExpireDate,
               [NSString stringWithFormat:model.m_bAllowTrade ? @"YES": @"NO"],
               [NSString stringWithFormat:@"%d",model.m_volumeMultiple],
               [NSString stringWithFormat:@"%f",model.m_preClose],
               [NSString stringWithFormat:@"%ld",(long)model.m_moneyType],
               [NSString stringWithFormat:@"%f",model.m_dLastSettlementPrice],
               [NSString stringWithFormat:@"%f",model.m_dUpStopPrice],
               [NSString stringWithFormat:@"%f",model.m_dDownStopPrice],
               [NSString stringWithFormat:@"%d",model.m_nIsMain],
               [NSString stringWithFormat:@"%ld",model.m_lDealVolum],
               [NSString stringWithFormat:@"%f",model.m_dPriceTick],
               [NSString stringWithFormat:@"%f",model.m_dLastPrice],
               [NSString stringWithFormat:@"%f",model.m_dOpenPrice],
               [NSString stringWithFormat:@"%d",model.m_nVolume],
               [NSString stringWithFormat:@"%d",model.isMyContract],
               [NSString stringWithFormat:@"%@",model.m_strInstrumentID]];
        [_db commit];
        [_db close];
    }
    if(res)
    {
//        NSLog(@"更新数据成功！");
    }
    else
    {
        NSLog(@"更新数据失败！");
    }
    return res;

}

#pragma mark 删除一条数据
-(BOOL)deleteItem : (NSString *)tableName
     instrumentid : (NSString *)instrumentID
{
    if([self queryItem:tableName instrumentid:instrumentID] == nil)
    {
        NSLog(@"数据不存在！");
        return NO;
    }
    BOOL res = NO;
    if([_db open])
    {
        res = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,Item_InstrumentID],[NSString stringWithFormat:@"%@",instrumentID]];
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
            PushModel *model = [[PushModel alloc]init];
            model.m_strExchangeID = [s stringForColumn:Item_ExchangeID];
            model.m_strExchangeName = [s stringForColumn:Item_ExchangeName];
            model.m_strProductID = [s stringForColumn:Item_ProductID];
            model.m_strProductName = [s stringForColumn:Item_ProductName];
            model.m_strInstrumentID = [s stringForColumn:Item_InstrumentID];
            model.m_strInstrumentName = [s stringForColumn:Item_InstrumentName];
            model.m_strExpireDate = [s stringForColumn:Item_ExpireDate];
            model.m_bAllowTrade = [s boolForColumn:Item_AllowTrade];
            model.m_volumeMultiple = [s intForColumn:Item_volumeMultiple];
            model.m_preClose = [s doubleForColumn:Item_preClose];
            model.m_moneyType = [s intForColumn:Item_moneyType];
            model.m_dLastSettlementPrice = [s doubleForColumn:Item_LastSettlementPrice];
            model.m_dUpStopPrice = [s doubleForColumn:Item_UpStopPrice];
            model.m_dDownStopPrice = [s doubleForColumn:Item_DownStopPrice];
            model.m_nIsMain = [s intForColumn:Item_IsMain];
            model.m_lDealVolum = [s longForColumn:Item_DealVolum];
            model.m_dPriceTick = [s doubleForColumn:Item_PriceTick];
            model.m_dLastPrice = [s doubleForColumn:Item_LastPrice];
            model.m_dOpenPrice = [s doubleForColumn:Item_OpenPrice];
            model.m_nVolume = [s intForColumn:Item_Volume];
            model.isMyContract = [s intForColumn:Item_MyContract];
            [array addObject:model];
        }
        [_db close];
    }
    return array;
}

#pragma mark 查找一条数据
-(PushModel *)queryItem:(NSString *)tableName
             instrumentid : (NSString *)instrumentID
{
    PushModel *model = nil;
    if([_db open])
    {
        FMResultSet *s = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        while ([s next]) {
            if([instrumentID isEqualToString:[s stringForColumn:Item_InstrumentID]])
            {
                model = [[PushModel alloc]init];
                model.m_strExchangeID = [s stringForColumn:Item_ExchangeID];
                model.m_strExchangeName = [s stringForColumn:Item_ExchangeName];
                model.m_strProductID = [s stringForColumn:Item_ProductID];
                model.m_strProductName = [s stringForColumn:Item_ProductName];
                model.m_strInstrumentID = [s stringForColumn:Item_InstrumentID];
                model.m_strInstrumentName = [s stringForColumn:Item_InstrumentName];
                model.m_strExpireDate = [s stringForColumn:Item_ExpireDate];
                model.m_bAllowTrade = [s boolForColumn:Item_AllowTrade];
                model.m_volumeMultiple = [s intForColumn:Item_volumeMultiple];
                model.m_preClose = [s doubleForColumn:Item_preClose];
                model.m_moneyType = [s intForColumn:Item_moneyType];
                model.m_dLastSettlementPrice = [s doubleForColumn:Item_LastSettlementPrice];
                model.m_dUpStopPrice = [s doubleForColumn:Item_UpStopPrice];
                model.m_dDownStopPrice = [s doubleForColumn:Item_DownStopPrice];
                model.m_nIsMain = [s intForColumn:Item_IsMain];
                model.m_lDealVolum = [s longForColumn:Item_DealVolum];
                model.m_dPriceTick = [s doubleForColumn:Item_PriceTick];
                model.m_dLastPrice = [s doubleForColumn:Item_LastPrice];
                model.m_dOpenPrice = [s doubleForColumn:Item_OpenPrice];
                model.m_nVolume = [s intForColumn:Item_Volume];
                model.isMyContract = [s intForColumn:Item_MyContract];
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
