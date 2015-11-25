//
//  Student.h
//  02-数据持久化
//
//  Created by qingyun on 15/11/24.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Student : NSObject
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)UIImage *icon;

+(instancetype)studentsWithID:(NSInteger)Id name:(NSString *)name age:(NSInteger)age icon:(UIImage *)icon;

@end
