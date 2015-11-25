//
//  ViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
 _arr=@[@"CAPIViewController",@"OCAPIViewController",@"UserDefaultsViewController",@"PropertyListViewController",@"ArchiverViewController",@"SQLLITEViewController"];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=_arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//压栈操作
    UIViewController *controller=[NSClassFromString(_arr[indexPath.row]) new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
