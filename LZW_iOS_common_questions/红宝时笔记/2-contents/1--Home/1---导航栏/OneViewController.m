//
//  OneViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/6/30.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"1---导航栏";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    
    //*** 1、导航栏左边按钮
    [self creatLeftBtn];
    
    //*** 2、导航栏右边按钮
    [self creatRightBtn];
    
    
    
}

#pragma mark --- 1、导航栏左边按钮
-(void)creatLeftBtn
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 10, 50, 20);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = 5;
    leftBtn.layer.borderColor = [UIColor blackColor].CGColor;
    leftBtn.layer.borderWidth = 1;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //*** 调整系统导航栏左右按钮的位置
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -20;
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}

-(void)leftBtnClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 2、导航栏右边按钮
-(void)creatRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 10, 50, 20);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn setTitle:@"点我" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.borderColor = [UIColor blackColor].CGColor;
    rightBtn.layer.borderWidth = 1;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightBtnClick:(UIButton *)btn
{
    NSLog(@"点击导航栏右边按钮");
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

































































