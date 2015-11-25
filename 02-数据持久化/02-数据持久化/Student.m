//
//  Student.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/24.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "Student.h"

@implementation Student
+(instancetype)studentsWithID:(NSInteger)Id name:(NSString *)name age:(NSInteger)age icon:(UIImage *)icon{
    Student *student=[Student new];
    student.ID=Id;
    student.icon=icon;
    student.userName=name;
    student.age=age;
    //返回student对象
    return student;
}


@end
