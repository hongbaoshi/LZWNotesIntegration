//
//  LZWRunloopView.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/28.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LZWRunloopView.h"
#import "UIButton+block.h"


@interface LZWRunloopView()

@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSTimer *timerOne;
@property(nonatomic,strong)NSTimer *timerTwo;

@end

@implementation LZWRunloopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //*** 主要列举runtime中几个比较实用的方法
        self.titleArray = [[NSMutableArray alloc] initWithObjects:@"1、观察Runloop状态",@"2、添加计时器到默认model中",@"3、添手动添加计时器到model中",@"4、将延迟执行加入到不同model中", nil];

        for (int i = 0; i < self.titleArray.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(50, 100+(40+5)*i, 250, 40);
            [btn setTitle:self.titleArray[i] forState:0];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.backgroundColor = [UIColor orangeColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = 1330 + i;
            [btn tapWithEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
                switch (sender.tag)
                {
                    case 1330:
                    {
                        //*** 1、给RunLoop添加观察者
//                        [self observer];
                    }
                        break;
                    case 1331:
                    {
                        /*
                         *** 2、自动加载RunLoop下，可以直接运行；加到默认的model里面；
                         *** 滚动视图时，该计时器不会运行
                         */
                        self.timerOne = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(testRunLoop) userInfo:nil repeats:YES];
                        [self.timerOne fire];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                            [self.timerOne invalidate];
                        });
                    }
                        break;
                    case 1332:
                    {
                        //3、手动添加到RunLoop
                         self.timerTwo = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(testRunLoop) userInfo:nil repeats:YES];
                        //默认模式  NSDefaultRunLoopMode
                        //滚动模式  UITrackingRunLoopMode   滚动的时候将timer添加到RunLoop
                        //加入到modes中         NSRunLoopCommonModes
                        
                        [[NSRunLoop mainRunLoop] addTimer:self.timerTwo forMode:NSRunLoopCommonModes];
                        [self.timerTwo fire];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                            [self.timerTwo invalidate];
                        });
                    }
                        break;
                    case 1333:
                    {
                        /*
                         **** 3、延迟执行加入不同mode
                         */
                        [self performSelector];
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

#pragma mark --- 1、给RunLoop添加观察者
-(void)observer
{
    
    //如果给RunLoop添加观察者，需要用到CF类；
    //创建observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        //打印RunLoop的状态
        NSLog(@"%lu",activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
}

-(void)testRunLoop
{
    NSLog(@"---123---");
}

#pragma mark --- 2、延迟执行加入不同mode
-(void)performSelector{
    /*
     NSDefaultRunLoopMode   默认model
     UITrackingRunLoopMode  滚动model
     NSRunLoopCommonModes   所有model
     */
    
    [self performSelector:@selector(testRunLoopMode) withObject:nil afterDelay:0.1 inModes:@[UITrackingRunLoopMode]];
}

-(void)testRunLoopMode
{
    NSLog(@"延迟执行---123---");
}




@end














































