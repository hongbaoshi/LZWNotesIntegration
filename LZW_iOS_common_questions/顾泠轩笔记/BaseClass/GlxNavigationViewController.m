//
//  GlxNavigationViewController.m
//  LZW_iOS_common_questions
//
//  Created by 文艺复兴 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "GlxNavigationViewController.h"
#import "UITabBarController+HideTabBar.h"

@interface GlxNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation GlxNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 }];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 导航控制器代理
//不在导航root页面则隐藏tabbar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(navigationController.viewControllers.count>1){
        [viewController.tabBarController setTabBarHidden:YES];
    }else{
        [viewController.tabBarController setTabBarHidden:NO];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
