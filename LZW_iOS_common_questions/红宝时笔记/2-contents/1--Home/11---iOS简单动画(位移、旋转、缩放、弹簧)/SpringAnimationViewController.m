//
//  SpringAnimationViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "SpringAnimationViewController.h"

@interface SpringAnimationViewController ()

@end

@implementation SpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 100, 80, 80)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
#pragma mark --- 、改变动画变化速度
    /*
     UIViewAnimationOptionCurveEaseInOut        先慢后快，再快后慢
     UIViewAnimationOptionCurveEaseIn           先慢后快
     UIViewAnimationOptionCurveEaseOut          先快后慢
     UIViewAnimationOptionCurveLinear           匀速
     */
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        //        view2.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
    
#pragma mark --- 、弹簧动画
    /*
     第三个参数：阻尼系数，越大回弹次数越少；
     第四个参数：初始化速度
     */
    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        view2.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
    
    
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
