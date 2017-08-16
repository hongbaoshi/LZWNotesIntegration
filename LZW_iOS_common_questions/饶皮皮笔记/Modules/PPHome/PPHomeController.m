//
//  PPHomeController.m
//  LZW_iOS_common_questions
//
//  Created by 饶思学 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "PPHomeController.h"
#import "ViewController.h"
@interface PPHomeController ()

@end

@implementation PPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationItemWithTitles:@[@"到上面去"] isLeft:YES target:self action:@selector(back) tags:nil];
    // Do any additional setup after loading the view.
}
-(void)back{
    
    UINavigationController * naVC=[[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    [UIApplication sharedApplication].delegate.window.rootViewController=naVC;
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
