//
//  EightViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/7.
//  Copyright © 2017年 红宝时. All rights reserved.
//


#define SCW [UIScreen mainScreen].bounds.size.width
#define SCH [UIScreen mainScreen].bounds.size.height

#import "EightViewController.h"
#import "LZWFloatWindow.h"
#import "LZWHeaderScrollView.h"
#import "LzwScrollView.h"

@interface EightViewController ()

@property(nonatomic,strong)LZWFloatWindow *change_floatWindow;


@end

@implementation EightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"8---自己封装的类";
    //*** 1、添加两个按钮
    NSArray *titleArr = @[@"1、悬浮窗",@"2、头部滚动视图",@"3、滚动视图加头部btn"];
    for (int i = 0; i< titleArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 200 + i*60, 200, 40);
        btn.center = CGPointMake(self.view.center.x, 200 + i*60);
        [btn setTitle:titleArr[i] forState:0];
        btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.40 blue:0.84 alpha:1.00];
        btn.tag = 180 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 180)
    {
        _change_floatWindow = [[LZWFloatWindow alloc] initWithFrame:CGRectMake(100, 100, 50,50) andWithMainImageName:@"z" andWithTitleDic:@{@"ddd":@"用户中心",@"eee":@"退出登录",@"fff":@"客服中心"} andWithStartBtnTag:100 andWithAnimationColor:[UIColor purpleColor]];
        _change_floatWindow.backBlock = ^(NSInteger tag){
            NSLog(@"点击第%ld个按钮",tag);
        };
    }else if(btn.tag == 181)
    {
        NSArray *imgArr = @[@"https://nie.res.netease.com/r/pic/20170802/6d756c7a-1d98-4695-a11d-b7cd41d39e88"];
        LZWHeaderScrollView *headerScrollView = [[LZWHeaderScrollView alloc] initWithFrame:CGRectMake(30, 200, SCW-60, 200) andWithImgArray:imgArr andWithScrTime:4.0 andWithStartTag:100];
        headerScrollView.block = ^(NSInteger tag){
            NSLog(@"%ld",tag);
        };
        [self.view addSubview:headerScrollView];
    }else if (btn.tag == 182)
    {
        LzwScrollView *lzwScr = [[LzwScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80) andWithBtnTitleArray:@[@"第一个",@"第二个",@"第三个",@"第四个"] andWithScrollViewControlerArray:@[@"0",@"1",@"2",@"3"] withTag:830];
        
        [self.view addSubview:lzwScr];
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.change_floatWindow.alpha = 0;
    self.change_floatWindow = nil;
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
