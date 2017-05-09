//
//  XKeyValueStore.h
//  TTlc
//
//  Created by wangxi1-ps on 2016/11/29.
//  Copyright © 2016年 wangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKeyValueStore : NSObject
+ (XKeyValueStore *)sharedStore;

+(NSString *)dbPath;

/**
 *  需要用到的时候去创建
 *
 *  @param tableName 表的名字
 */
- (void)createDBWithTableName:(NSString *)tableName;

// 写入数据  value类型包括：NSString, NSNumber, NSDictionary和NSArray 操作完成会自动关闭数据库
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

//读取数据  value类型包括：NSString, NSNumber, NSDictionary和NSArray
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;


// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;
@end
