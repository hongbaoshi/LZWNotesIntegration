//
//  ThirteenViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/28.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ThirteenViewController.h"
#import "LzwScrollView.h"

@interface ThirteenViewController ()

@end

@implementation ThirteenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //*** 添加滚动视图
    LzwScrollView *lzwScr = [[LzwScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-104) andWithBtnTitleArray:@[@"Runtime",@"Runloop"] andWithScrollViewControlerArray:@[@"LZWRuntimeView",@"LZWRunloopView"] withTag:1300];
    [self.view addSubview:lzwScr];
    
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
