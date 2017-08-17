//
//  FourGCDTableViewShow.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/3.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FourGCDTableViewShow.h"
#import "MyViewController.h"
@interface FourGCDTableViewShow ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *gcdTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FourGCDTableViewShow

#pragma mark -------------   总结如下  ----------------
/*
 总结
 1. 开不开线程，取决于执行任务的函数，同步不开，异步开。
 
 2. 开几条线程，取决于队列，串行开一条，并发开多条(异步)
 
 3. 主队列：专门用来在主线程上调度任务的"队列"，主队列不能在其他线程中调度任务！
 
 4. 如果主线程上当前正在有执行的任务，主队列暂时不会调度任务的执行！主队列同步任务，会造成死锁。原因是循环等待
 
 5. 同步任务可以队列调度多个异步任务前，指定一个同步任务，让所有的异步任务，等待同步任务执行完成，这是依赖关系。
 
 6. 全局队列：并发，能够调度多个线程，执行效率高，但是相对费电。 串行队列效率较低，省电省流量，或者是任务之间需要依赖也可以使用串行队列。
 
 7. 也可以通过判断当前用户的网络环境来决定开的线程数。WIFI下6条，3G/4G下2～3条。
 */



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _gcdTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _gcdTableView.delegate = self;
    _gcdTableView.dataSource = self;
    [self.view addSubview:_gcdTableView];
    
    _dataArray = [NSMutableArray arrayWithArray:@[
                                                  @"0、异步执行某项任务，然后再回到主线程",
                                                  @"1、延迟执行",
                                                  @"2、创建单利",
                                                  @"3、全局队列",
                                                  @"4、串行队列，同步执行",
                                                  @"5、串行队列，异步执行",
                                                  @"6、并行队列，异步执行",
                                                  @"7、并行队列，同步执行",
                                                  @"8、主队列，异步执行",
                                                  @"9、主队列，同步执行",
                                                  @"10、同步任务的使用场景"
                                                  ]];
}


#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"gcdCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //*** 0、异步执行某项任务，然后再回到主线程
            [self commonUserMethod];
        }
            break;
        case 1:
        {
            //*** 1、延迟执行
            [self delayDoSomething];
        }
            break;
        case 2:
        {
            //*** 2、创建单利
            [self creatSingle];
        }
            break;
        case 3:
        {
            //*** 3、全局队列
            [self creatQuanJuQueue];
        }
            break;
        case 4:
        {
            //*** 4、串行队列，同步执行
            [self creatQueue];
        }
            break;
        case 5:
        {
            //*** 5、串行队列，异步执行
            [self creatYiBu];
        }
            break;
        case 6:
        {
            //*** 6、并行队列，异步执行
            [self creatBingYi];
        }
            break;
        case 7:
        {
            //*** 7、并行队列，同步执行
            [self creatBingTong];
        }
            break;
        case 8:
        {
            //*** 8、主队列，异步执行
            [self creatZhuYi];
        }
            break;
        case 9:
        {
            //*** 9、主队列，同步执行
            [self creatZhuTong];
        }
            break;
        case 10:
        {
            //*** 10、同步任务的使用场景
            [self useTongBu];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- 0、异步执行某项任务，然后再回到主线程
-(void)commonUserMethod
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"异步执行 %@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程的打印 %@",[NSThread currentThread]);
        });
    });
}


#pragma mark --- 1、延迟执行
-(void)delayDoSomething{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"延迟执行3秒后执行打印");
        
    });
}



#pragma mark --- 2、创建单利
-(void)creatSingle{
    MyViewController *vcr1 = [MyViewController creatMyViewController];
    NSLog(@"11111111111的地址%p",vcr1);
    MyViewController *vcr2 = [MyViewController creatMyViewController];
    NSLog(@"22222222222的地址%p",vcr2);
}



#pragma mark --- 3、全局队列
//全局队列的本质就是并发队列，只是在后面加入了，“服务质量”，和“调度优先级” 两个参数，这两个参数一般为了系统间的适配，最好直接填0和0。
-(void)creatQuanJuQueue{
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
        //        dispatch_sync(q, ^{
        //            NSLog(@"%@ %d", [NSThread currentThread], i);
        //        });
    }
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"主线程的打印");
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //    });
}


#pragma mark --- 4、串行队列，同步执行
//执行结果可以清楚的看到全在主线程执行，并且是按照数序执行，循环结束之后主线程的打印才输出
-(void)creatQueue
{
    dispatch_queue_t q = dispatch_queue_create("dantesx", NULL);
    
    // 执行任务
    for (int i = 0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    NSLog(@"主线程的打印");
}

#pragma mark --- 5、串行队列，异步执行
//结果显示，系统开了1条异步线程，因此全部在线程2执行，并且是顺序执行。主线程打印虽然在最上面，但是这个先后顺序是不确定，如果睡个0.001秒，主线程的打印会混在中间。
-(void)creatYiBu{
    dispatch_queue_t q = dispatch_queue_create("dantesx", NULL);
    
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    //    [NSThread sleepForTimeInterval:0.001];
    NSLog(@"主线程打印");
}


#pragma mark --- 6、并行队列，异步执行
//结果显示，主线程的打印还是混在中间不确定的，因为异步线程就是谁也不等谁。系统开了多条线程，并且执行的顺序也是乱序的
-(void)creatBingYi{
    // 1. 队列
    dispatch_queue_t q = dispatch_queue_create("dantesx", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 异步执行
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    //    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"主线程打印");
}


#pragma mark --- 7、并行队列，同步执行
/*
 这个运行结果和第1种的串行队列，同步执行是一模一样的。 因为同步任务的概念就是按顺序执行，后面都要等。言外之意就是不允许多开线程。 同步和异步则是决定开一条还是开多条。
 所以一旦是同步执行，前面什么队列已经没区别了。*/
-(void)creatBingTong{
    // 1. 队列
    dispatch_queue_t q = dispatch_queue_create("dantesx", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 同步执行
    for (int i = 0; i<10; i++) {
        dispatch_sync(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    //    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"主线程打印");
}


#pragma mark --- 8、主队列，异步执行
//主线程在睡会之后才打印，循环一直在等着。因为主队列的任务虽然会加到主线程中执行，但是如果主线程里也有任务就必须等主线程任务执行完才轮到主队列的。
-(void)creatZhuYi{
    // 1. 主队列 － 程序启动之后已经存在主线程，主队列同样存在
    dispatch_queue_t q = dispatch_get_main_queue();
    // 2. 安排一个任务
    for (int i = 0; i<10; i++) {
        dispatch_async(q, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    NSLog(@"睡会");
    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"主线程打印");
}


#pragma mark --- 9、主队列，同步执行
/*
 运行结果为卡死
 卡死的原因是循环等待，主队列的东西要等主线程执行完，而因为是同步执行不能开线程，所以下面的任务要等上面的任务执行完，所以卡死。这是排列组合中唯一一个会卡死的组合。
 */
-(void)creatZhuTong{
    dispatch_queue_t q = dispatch_get_main_queue();
    
    NSLog(@"卡死了吗？");
    
    dispatch_sync(q, ^{
        NSLog(@"我来了");
    });
    
    NSLog(@"主线程打印");
}

#pragma mark --- 10、同步任务的使用场景
/*
 结果显示，“用户登陆”在主线程打印，后两个在异步线程打印。上面的“用户登陆”使用同步执行，后面的扣费和下载都是异步执行。所以“用户登陆”必须第一个打印出来不管等多久，然后后面的两个异步和主线程打印会不确定顺序的打印。这就是日常开发中，那些后面对其有依赖的必须要先执行的任务使用同步执行，然后反正都要执行先后顺序无所谓的使用异步执行。
 */
-(void)useTongBu{
    dispatch_queue_t q = dispatch_queue_create("dantesx", DISPATCH_QUEUE_CONCURRENT);
    
    [self dodododo];
    
    // 1. 用户登录，必须要第一个执行
    dispatch_sync(q, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"用户登录 %@", [NSThread currentThread]);
    });
    // 2. 扣费
    dispatch_async(q, ^{
        NSLog(@"扣费 %@", [NSThread currentThread]);
    });
    // 3. 下载
    dispatch_async(q, ^{
        NSLog(@"下载 %@", [NSThread currentThread]);
    });
    NSLog(@"主线程打印");
}


-(void)dodododo{
    NSLog(@"d********");
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

































