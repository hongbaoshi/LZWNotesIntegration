//
//  RaopipiViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "RaopipiViewController.h"
#import "PPBaseTabBarViewController.h"

@interface RaopipiViewController ()
@property(nonatomic,strong)PPBaseTabBarViewController * tabBarVc;

@end

@implementation RaopipiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    [UIApplication sharedApplication].delegate.window.rootViewController=self.tabBarVc;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(PPBaseTabBarViewController *)tabBarVc{
    
    if (!_tabBarVc) {
        
        _tabBarVc=[[PPBaseTabBarViewController alloc]init];
    }
    return _tabBarVc;
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
