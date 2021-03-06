//
//  TwelveViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TwelveViewController.h"
#import "TwelveMPPlayerViewController.h"
#import "TwelveAVPlayerViewController.h"
#import "TwelveStudyViewController.h"

@interface TwelveViewController ()


@end

@implementation TwelveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *titleArr = @[@"MPMoviePlayer",@"AVPlayer",@"视音频学习博客"];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 100+i*60, 150, 40);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:titleArr[i] forState:0];
        btn.tag = 220 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}


-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 220)
    {
        TwelveMPPlayerViewController *vcr = [[TwelveMPPlayerViewController alloc] init];
        [self.navigationController pushViewController:vcr animated:YES];
    }else if(btn.tag == 221)
    {
        TwelveAVPlayerViewController *vcr = [[TwelveAVPlayerViewController alloc] init];
        [self.navigationController pushViewController:vcr animated:YES];
    }else
    {
        TwelveStudyViewController *vcr = [[TwelveStudyViewController alloc] init];
        [self.navigationController pushViewController:vcr animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
















































