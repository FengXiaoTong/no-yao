//
//  UserInfoMode.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/23.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "UserInfoMode.h"

@implementation UserInfoMode
/*************************
 * 编码器
 * 对象序列化操作 对象----》nsdata;
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_pwd forKey:@"pwd"];
    [aCoder encodeInteger:_uid forKey:@"uid"];
    [aCoder encodeBool:_sex forKey:@"sex"];
}




/*************************
 * 解码器
 *  NSdata------>对象
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
       //解码操作
       //存入什么类型就对应取出什么类型 key值要和存的key一致
        _username=[aDecoder decodeObjectForKey:@"username"];
        _pwd=[aDecoder decodeObjectForKey:@"pwd"];
        _uid=[aDecoder decodeIntegerForKey:@"uid"];
        _sex=[aDecoder decodeBoolForKey:@"sex"];
    }
    return self;
}


@end
