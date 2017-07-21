//
//  FourViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/1.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FourViewController.h"
#import "FourGCDTableViewShow.h"
#import "FourOperationTableViewShow.h"


@interface FourViewController ()

@end

@implementation FourViewController

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //*** 1、创建GCD、operation两个按钮
    NSArray *titleArr = @[@"gcd按钮",@"operation按钮"];
    for (int i = 0; i< 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 200 + i*60, 150, 40);
        btn.center = CGPointMake(self.view.center.x, 200 + i*60);
        [btn setTitle:titleArr[i] forState:0];
        btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.40 blue:0.84 alpha:1.00];
        btn.tag = 140 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 140)
    {
        FourGCDTableViewShow *gcdVcr = [[FourGCDTableViewShow alloc] init];
        [self.navigationController pushViewController:gcdVcr animated:YES];
    }else
    {
        FourOperationTableViewShow *operationVcr = [[FourOperationTableViewShow alloc] init];
        [self.navigationController pushViewController:operationVcr animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

































