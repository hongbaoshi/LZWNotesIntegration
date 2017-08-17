//
//  PPBaseTabBarViewController.m
//  PPTabBarDemo
//
//  Created by dingfang on 2016/12/7.
//  Copyright © 2016年 dingfang. All rights reserved.
//

#import "PPBaseTabBarViewController.h"
#import "PPBaseNavigationViewController.h"
#import "PPHomeController.h"
#import "PPAddressController.h"
#import "PPFoundViewController.h"
#import "PPMineController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

@interface PPBaseTabBarViewController () <UITabBarControllerDelegate>
@end

@implementation PPBaseTabBarViewController

+ (void)initialize
{
   if (self == [PPBaseTabBarViewController class]) {
    
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
    [self setupChildVc:[[PPHomeController alloc]init] title:@"主页" image:@"tushuguan" selectedImage:@"tushuguan_dj"];
    [self setupChildVc:[[PPAddressController alloc]init] title:@"PP" image:@"shujia" selectedImage:@"shujia-dj"];
    [self setupChildVc:[[PPFoundViewController alloc]init] title:@"发现" image:@"wode" selectedImage:@"wode-dj"];
    [self setupChildVc:[[PPMineController alloc]init] title:@"我的" image:@"wode" selectedImage:@"wode-dj"];

    // Do any additional setup after loading the view.
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
    PPBaseNavigationViewController *nav = [[PPBaseNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UITabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex==0) {
       
    }else if (tabBarController.selectedIndex==1){
        
    }else if (tabBarController.selectedIndex==2){
        
    }
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










