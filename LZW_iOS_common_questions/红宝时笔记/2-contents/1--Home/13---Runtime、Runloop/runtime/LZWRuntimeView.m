//
//  LZWRuntimeView.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/28.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LZWRuntimeView.h"
#import "UIButton+block.h"
#import "TestAddPropety.h"
#import "TestAddPropety+propety.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface LZWRuntimeView()

@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)UIButton *testBtn;


@end
@implementation LZWRuntimeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //*** 主要列举runtime中几个比较实用的方法
        
        self.titleArray = [[NSMutableArray alloc] initWithObjects:@"1、动态绑定传参数",@"2、动态添加属性",@"3、消息发送",@"4、交换方法", nil];
        for (int i = 0; i < self.titleArray.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(50, 100+(40+5)*i, 200, 40);
            [btn setTitle:self.titleArray[i] forState:0];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.backgroundColor = [UIColor orangeColor];
            btn.tag = 1320 + i;
            [btn tapWithEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
                switch (sender.tag)
                {
                    case 1320:
                    {
                        //*** 1、重定义Button的点击事件，运用了运行时的动态绑定；
                        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Runtime" message:@"请看代码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
                        [view show];
                    }
                        break;
                    case 1321:
                    {
                        //*** 2、动态添加属性
                        TestAddPropety *testAddProperty = [[TestAddPropety alloc] init];
                        NSLog(@"打印动态添加的属性:age:%@   name:%@",testAddProperty.age,testAddProperty.name);

                    }
                        break;
                    case 1322:
                    {
                        /*
                         * 3、动态发送消息
                         * Build Setting--> Apple LLVM 8.1 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
                         */
                        objc_msgSend(sender,@selector(setBackgroundColor:),[UIColor redColor]);
                    }
                        break;
                    case 1323:
                    {
                        //*** 4、交换函数方法
                        [self func1];
                    }
                        break;
                    default:
                        break;
                }
            }];
            [self addSubview:btn];
            
        }
    }
    return self;
}




+(void)load
{
    SEL sel1 = @selector(func1);
    SEL sel2 = @selector(func2);
    
    Method m1 = class_getInstanceMethod([self class], sel1);
    Method m2 = class_getInstanceMethod([self class], sel2);
    
    method_exchangeImplementations(m1, m2);
}

-(void)func1
{
    NSLog(@"我是func1");
}

-(void)func2
{
    NSLog(@"我是func2");
}




@end














































