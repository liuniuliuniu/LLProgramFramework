//
//  XKeyValueStore.m
//  TTlc
//
//  Created by wangxi1-ps on 2016/11/29.
//  Copyright © 2016年 wangxi. All rights reserved.
//

#import "XKeyValueStore.h"
#import "YTKKeyValueStore.h"

static NSString *dbPath = @"ttlcdb";
static NSString *dbName = @"ttlc.db";

@implementation XKeyValueStore
+ (XKeyValueStore *)sharedStore
{
    static XKeyValueStore *m_store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_store = [[XKeyValueStore alloc] init];
    });
    return m_store;
}

- (instancetype)init
{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)createDBWithTableName:(NSString *)tableName
{
    if (tableName.length == 0)
    {
        return;
    }
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    [store createTableWithName:tableName];
    [store close];
}

- (void)dealloc
{
}
+(NSString *)dbPath
{
    NSString *documentsPath = [XKeyValueStore pathWithDocuments];
    documentsPath = [documentsPath stringByAppendingPathComponent:dbPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:documentsPath]){
        [XKeyValueStore createDirectoriesAtPath:documentsPath attributes:nil];
    }
    documentsPath = [documentsPath stringByAppendingPathComponent:dbName];
    return documentsPath;
}

// 创建多级目录
+ (BOOL)createDirectoriesAtPath:(NSString *)inPath
                     attributes:(NSDictionary *)inAttributes
{
    NSArray *components = [inPath pathComponents];
    int i;
    BOOL result = YES;
    
    for (i = 1 ; i <= [components count] ; i++ ) {
        NSArray *subComponents = [components subarrayWithRange:
                                  NSMakeRange(0,i)];
        NSString *subPath = [NSString pathWithComponents:subComponents];
        BOOL isDir;
        BOOL exists = [[NSFileManager defaultManager]
                       fileExistsAtPath:subPath isDirectory:&isDir];
        
        if (!exists) {
            result = [[NSFileManager defaultManager]
                      createDirectoryAtPath:subPath
                      withIntermediateDirectories:YES
                      attributes:inAttributes
                      error:nil];
            if (!result)
                return result;
        }
    }
    return result;
}

+ (NSString *)pathWithDocuments
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


// 写入数据
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName
{
    if (!string || !stringId || !tableName)
    {
        return;
    }
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    if(store)
        [store putString:string withId:stringId intoTable:tableName];
    [store close];
}
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName
{
    if (!number || !numberId || !tableName)
    {
        return;
    }
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    if(store)
        [store putNumber:number withId:numberId intoTable:tableName];
    [store close];
}
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName
{
    if (!object || !objectId || !tableName)
    {
        return;
    }
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    if(store)
        [store putObject:object withId:objectId intoTable:tableName];
    [store class];
}
//读取数据
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    NSString *value = nil;
    if(store)
        value = [store getStringById:stringId fromTable:tableName];
    [store close];
    return value;
}
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    NSNumber *value = nil;
    if(store)
        value = [store getNumberById:numberId fromTable:tableName];
    [store close];
    return value;
}
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    id value = nil;
    if(store)
        value = [store getObjectById:objectId fromTable:tableName];
    [store close];
    return value;
}

// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    if(store)
        [store deleteObjectById:objectId fromTable:tableName];
    [store close];
}

// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    if(store)
        [store deleteObjectsByIdArray:objectIdArray fromTable:tableName];
    [store close];
}
- (NSArray *)getAllItemsFromTable:(NSString *)tableName{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:[XKeyValueStore dbPath]];
    NSArray *allItem;
    if(store)
        allItem = [store getAllItemsFromTable:tableName];
    [store close];
    return allItem;
}
@end
