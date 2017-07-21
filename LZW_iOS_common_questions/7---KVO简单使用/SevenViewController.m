//
//  SevenViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/6.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "SevenViewController.h"
#import "TestKvoViewController.h"
#import "MyModel.h"
@interface SevenViewController ()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)MyModel *model;
@property(nonatomic,assign)BOOL isColor;

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //*** 1、KVO的简单使用
    [self testObserver];
    
}


#pragma mark --- 1、KVO的简单使用
-(void)testObserver{
    
    _isColor = YES;
    _model = [[MyModel alloc] init];
    [_model setValue:@"石松岩是傻逼" forKey:@"message"];
    [self.model addObserver:self forKeyPath:@"message" options:NSKeyValueObservingOptionNew context:nil];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _label.textColor = [UIColor redColor];
    _label.text = _model.message;
    [self.view addSubview:_label];
    
    
    //*** 1、添加两个按钮
    NSArray *titleArr = @[@"1---跳转界面修改",@"2---本界面修改"];
    for (int i = 0; i< 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 200 + i*60, 200, 40);
        btn.center = CGPointMake(self.view.center.x, 200 + i*60);
        [btn setTitle:titleArr[i] forState:0];
        btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.40 blue:0.84 alpha:1.00];
        btn.tag = 170 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 170)
    {
        //*** 1、跳转界面修改
        TestKvoViewController *vcr = [[TestKvoViewController alloc] init];
        vcr.model = _model;
        [self.navigationController pushViewController:vcr animated:YES];
    }else if(btn.tag == 171)
    {
        //*** 2、本界面修改
        if (_isColor) {
            [self.model setValue:@"123456" forKey:@"message"];
        }else{
            [self.model setValue:@"石松岩——甭怕拉米就" forKey:@"message"];
        }
        _isColor = !_isColor;
    }
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"message"]) {
        _label.text = change[@"new"];
    }
}

- (void)dealloc
{
    [self.model removeObserver:self forKeyPath:@"message"];
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
