//
//  TwelveMPPlayerViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/14.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TwelveMPPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TwelveMPPlayerViewController ()

@property(nonatomic,strong)NSString *sourceStr;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器

@end

@implementation TwelveMPPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *titleArr = @[@"视频1",@"视频2",@"视频3",@"视频4"];
    
    for (int i = 0; i < 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 100+i*60, 100, 40);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:titleArr[i] forState:0];
        btn.tag = 222 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
//    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
}


-(void)btnClick:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 222:
        {
            self.sourceStr = @"1111.mp4";
            //播放
            [self.moviePlayer play];
        }
            break;
        case 223:
        {
            self.sourceStr = @"2222.mp4";
            //播放
            [self.moviePlayer play];
        }
            break;
        case 224:
        {
            self.sourceStr = @"3333.mp4";
            //播放
            [self.moviePlayer play];
        }
            break;
        case 225:
        {
            self.sourceStr = @"4444.mp4";
            //播放
            [self.moviePlayer play];
        }
            break;
            
        default:
            break;
    }
}


-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl
{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"2222.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer)
    {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=CGRectMake(100, 64, self.view.bounds.size.width-100, self.view.bounds.size.height-64);
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}


/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}


/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification
{
    switch (self.moviePlayer.playbackState)
    {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification
{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end


























