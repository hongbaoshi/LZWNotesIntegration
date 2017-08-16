//
//  TwelveStudyViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TwelveStudyViewController.h"
#import <WebKit/WebKit.h>

@interface TwelveStudyViewController ()

@property(nonatomic,strong)WKWebView *twelveWKWebView;

@end

@implementation TwelveStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.twelveWKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //防止访问链接中的空格和中文的出现导致不能访问；；
    NSString *str = @"http://www.cnblogs.com/kenshincui/p/4186022.html";
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];//去空格  去中文
//    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.twelveWKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.twelveWKWebView];
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
