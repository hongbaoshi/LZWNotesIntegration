//
//  FiveWebViewInteraction.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/3.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FiveWebViewInteraction.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface FiveWebViewInteraction ()<UIWebViewDelegate>

@property (nonatomic)UIWebView *webView; //记载本地html文件的网页
@property (nonatomic)JSContext *jsContext;
@property (nonnull,strong) UIButton *btn; //OC调用H5页面按钮

@end

@implementation FiveWebViewInteraction

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:_webView];
    //加载本地的html文件
    self.webView.backgroundColor = [UIColor whiteColor];
    NSString *str = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:nil];
    
    
    //1、  在上面添加一个按钮，实现oc端控制h5实现弹alert方法框
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 250, 40)];
    [self.btn setTitle:@"OC调H5方法" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.69 blue:0.07 alpha:1.00];
    [self.btn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
}

#pragma mark --- 1、  在上面添加一个按钮，实现oc端控制h5实现弹alert方法框
//OC调用H5页面方法
- (void)showAlert
{
    //1、调用提示框
    //要将script的alert()方法转化为string类型
    NSString *alertJs=@"alert('OC调用webview的弹出展示窗口')";
    [_jsContext evaluateScript:alertJs];
    
////    2、自己添加方法，自己调用
//    [_jsContext evaluateScript:@"function add(a, b) { return a + b; }"];
//    // 根据下标取出方法
//    JSValue *add = _jsContext[@"add"];
//    NSLog(@"Func: %@", add);
//    // 传入参数 调用取到的方法
//    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
//    NSLog(@"Sum: %d",[sum toInt32]);
    
    
    //3、OC调用js的异常输出
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        //比如把js中的方法名改掉，OC找不到相应方法，这里就会打印异常信息
        NSLog(@"异常信息：%@", exception);
    };
    
}


#pragma mark --- UIWebViewDelegate
#pragma mark --- 2、js调用OC的第一种方法，block代码块调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //1、通过id、class选择器获取H5页面的元素，决定是否隐藏；也可以进行其他操作；
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('header').hidden='YES'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('header')[0].hidden='YES'"];
    
    
    //2、H5页面调用OC代码；
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"startFunction"] =^(id obj){
        ////这里通过block回调从而获得h5传来的json数据
        /*block中捕获JSContexts
         我们知道block会默认强引用它所捕获的对象，如下代码所示，如果block中直接使用context也会造成循环引用，这使用我们最好采用[JSContext currentContext]来获取当前的JSContext:
         */
        [JSContext currentContext];
        NSData *data = [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding ];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@" data   %@   ======  ShareUrl %@",obj,dict[@"shareUrl"]);
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end








































