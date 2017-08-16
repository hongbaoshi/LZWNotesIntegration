//
//  MyViewController.m
//  TestNotification
//
//  Created by 红宝时 on 2017/5/30.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TestKvoViewController.h"
#import "MyModel.h"
@interface TestKvoViewController ()



@end

@implementation TestKvoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.model setValue:@"哈哈哈哈哈哈啊哈" forKey:@"message"];
}

-(void)viewWillAppear:(BOOL)animated{

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
