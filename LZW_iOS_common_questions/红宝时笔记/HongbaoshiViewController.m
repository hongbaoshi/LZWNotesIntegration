//
//  LizhiweiViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "HongbaoshiViewController.h"
#import "LZWTabBarController.h"

@interface HongbaoshiViewController ()

@property(nonatomic,strong)LZWTabBarController * lzwTabBarVc;

@end

@implementation HongbaoshiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [UIApplication sharedApplication].delegate.window.rootViewController=self.lzwTabBarVc;
}

-(LZWTabBarController *)lzwTabBarVc
{
    
    if (!_lzwTabBarVc)
    {
        _lzwTabBarVc=[[LZWTabBarController alloc]init];
    }
    return _lzwTabBarVc;
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
