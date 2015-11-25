//
//  UserInfoMode.h
//  02-数据持久化
//
//  Created by qingyun on 15/11/23.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoMode : NSObject<NSCoding>
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *pwd;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,assign)BOOL sex;
@end
