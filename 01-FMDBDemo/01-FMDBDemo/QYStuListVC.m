//
//  QYStuListVC.m
//  01-FMDBDemo
//
//  Created by qingyun on 15/12/3.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYStuListVC.h"
#import "QYStudentInfo.h"
#import "AFNetworking.h"
#import "QYCommon.h"
#import "FMDB.h"

#define kStuListCellID  @"studentCellID"
#define kNotFirst       @"notFirst"
#define kURLStr         @"persons.json"


@interface QYStuListVC ()
@property (nonatomic, strong) NSMutableArray *students;
@property (nonatomic, strong) FMDatabase *database;
@end

@implementation QYStuListVC

#pragma mark - life cycle

#pragma mark - setters & getters

#pragma mark - events handling

#pragma mark - misc

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadStuInfos];
}

- (void)loadStuInfos
{
    BOOL isNotFirst = [QYUD boolForKey:kNotFirst];
    if (isNotFirst) {
        // 从本地加载数据
        [self loadStuInfosLocal];
        return;
    }

    // 从网络请求数据，并更新UI，标记已经不是第一次
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:kURLStr];
    NSDictionary *parameters = @{@"person_type":@"student"};
    [manager POST:urlStr parameters:parameters success:^void(NSURLSessionDataTask *task, id responseObj) {
        
        _students = responseObj[@"data"];
        NSLog(@"%@", _students);
        
        [self.tableView reloadData];
        
        // 保存数据进数据库
        [self saveStuInfos2DB];
        
    } failure:^void(NSURLSessionDataTask * task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadStuInfosLocal {
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failure!");
        return;
    }
    
    // 2. 执行查询语句
    NSString *sql = @"select * from Students";
    FMResultSet *rs = [self.database executeQuery:sql];
    _students = [NSMutableArray array];
    while ([rs next]) {
        int ID = [rs intForColumn:kStuID];
        NSString *name = [rs stringForColumn:kStuName];
        int age = [rs intForColumn:kStuAge];
        QYStudentInfo *stu = [QYStudentInfo studentWithID:[@(ID) stringValue] name:name andAge:age];
        [_students addObject:stu];
    }
    
    // 3. 关闭数据库
    [self.database close];
    
    // 4. 更新UI
    [self.tableView reloadData];
}

- (FMDatabase *)database {
    if (_database == nil) {
        NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        dbPath = [dbPath stringByAppendingPathComponent:kDBFileName];
        NSLog(@"%@", dbPath);
        _database = [FMDatabase databaseWithPath:dbPath];
        
        // 创建学生表
        [self createStuTab];
    }
    return _database;
}

- (void)createStuTab {
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failure!");
        return;
    }

    // 2. 执行创表操作
    NSString *sql = [NSString stringWithFormat:@"create table if not exists Students(%@ INTEGER PRIMARY KEY, %@ TEXT, %@ INTEGER)", kStuID, kStuName, kStuAge];
        NSLog(@"%@", sql);
    [self.database executeUpdate:sql];
    
    // 3. 关闭数据库
    [self.database close];
}

- (void)saveStuInfos2DB
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failure!");
        return;
    }
    
    // 2. 执行操作
    for (NSDictionary *dict in _students) {
        NSString *sql = [NSString stringWithFormat:@"insert into Students(%@, %@, %@) values(:%@, :%@, :%@)", kStuID, kStuName, kStuAge, kStuID, kStuName, kStuAge];
        [self.database executeUpdate:sql withParameterDictionary:dict];
    }
    
    // 3. 关闭数据库
    [self.database close];
    
    [QYUD setBool:YES forKey:kNotFirst];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStuListCellID forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_students[indexPath.row] valueForKey:kStuName];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)deleteStuInfoFromDBByID:(NSString *)ID {
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failure!");
        return;
    }
    
    // 2. 执行删除操作
    NSString *sql = [NSString stringWithFormat:@"delete from Students where %@ = %@", kStuID, ID];
    [self.database executeUpdate:sql];
    
    // 3. 关闭数据库
    [self.database close];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // 删除内存中的记录
        NSString *ID = [_students[indexPath.row] valueForKey:kStuID];
        [_students removeObjectAtIndex:indexPath.row];
        
        // 删除磁盘上的记录
        [self deleteStuInfoFromDBByID:ID];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    QYStudentInfo *stu;
    if ([_students[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        stu = [QYStudentInfo studentWithDictionary:_students[indexPath.row]];
    } else {
        stu = _students[indexPath.row];
    }
    UIViewController *detailVC = segue.destinationViewController;
//    detailVC.stuInfo = stu;
    [detailVC setValue:stu forKey:@"stuInfo"];
}

@end
