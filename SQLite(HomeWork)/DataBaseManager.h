//
//  DataBaseManager.h
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "peopleModel.h"

@interface DataBaseManager : NSObject

+ (instancetype) shareManager;

//查询数据
- (NSArray *) queryAllModel;

//增加数据
- (BOOL)addPeopleModel:(peopleModel *)model;

//删
-(BOOL)deletePeopleModel:(peopleModel *)model;

//改
-(BOOL)updatePeopleModel:(peopleModel *)model;

@end
