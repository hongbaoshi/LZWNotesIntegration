//
//  FourOperationTableViewShow.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/3.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "FourOperationTableViewShow.h"

@interface FourOperationTableViewShow ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *operationTableView;
@property(nonatomic,strong)NSMutableArray *operationDataArr;

@end

@implementation FourOperationTableViewShow

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _operationTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _operationTableView.delegate = self;
    _operationTableView.dataSource = self;
    [self.view addSubview:_operationTableView];
    
    _operationDataArr = [NSMutableArray arrayWithArray:@[
                                                @"1、创建NSInvocationOperation对象",
                                                @"2、创建NSBlockOperation对象",
                                                @"3、创建任务队列",
                                                @"4、子线程给主线程传值"
                                                ]];
}

#pragma mark --- UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"operationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSLog(@"%@",indexPath);
    cell.textLabel.text = _operationDataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //*** 1、创建NSInvocationOperation对象
            [self creatNSInvocationOperation];
        }
            break;
        case 1:
        {
            //*** 2、创建NSBlockOperation对象
            [self creatNSBlockOperation];
        }
            break;
        case 2:
        {
            //*** 3、创建任务队列
            [self creatQueue];
        }
            break;
        case 3:
        {
            //*** 4、子线程给主线程传值
                [self passValue];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark --- 1、创建NSInvocationOperation对象
-(void)creatNSInvocationOperation{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationDaYin) object:nil];
    [operation start];
}

-(void)operationDaYin
{
    NSLog(@"operation的打印内容：00000000000---%@", [NSThread currentThread]);
}


#pragma mark --- 2、创建NSBlockOperation对象
-(void)creatNSBlockOperation{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation1打印内容：111111111111---%@", [NSThread currentThread]);
    }];
    //该方式创建可以添加额外任务，任务执行没有先后顺序；
    [operation1 addExecutionBlock:^{
        NSLog(@"operation1添加的额外任务：1111111*****---%@", [NSThread currentThread]);
        
    }];
    [operation1 start];
    
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation2打印内容:222222222---%@", [NSThread currentThread]);
    }];
    [operation2 start];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation3打印内容：3333333---%@", [NSThread currentThread]);
    }];
    [operation3 start];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation4打印内容：444444444444---%@", [NSThread currentThread]);
    }];
    [operation4 start];
    NSBlockOperation *operation5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation5打印内容：555555555555---%@", [NSThread currentThread]);
    }];
    [operation5 start];
    NSBlockOperation *operation6 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation6打印内容：6666666666666---%@", [NSThread currentThread]);
    }];
    [operation6 start];
}


#pragma mark --- 3、创建队列
-(void)creatQueue{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation1打印内容：111111111111---%@", [NSThread currentThread]);
    }];
    [operation1 addExecutionBlock:^{
        NSLog(@"operation1添加的额外任务：1111111*****---%@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation2打印内容:222222222---%@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation3打印内容：3333333---%@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation4打印内容：44444444---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation5打印内容：55555555---%@", [NSThread currentThread]);
    }];
    
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    //给添加入队列中的线程排序:即队列中添加依赖关系
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    [operation4 addDependency:operation3];
    [operation5 addDependency:operation4];
    
    [q addOperation:operation1];
    [q addOperation:operation2];
    [q addOperation:operation3];
    [q addOperation:operation4];
    [q addOperation:operation5];
    [q setMaxConcurrentOperationCount:1];   //设置队列的最大并行数；为1为串行队列,否则为并行队列；
    
    NSLog(@"主线程中打印的内容");
}


#pragma mark --- 4、子线程给主线程传值
-(void)passValue{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"子线程的打印---%@", [NSThread currentThread]);
        
        //4、子线程给主线程传值的两种方法：该方法会在主线程执行完之后再调用；优先选择第二种方法
        //                [self performSelectorOnMainThread:@selector(log:) withObject:@"1111111111" waitUntilDone:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"从子线程回到主线程打印的内容：***************---%@", [NSThread currentThread]);
        });
    }];
    [operation start];
}


-(void)log:(NSString *)str
{
    NSLog(@"子线程传给主线程的值：%@",str);
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
