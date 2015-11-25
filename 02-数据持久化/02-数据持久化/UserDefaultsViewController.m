//
//  UserDefaultsViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/21.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "UserDefaultsViewController.h"

@interface UserDefaultsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfValue;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;

@end

@implementation UserDefaultsViewController

//写入操作
- (IBAction)clickSave:(id)sender {
//获取userdefaults单例对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    //写入defaluts setvalue-FORKEY
    [defaults setObject:_tfValue.text forKey:@"TF"];
    //2.Switch value
    [defaults setObject:[NSNumber numberWithBool:_switchView.on] forKey:@"isOpen"];
    //3.silide value
    [defaults setObject:@(_sliderView.value) forKey:@"value"];
    //持久化
    [defaults synchronize];
}
//取值
-(void)loadData{
   //userDefaults 对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //1取出值 tf
    NSString *tfstr=[defaults objectForKey:@"TF"];
    _tfValue.text=tfstr;
   //2取出switch
    NSNumber *meber=[defaults objectForKey:@"isOpen"];
    _switchView.on=meber.boolValue;
    
    //3.取出slider；
    NSNumber *nuberValue=[defaults objectForKey:@"value"];
    _sliderView.value=nuberValue.floatValue;

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
