//
//  ViewController.m
//  上加下减
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "ViewController.h"
#import "BloodMode.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tempView;
@property(nonatomic, strong)BloodMode *mode;
@property(nonatomic, assign)CGFloat maxY;
@property(nonatomic, strong)NSArray *colors;

@end

@implementation ViewController

- (void)viewDidLoad {
   
 
    //1.创建并添加手势
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(actionUp:
    )];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(actionUp:
    )];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    //2.初始化mode ，添加KVO 监听
    _mode = [BloodMode new];
    
    //添加监听
    [_mode addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:(__bridge void*)(_tempView)];
    
    _maxY = CGRectGetMaxY(_tempView.frame);//这是一个函数方法，用以找出在这个矩形里面Y的最大值
    
    
     [super viewDidLoad];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"value"]) {
        //取出值
        int value = [change[@"new"] intValue];
        
        //刷新
        UIImageView *temp = (__bridge UIImageView *)(context);
        CGRect rect = temp.frame;
        rect.size.height = value;
        rect.origin.y = _maxY - rect.size.height;
        temp.frame = rect;
        
        //设置颜色
        temp.backgroundColor = self.colors[(value/100)-1];
    }
}


-(void)dealloc
{
    [_mode removeObserver:self forKeyPath:@"value"];
}

//这两个必须成对存在，有监听，就要有取消监听


-(NSArray *)colors{
    if (_colors == nil) {
        
        _colors = @[[UIColor greenColor],[UIColor purpleColor], [UIColor yellowColor], [UIColor redColor]];
    }
    return _colors;
}




-(void)actionUp:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        _mode.value += 100;
    }else{
        
        if (_mode.value != 100) {
            _mode.value -= 100;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"血量不足" delegate:nil cancelButtonTitle:@"忽略" otherButtonTitles:@"加血" , nil];
            
            [alert show];
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
