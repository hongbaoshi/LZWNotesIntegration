//
//  SixViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/6.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "SixViewController.h"
#import "CircleLHQView.h"
@interface SixViewController ()

@end

@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"6---旋转罗盘";
    CircleLHQView *LHQView = [[CircleLHQView alloc] initWithFrame:CGRectMake(10, 100, 300, 300) andImage:nil];
    LHQView.center = self.view.center;
    [LHQView addSubViewWithSubView:nil andTitle:@[@"第一个",@"第二个",@"第三个",@"第四个",@"第五个",@"第六个"] andSize:CGSizeMake(60, 60) andcenterImage:nil];
    [self.view addSubview:LHQView];
    LHQView.block = ^(NSString *btnNumber){
        NSLog(@"%@",btnNumber);
    };
    
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
