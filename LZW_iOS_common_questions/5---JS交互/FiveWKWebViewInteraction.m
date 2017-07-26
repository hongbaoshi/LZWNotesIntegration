//
//  FiveWKWebViewInteraction.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/3.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FiveWKWebViewInteraction.h"
#import <WebKit/WebKit.h>

@interface FiveWKWebViewInteraction ()<WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation FiveWKWebViewInteraction

#pragma mark --- 1、加载WKWebView
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //*** 1、加载网页
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) configuration:config];
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wkIndex" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.wkWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    
    //*** 2、添加回调方法名
    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"showName"];
    [userCC addScriptMessageHandler:self name:@"showSendMsg"];
    
}

#pragma mark --- 2、OC调用HTML页面，修改页面显示内容
//网页加载完成之后调用JS代码才会执行，因为这个时候html页面已经注入到webView中并且可以响应到对应方法
- (IBAction)btnClick:(UIButton *)sender {
    
    if (!self.wkWebView.loading) {
        
    
        
        if (sender.tag == 123)
        {
            [self.wkWebView evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error)
            {
                //TODO
                NSLog(@"%@ %@",response,error);
            }];
        }
        
        if (sender.tag == 234)
        {
            [self.wkWebView evaluateJavaScript:@"alertName('小红')" completionHandler:nil];
        }
        
        if (sender.tag == 345)
        {
            [self.wkWebView evaluateJavaScript:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')" completionHandler:nil];
        }
        
    } else {
        NSLog(@"the view is currently loading content");
    }
}


#pragma mark --- 3、WKScriptMessageHandler  JS调用OC的回调方法

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showMsg:@"我是下面的小红 手机号是:18870707070"];
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",message.body];
        [self showMsg:info];
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        NSArray *array = message.body;
        NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",array.firstObject,array.lastObject];
        [self showMsg:info];
    }
}

- (void)showMsg:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}



- (IBAction)clear:(UIButton *)sender {
    [self.wkWebView evaluateJavaScript:@"clear()" completionHandler:nil];
}




#pragma mark --- 4、WKUIDelegate 显示html页面警告窗口
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    completionHandler(YES);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end










































