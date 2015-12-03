//
//  QYStudentInfo.m
//  01-FMDBDemo
//
//  Created by qingyun on 15/12/3.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYStudentInfo.h"

@implementation QYStudentInfo

/**
 * Desination Init Method
 */
- (instancetype)initWithID:(NSString *)ID name:(NSString *)name andAge:(int)age {
    if (self = [super init]) {
        _stu_id = ID;
        _name = name;
        _age = age;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    return [self initWithID:dict[kStuID] name:dict[kStuName] andAge:[dict[kStuAge] intValue]];
}

+ (instancetype)studentWithID:(NSString *)ID name:(NSString *)name andAge:(int)age {
    QYStudentInfo *student = [[QYStudentInfo alloc] initWithID:ID name:name andAge:age];
    return student;
}

+ (instancetype)studentWithDictionary:(NSDictionary *)dict {
    QYStudentInfo *student = [[QYStudentInfo alloc] initWithDictionary:dict];
    return student;
}

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"StudentInfo: ID:<%@>, name:<%@>, age:<%d>", _stu_id, _name, _age];
    return desc;
}

@end
