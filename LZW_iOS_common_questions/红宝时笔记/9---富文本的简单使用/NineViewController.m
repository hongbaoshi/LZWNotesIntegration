//
//  NineViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/12.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "NineViewController.h"

@interface NineViewController ()

@end

@implementation NineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"9---富文本的简单使用";
    [self testFuWenBen];
    
}


-(void)testFuWenBen
{
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 320, 30)];
    testLabel.backgroundColor = [UIColor lightGrayColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    
    //*** 1、改变中间部分字体颜色
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"今天天气不错呀"];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:18.0]
                          range:NSMakeRange(2, 2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor greenColor]
                          range:NSMakeRange(2, 2)];
    //    testLabel.attributedText = AttributedStr;
    
    
    //*** 2、添加图片
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"sina"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 20, 20);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [AttributedStr insertAttributedString:string atIndex:4];
    //    [AttributedStr appendAttributedString:string];
    
    // 用label的attributedText属性来使用富文本
    testLabel.attributedText = AttributedStr;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end












































