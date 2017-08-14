//
//  FiveViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/3.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FiveViewController.h"
#import "FiveWebViewInteraction.h"
#import "FiveWKWebViewInteraction.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

-(void)viewDidLoad
{
    self.title = @"5---JS交互";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //*** 1、创建GCD、operation两个按钮
    NSArray *titleArr = @[@"WebView交互",@"WKWebView交互"];
    for (int i = 0; i< 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 200 + i*60, 150, 40);
        btn.center = CGPointMake(self.view.center.x, 200 + i*60);
        [btn setTitle:titleArr[i] forState:0];
        btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.40 blue:0.84 alpha:1.00];
        btn.tag = 150 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 150)
    {
        FiveWebViewInteraction *webVcr = [[FiveWebViewInteraction alloc] init];
        [self.navigationController pushViewController:webVcr animated:YES];
    }else
    {
        FiveWKWebViewInteraction *wkVcr = [[FiveWKWebViewInteraction alloc] init];
        [self.navigationController pushViewController:wkVcr animated:YES];
    }
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
