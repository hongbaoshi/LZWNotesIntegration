//
//  RotateAnimationViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "RotateAnimationViewController.h"

@interface RotateAnimationViewController ()

@property(nonatomic,strong)UIView *view1;

@end

@implementation RotateAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 80, 80)];
    _view1.backgroundColor = [UIColor redColor];
    //    _view1.layer.masksToBounds = YES;
    //    _view1.layer.cornerRadius = 40;
    [self.view addSubview:_view1];
    
    //旋转
    [self doAnimation];
    
    
}

-(void)doAnimation{
    __weak RotateAnimationViewController *weakSelf = self;
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _view1.transform = CGAffineTransformRotate(_view1.transform, M_PI_2);
        //        _view1.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        [weakSelf doAnimation];
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
