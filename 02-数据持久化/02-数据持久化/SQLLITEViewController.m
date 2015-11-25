//
//  SQLLITEViewController.m
//  02-数据持久化
//
//  Created by qingyun on 15/11/24.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "SQLLITEViewController.h"
#import "Student.h"
#import "DBOperation.h"


@interface SQLLITEViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfID;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@end

@implementation SQLLITEViewController
- (IBAction)saveData:(id)sender {
    Student *mode=[Student studentsWithID:_tfID.text.integerValue name:_tfName.text age:_tfAge.text.integerValue icon:_iconImage.image];
   //mode插入操作
    DBOperation *peration=[DBOperation sharderHandle];
    [peration insertInto:mode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
