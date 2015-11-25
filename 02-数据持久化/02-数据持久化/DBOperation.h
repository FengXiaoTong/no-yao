//
//  DBOperation.h
//  02-数据持久化
//
//  Created by qingyun on 15/11/24.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//
#import <Foundation/Foundation.h>
@class Student;
@interface DBOperation : NSObject

+(instancetype)sharderHandle;
//插入到table
-(BOOL)insertInto:(Student *)mode;

@end
