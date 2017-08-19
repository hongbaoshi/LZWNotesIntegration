//
//  GulingxuanViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "GulingxuanViewController.h"
#import "GlxNavigationViewController.h"
#import "GlxDirectoryViewController.h"


@interface GulingxuanViewController ()

@end

@implementation GulingxuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GlxNavigationViewController *gvc = [[GlxNavigationViewController alloc]initWithRootViewController:[[GlxDirectoryViewController alloc]init]];
    kAppWindow.rootViewController = gvc;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"伟神皮神带我飞~");
    
}



@end
