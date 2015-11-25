//
//  PropertyListViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "PropertyListViewController.h"
#define  fileName @"test.plist"

@interface PropertyListViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;

@end

@implementation PropertyListViewController

//文件路径
-(NSString *)getPath{
  NSString *Libray=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    
  //创建文件夹
    NSString *directoryPath=[Libray stringByAppendingPathComponent:@"LIST"];
    //获取文件管理器
    NSFileManager *Manger=[NSFileManager defaultManager];
    NSError *error;
    if (![Manger createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:0 error:&error]) {
        NSLog(@"======%@",error);
        return nil;
    }
   //创建plist文件
    NSString *filePath=[directoryPath stringByAppendingPathComponent:fileName];
    
    if (![Manger fileExistsAtPath:filePath]) {
        if (![Manger createFileAtPath:filePath contents:nil attributes:0]) {
            NSLog(@"=====创建失败");
            return nil;
        }
    
    }
    return filePath;
}



-(IBAction)clickSave:(id)sender {
    //ui 存在字典里边
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_nameTF.text forKey:@"name"];
    [dic setObject:@(_sexSwitch.on) forKey:@"sex"];
    [dic setObject:_ageTF.text forKey:@"age"];
    [dic setObject:_phoneTf.text forKey:@"phone"];
    //将字典存储为plist文件
    if (![dic writeToFile:[self getPath] atomically:YES]) {
        NSLog(@"======保存失败");
    }
}

-(void)loadData{
 //通过路径读取到plist文件++++》》》》转成NSDictionary
    NSDictionary *dic=[[NSDictionary alloc] initWithContentsOfFile:[self getPath]];
    _nameTF.text =dic[@"name"];
    _sexSwitch.on=[dic[@"sex"] boolValue];
    _ageTF.text=dic[@"age"];
    _phoneTf.text=dic[@"phone"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
