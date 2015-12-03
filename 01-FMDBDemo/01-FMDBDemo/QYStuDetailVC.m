//
//  QYStuDetailVC.m
//  01-FMDBDemo
//
//  Created by qingyun on 15/12/3.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYStuDetailVC.h"
#import "QYStudentInfo.h"
#import "FMDB.h"
#import "QYCommon.h"

@interface QYStuDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (nonatomic, assign, getter=isChanged) BOOL changed;
@property (nonatomic, strong) FMDatabase *database;
@end

@implementation QYStuDetailVC

- (FMDatabase *)database {
    if (_database == nil) {
        NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        dbPath = [dbPath stringByAppendingPathComponent:kDBFileName];
        _database = [FMDatabase databaseWithPath:dbPath];
        NSLog(@"%@", dbPath);
    }
    return _database;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _stuInfo);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)updateStuInfo:(QYStudentInfo *)stuInfo {
    assert(stuInfo.stu_id != nil
           && stuInfo.name != nil
           && stuInfo.age > 0);
    
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failure!");
        return;
    }

    // 2. 执行更新操作
    NSString *sql = [NSString stringWithFormat:@"update Students set %@ = '%@', %@ = %d where %@ = %@", kStuName, stuInfo.name, kStuAge, stuInfo.age, kStuID, stuInfo.stu_id];

    NSLog(@"%@", sql);
    
//    [self.database executeUpdate:sql];
    [self.database executeUpdate:sql];
    
    // 3. 关闭数据库
    [self.database close];
    
}

- (BOOL)isChanged {
    if ([_stuInfo.name isEqualToString:_name.text]
        && [[@(_stuInfo.age) stringValue] isEqualToString:_age.text]) {
        return NO;
    }
    
    return YES;
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    if (!self.isChanged) {
        return;
    }
    
    // 更新数据库
    QYStudentInfo *stuInfo = [QYStudentInfo studentWithID:_stuInfo.stu_id name:_name.text andAge:[_age.text intValue]];
    [self updateStuInfo:stuInfo];
}

@end
