//
//  ArchiverViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/23.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//
#import "UserInfoMode.h"

#import "ArchiverViewController.h"

@interface ArchiverViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfUser;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfUid;
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;

@end

@implementation ArchiverViewController

//解档操作  反序列化
-(void)loadData{
  //NSData=====》objc对象
  UserInfoMode *mode=[NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/guofudiyi/Desktop/userInfo"];
    if (mode) {
        _sexSwitch.on=mode.sex;
        _tfUid.text=[NSString stringWithFormat:@"%ld",mode.uid];
        _tfPwd.text=mode.pwd;
        _tfUser.text=mode.username;
    }

}

//对象归档操作 序列化
- (IBAction)clickSave:(id)sender {
    //将值付给mode
    UserInfoMode *mode=[[UserInfoMode alloc] init];
    mode.username=_tfUser.text;
    mode.pwd=_tfPwd.text;
    mode.uid=_tfUid.text.integerValue;
    mode.sex=_sexSwitch.on;
    //将mode序列化后存入本地
    if ( [NSKeyedArchiver archiveRootObject:mode toFile:@"/Users/guofudiyi/Desktop/userInfo"]) {
        NSLog(@"=====成功");
    };
    
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
