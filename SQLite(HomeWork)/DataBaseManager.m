//
//  DataBaseManager.m
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>

//数据库处理的句柄
sqlite3 *sqlite = nil;
@implementation DataBaseManager
static DataBaseManager *instance = nil;

//单例
+ (instancetype) shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DataBaseManager alloc]init];
        
        [instance copyDBFileToSandBox];
        
    });
    return instance;
}

//copy数据库的文件到沙盒中
- (void) copyDBFileToSandBox {
    
    NSString *atPath = [[NSBundle mainBundle] pathForResource:@"TableDB" ofType:@"sqlite"];
    NSString *toPath = [self dbFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //如果文件不存在,才copy文件，反之不用
    if ([manager fileExistsAtPath:toPath]) {
        
        return;
    }
    
    [manager copyItemAtPath:atPath toPath:toPath error:NULL];
    
}

//返回数据库文件在沙盒的路径
- (NSString *) dbFileName {
    return [NSHomeDirectory() stringByAppendingString:@"/Documents/TableDB.sqlite"];
}

//查询数据并将其显示在界面上
- (NSArray *) queryAllModel {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *fileName = [self dbFileName];
    
    //打开数据库
    int openResult = sqlite3_open([fileName UTF8String], &sqlite);
    if (openResult != SQLITE_OK) {
        
        NSLog(@"打开数据库失败");
        
        return nil;
    }
    
    //准备语句
    NSString *statements = @"select * from peopleInfo";
    
    sqlite3_stmt *stmt = nil;
    /*
     sqlite3 *db: 数据库句柄
     const char *zSql: SQL语句
     int nByte:  -1 编译之后的代码的最大长度 -1表示不限长度
     sqlite3_stmt **ppStmt: 准备好的语句 (绑定参数)
     const char **pzTail: 小尾巴(zSql中还有剩余的内容,可以写在这里)
     */
    
    //参数的绑定
    sqlite3_prepare_v2(sqlite, [statements UTF8String], -1, &stmt, NULL);
    
    //执行语句
    int stepResult = sqlite3_step(stmt);
    
    while (stepResult == SQLITE_ROW) {
        
        //拿取数据
        const char *Tname = (const char *)sqlite3_column_text(stmt, 0);
        int age = sqlite3_column_int(stmt, 1);
        
        peopleModel *model = [[peopleModel alloc] init];
//       C语言转OC语言
        model.name = [NSString stringWithUTF8String:Tname];
        model.age = age;
        
        [array addObject:model];
        
        stepResult = sqlite3_step(stmt);
        
    }
    
    //4 完结语句
    sqlite3_finalize(stmt);
    
    //5 关闭数据库
    sqlite3_close(sqlite);
    
    return array;
}

//增加数据
- (BOOL)addPeopleModel:(peopleModel *)model {
    
    
    /*
     打开数据库
     准备SQL语句
     执行SQL语句
     语句完结
     关闭数据库
     */
    
    NSString *fileName = [self dbFileName];
    //(1)打开数据库
    int openResult = sqlite3_open([fileName UTF8String], &sqlite);
    if (openResult != SQLITE_OK) {
        
        NSLog(@"打开数据库失败");
        return NO;
        
    }
    
    //(2)准备sql语句
    //1> 准备语句
    NSString *statement = @"insert into peopleInfo (name, pwd, age) values(?,?,?)";
    
    sqlite3_stmt *stmt = nil;
    /*
     sqlite3 *db: 数据库句柄
     const char *zSql: SQL语句
     int nByte:  -1 编译之后的代码的最大长度 -1表示不限长度
     sqlite3_stmt **ppStmt: 准备好的语句 (绑定参数)
     const char **pzTail: 小尾巴(zSql中还有剩余的内容,可以写在这里)
     */
    
    sqlite3_prepare_v2(sqlite, [statement UTF8String], -1, &stmt, NULL);
    //2>参数绑定
    //第二个参数表示要绑定的是第几个参数;第三个参数是要绑定的值
    
    sqlite3_bind_text(stmt, 1, [model.name UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [model.pwd UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, model.age);
    
    //(3)执行语句
    int stepResult = sqlite3_step(stmt);
    if (stepResult != SQLITE_OK &&stepResult != SQLITE_DONE) {
        NSLog(@"语句执行失败");
        
        return NO;
    }
    
    //(4)完结语句
    sqlite3_finalize(stmt);
    
    //(5)关闭连接
    sqlite3_close(sqlite);
    
    
    
    return YES;

}

//改
-(BOOL)updatePeopleModel:(peopleModel *)model{
    
    NSString *fileName = [self dbFileName];
    //(1)打开数据库
    int openResult = sqlite3_open([fileName UTF8String], &sqlite);
    if (openResult != SQLITE_OK) {
        
        NSLog(@"打开数据库失败");
        return NO;
        
    }
    
    //(2)准备sql语句
    //1> 准备语句
    NSString *statement = @"update peopleInfo set name=?,pwd=? where age =? ";
    
    sqlite3_stmt *stmt = nil;
    /*
     sqlite3 *db: 数据库句柄
     const char *zSql: SQL语句
     int nByte:  -1 编译之后的代码的最大长度 -1表示不限长度
     sqlite3_stmt **ppStmt: 准备好的语句 (绑定参数)
     const char **pzTail: 小尾巴(zSql中还有剩余的内容,可以写在这里)
     */
    
    sqlite3_prepare_v2(sqlite, [statement UTF8String], -1, &stmt, NULL);
    //2>参数绑定
    //第二个参数表示要绑定的是第几个参数;第三个参数是要绑定的值
    
    sqlite3_bind_text(stmt, 1, [model.name UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [model.pwd UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, model.age);

    
    
    //(3)执行语句
    int stepResult = sqlite3_step(stmt);
    NSLog(@"stepResult = %d", stepResult);
    if (stepResult != SQLITE_OK &&stepResult != SQLITE_DONE) {
        NSLog(@"语句执行失败");
        
        return NO;
    }
    
    //(4)完结语句
    sqlite3_finalize(stmt);
    
    //(5)关闭连接
    sqlite3_close(sqlite);
    
    
    
    return YES;
    
}


//删除数据
-(BOOL)deletePeopleModel:(peopleModel*)model{
    
    NSString *fileName = [self dbFileName];
    //(1)打开数据库
    int openResult = sqlite3_open([fileName UTF8String], &sqlite);
    if (openResult != SQLITE_OK) {
        
        NSLog(@"打开数据库失败");
        return NO;
        
    }
    
    //(2)准备sql语句
    //1> 准备语句
    NSString *statement = @"delete from peopleInfo where age = ? ";
    
    sqlite3_stmt *stmt = nil;
    /*
     sqlite3 *db: 数据库句柄
     const char *zSql: SQL语句
     int nByte:  -1 编译之后的代码的最大长度 -1表示不限长度
     sqlite3_stmt **ppStmt: 准备好的语句 (绑定参数)
     const char **pzTail: 小尾巴(zSql中还有剩余的内容,可以写在这里)
     */
    
    sqlite3_prepare_v2(sqlite, [statement UTF8String], -1, &stmt, NULL);
    //2>参数绑定
    //第二个参数表示要绑定的是第几个参数;第三个参数是要绑定的值
    sqlite3_bind_int(stmt, 1, model.age);
    
    //(3)执行语句
    int stepResult = sqlite3_step(stmt);
    if (stepResult != SQLITE_OK &&stepResult != SQLITE_DONE) {
        NSLog(@"语句执行失败");
        
        return NO;
    }
    
    //(4)完结语句
    sqlite3_finalize(stmt);
    
    //(5)关闭连接
    sqlite3_close(sqlite);
    
    
    
    return YES;
    
    
}



@end
