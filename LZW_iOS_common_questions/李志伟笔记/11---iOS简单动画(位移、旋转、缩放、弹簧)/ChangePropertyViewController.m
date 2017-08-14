//
//  ChangePropertyViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ChangePropertyViewController.h"

@interface ChangePropertyViewController ()

@property(nonatomic,strong)UIView *view1;

@end

@implementation ChangePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    _view1.backgroundColor = [UIColor redColor];
    //    _view1.layer.masksToBounds = YES;
    //    _view1.layer.cornerRadius = 40;
    [self.view addSubview:_view1];
    
    
    //    [UIView animateWithDuration:1.0  animations:^{
    //#pragma mark --- 1、改变位置
    //                _view1.center = CGPointMake(60, 300);
    //#pragma mark --- 2、改变透明度
    //                _view1.alpha = 0.2;
    //#pragma mark --- 3、改变颜色
    //                _view1.backgroundColor = [UIColor greenColor];
    //#pragma mark --- 4、改变大小比例
    //                _view1.transform = CGAffineTransformMakeScale(2.0, 2.0);
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    
#pragma mark --- 重复、往返执行
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        
#pragma mark --- 1、改变位置
        _view1.center = CGPointMake(140, 300);
#pragma mark --- 2、改变透明度
        _view1.alpha = 0.2;
#pragma mark --- 3、改变颜色
        _view1.backgroundColor = [UIColor greenColor];
#pragma mark --- 4、改变大小比例
        _view1.transform = CGAffineTransformMakeScale(2.0, 1.0);
        
        
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
