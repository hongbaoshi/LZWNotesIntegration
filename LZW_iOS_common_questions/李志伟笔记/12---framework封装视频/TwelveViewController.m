//
//  TwelveViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TwelveViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface TwelveViewController ()

@property(nonatomic,strong)AVPlayer *player;

@end

@implementation TwelveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置播放的url
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1111" ofType:@"mp4"]];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    //设置播放进度的默认值
//    self.progressSlider.value = 0;
    //设置播放的默认音量值
    self.player.volume = 1.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
















































