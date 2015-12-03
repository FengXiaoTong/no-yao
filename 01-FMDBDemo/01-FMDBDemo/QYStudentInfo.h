//
//  QYStudentInfo.h
//  01-FMDBDemo
//
//  Created by qingyun on 15/12/3.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStuID      @"stu_id"
#define kStuName    @"name"
#define kStuAge     @"age"

@interface QYStudentInfo : NSObject
@property (nonatomic, strong) NSString *stu_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name andAge:(int)age;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)studentWithDictionary:(NSDictionary *)dict;
+ (instancetype)studentWithID:(NSString *)ID name:(NSString *)name andAge:(int)age;

@end
