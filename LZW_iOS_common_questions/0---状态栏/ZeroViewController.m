//
//  ZeroViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/6/30.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ZeroViewController.h"

@interface ZeroViewController ()

@end

@implementation ZeroViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
#pragma mark --- 1、隐藏整个项目状态栏的方法
    /*
    1）在Info.plist中增加 Status bar is initially hidden一行,选择为 YES,
    2）还需增加 View controller-based status bar appearance 一行,选择为 NO。
    这个方法支持iOS7及以后的系统，iOS9以后，通过[UIApplication sharedApplication] 取得app的单例，然后调用setStatusBarHidden方法隐藏 Status Bar的方法作废！
     */
    
#pragma mark --- 2、值隐藏当前视图状态栏
    /*
     1）只增加Status bar is initially hidden－YES
     2）添加如下方法：
     -(BOOL)prefersStatusBarHidden{
     return YES;
     }
     */
    
#pragma mark --- 3、改变状态栏背景颜色
    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    
#pragma mark --- 4、改变状态栏的文字颜色
    //*** 1、如果有导航栏，以下方法改变状态栏文字颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //*** 2、如果没有导航栏，用- (UIStatusBarStyle)preferredStatusBarStyle;
    /*
     - (UIStatusBarStyle)preferredStatusBarStyle{
     return UIStatusBarStyleLightContent;
     }

     */
}



//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
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
