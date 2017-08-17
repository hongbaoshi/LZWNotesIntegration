//
//  LZWHomeViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/14.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LZWHomeViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface LZWHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *lzwTestTableView;

@property(nonatomic,strong)NSMutableArray *titleDataArray;


@property(nonatomic,strong)CMMotionManager *motionManager;//添加重力感应器
@property(assign, nonatomic) NSTimeInterval gyroUpdateInterval;
@property(nonatomic,assign)double accZ; //z轴方向的偏移量；

@end

@implementation LZWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleDataArray = [NSMutableArray arrayWithArray:@[
                                                       @[@"00---状态栏操作",@"ZeroViewController"],
                                                       @[@"01---导航栏操作",@"OneViewController"],
                                                       @[@"02---公用方法(见:公用类文件夹)",@""],
                                                       @[@"03---代码截屏",@"ThreeViewController"],
                                                       @[@"04---多线程",@"FourViewController"],
                                                       @[@"05---JS交互",@"FiveViewController"],
                                                       @[@"06---旋转罗盘",@"SixViewController"],
                                                       @[@"07---KVO简单使用",@"SevenViewController"],
                                                       @[@"08---自己封装的类",@"EightViewController"],
                                                       @[@"09---富文本的简单实用",@"NineViewController"],
                                                       @[@"10---UIImageView详解",@"TenViewController"],
                                                       @[@"11---iOS简单动画(位移、旋转、缩放、弹簧)",@"ElevenViewController"],
                                                       @[@"12---怎样封装framework视频",@"TwelveViewController"],
                                                       @[@"13---",@""],
                                                       @[@"14---",@""],
                                                       @[@"15---",@""],
                                                       @[@"16---",@""],
                                                       @[@"17---",@""],
                                                       @[@"18---",@""],
                                                       @[@"19---",@""],
                                                       @[@"20---",@""]
                                                       ]];
    
    
    //*** 1、添加lzwTestTableView
    _lzwTestTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _lzwTestTableView.delegate = self;
    _lzwTestTableView.dataSource = self;
    [self.view addSubview:_lzwTestTableView];
    
    //*** 2、添加重力感应器，用于返回首次进入页面
    [self accelerotionDataMethod];
}


#pragma mark --- 1、设置重力感应器：用于返回进入的首页
-(void)accelerotionDataMethod
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.gyroUpdateInterval = 0.2;
    self.motionManager.accelerometerUpdateInterval = self.gyroUpdateInterval;
    __weak LZWHomeViewController *weakself = self;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [weakself outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    [self.motionManager startGyroUpdates];
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    self.accZ = acceleration.z;
    
    if (self.accZ >= 0.2)
    {
        [self.motionManager stopAccelerometerUpdates];
        
        [[AllPublicMethod sharedAllPublicMethod] backToFirstView];
    }
    
}



#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _titleDataArray[indexPath.row][0];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark --- 1、根据字符串获取类名
    Class A = NSClassFromString(_titleDataArray[indexPath.row][1]);
    UIViewController *vcr = [[A alloc] init];
    [self.navigationController pushViewController:vcr animated:YES];
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
