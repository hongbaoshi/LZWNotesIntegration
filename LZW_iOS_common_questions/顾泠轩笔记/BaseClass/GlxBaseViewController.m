//
//  BaseViewController.m
//  LZW_iOS_common_questions
//
//  Created by 文艺复兴 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "GlxBaseViewController.h"

@interface GlxBaseViewController ()

@end

@implementation GlxBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航颜色
    [self setNavBackground];
    [self loadData];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
}

-(void)loadData
{
    
}

//设置title
-(void)setNavTitle:(NSString *)title{
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

//设置导航
-(void)setNavBackground
{
    
    //导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:179/255.0 green:219/255.0 blue:158/255.0 alpha:0.5]];
}
//设置返回按钮
- (void)setupNavBackButton
{
    UIImage* img1=[[UIImage imageNamed:@"glxback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem*barItem1 = [[UIBarButtonItem alloc]
                                initWithImage:img1
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(goBackAction)];
    self.navigationItem.leftBarButtonItem = barItem1;
}

//设置导航右键
- (void)createNavigationBarRightBarButtonItemWithTitle:(NSString *)title {
    [self createNavigationBarRightBarButtonItemWithTitle:title style:UIBarButtonItemStylePlain];
}
- (void)createNavigationBarRightBarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style {
    [self createNavigationBarRightBarButtonItemWithTitle:title style:style target:self action:@selector(rightAction)];
}

- (void)createNavigationBarRightBarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    //这个可以简单的理解为特殊的按钮，不需要我们去考虑布局，只要实现样式和内容，系统为我们进行布局。
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTintColor:[UIColor grayColor]];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];;
    self.navigationItem.rightBarButtonItem = right;
    
}


//返回
- (void)goBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右键响应方法
- (void)rightAction
{
    
}

@end
