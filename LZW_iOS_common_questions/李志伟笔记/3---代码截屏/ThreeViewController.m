//
//  ThreeViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/1.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3---代码截屏";
    /*
     **** 在info.plist文件加“Privacy - Photo Library Usage Description”字段
     */
    
    //*** 1、添加一个label
    self.view.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    label.text = [NSString stringWithFormat:@"截屏测试:%@",[self getCurrentTime]];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    //*** 2、截屏
    UIImage *image = [self getNormalImage:self.view];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}

#pragma mark --- 1、获取截图的图片
-(UIImage *)getNormalImage:(UIView *)view
{
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark --- 2、获取当前时间
-(NSString *)getCurrentTime
{
    /*说明下格式对应的意义
     
     YYYY（年）/MM（月）/dd（日） hh（时）:mm（分）:ss（秒） SS（毫秒）
     需要用哪个的话就把哪个格式加上去。
     值得注意的是，如果想显示两位数的年份的话，可以用”YY/MM/dd hh:mm:ss SS”，两个Y代表两位数的年份。
     而且大写的M和小写的m代表的意思也不一样。“M”代表月份，“m”代码分钟
     “HH”代表24小时制，“hh”代表12小时制*/
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end













































