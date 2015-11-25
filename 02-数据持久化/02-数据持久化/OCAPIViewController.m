//
//  OCAPIViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "OCAPIViewController.h"

#define filename @"ocapi.txt"

@interface OCAPIViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tempTf;

@end

@implementation OCAPIViewController


//文件路径
-(NSString *)path{
  NSString *libra=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
   //创建文件夹 test
    //路径
    NSString *directoryPath=[libra stringByAppendingPathComponent:@"test"];
   //文件管理器
    NSFileManager*manger=[NSFileManager defaultManager];
    NSError *error;
    if (![manger createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:0 error:&error]) {
        NSLog(@"=====%@",error);
        return nil;
    }
    
    //创建文件 ocapi.txt;
   //文件路径
    NSString *filepath=[directoryPath stringByAppendingPathComponent:filename];
    //创建文件
    //判断文件是否存在，不存在再创建
    if (![manger fileExistsAtPath:filepath]) {
        
       if(![manger createFileAtPath:filepath contents:nil attributes:0]){
        NSLog(@"失败");
        return nil;
       }
    }
    
    return filepath;
}

- (IBAction)saveDataClick:(UIButton *)sender {
   //保存数据
    NSError *error;
    if (![_tempTf.text writeToFile:[self path] atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        NSLog(@"====error===%@",error);
    }
}

-(void)loadData{
    NSError *error;
    _tempTf.text=[[NSString alloc] initWithContentsOfFile:[self path] encoding:NSUTF8StringEncoding error:&error];
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
