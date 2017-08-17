//
//  AllPublicMethod.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "AllPublicMethod.h"
#import "ViewController.h"
@implementation AllPublicMethod

LZWSingletonM(AllPublicMethod)

#pragma mark --- 1、回到初始化首页
-(void)backToFirstView
{
    UINavigationController * naVC=[[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    [UIApplication sharedApplication].delegate.window.rootViewController=naVC;
}


@end
