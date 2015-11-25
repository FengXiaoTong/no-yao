//
//  CAPIViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "CAPIViewController.h"

@interface CAPIViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tempTf;
@end

@implementation CAPIViewController


-(NSString *)path{
 //1获取沙盒路径 lib 目录
 NSString *libra=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
 //2合并文件路径
 NSString *filePath=[libra stringByAppendingPathComponent:@"tem.txt"];
    NSLog(@"======%@",filePath);
    return filePath;
}

//存储数据
- (IBAction)saveDataClick:(UIButton *)sender {

    //1 打开文件
    const char *path=[[self path] UTF8String];
    FILE *fp=fopen(path, "w+");
    if(fp==NULL){
        perror("ferror");
        return ;
    }
   //2将textfiled的文字保存在本地
    //写操作
    size_t count=fwrite([[_tempTf text] UTF8String],_tempTf.text.length, 1, fp);
    
    if (count>0) {
        NSLog(@"=====保存文件成功");
    }
    
  //3关闭文件
    fclose(fp);

}

//取出本地文件
-(NSString *)loadData{
  //1 打开文件
    
    FILE *fp=fopen([[self path] UTF8String],"r");
    if (fp==NULL) {
        perror("打开失败");
        return nil;
    }
  //2 读取文件
   //2.1计算文件长度
  fseek(fp, 0, SEEK_END);
   //文件长度
  long size=ftell(fp);
  
  //2.2读文件
  rewind(fp); //偏移文件指针到文件开始的地方；
  char buf[1024]={0};
  size_t count=fread(buf,size, 1, fp);
    NSString *str;
  if (count>0) {
        NSLog(@"====成功read");
  str=[NSString stringWithUTF8String:buf];
  }
  //3 关闭文件
    fclose(fp);
    return str;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //读取操作
    _tempTf.text=[self loadData];
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
