//
//  LZWTabBarController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LZWTabBarController.h"
#import "LZWNavigationController.h"
#import "LZWHomeViewController.h"
#import "LZWPersonViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]
@interface LZWTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LZWTabBarController

+ (void)initialize
{
    if (self == [LZWTabBarController class])
    {
        
        // 通过appearance统一设置所有UITabBarItem的文字属性
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x999999);
        
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xDD403B);
        
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupChildVc:[[LZWHomeViewController alloc]init] title:@"主页" image:@"tushuguan" selectedImage:@"tushuguan_dj"];
    [self setupChildVc:[[LZWPersonViewController alloc]init] title:@"我的" image:@"wode" selectedImage:@"wode-dj"];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    LZWNavigationController *nav = [[LZWNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

#pragma mark --UITabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex==0) {
        
    }else if (tabBarController.selectedIndex==1){
        
    }else if (tabBarController.selectedIndex==2){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




















































