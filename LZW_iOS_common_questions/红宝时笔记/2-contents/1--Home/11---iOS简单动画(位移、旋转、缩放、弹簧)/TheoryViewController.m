//
//  TheoryViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TheoryViewController.h"

@interface TheoryViewController ()

@end

@implementation TheoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    textView.text = [NSString stringWithFormat:@"1、12个动画原理（迪士尼出品）  \n"
                                                "        https://vimeo.com/93206523   \n"
                                                "2、Good artists copy , great atrists steal   \n"
                                                "        https://dribbble.com   \n"
                                                "        https://capptivate.co/    \n"
                                                "        https://pttrns.com/    \n"
                                                "        www.google.com/design/spec/animation   \n"
                                                "4、sketch——移动应用UI设计软件"];
    textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textView];
    
    
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
