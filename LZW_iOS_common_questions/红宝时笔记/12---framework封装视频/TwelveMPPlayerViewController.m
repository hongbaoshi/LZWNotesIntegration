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

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器

@end

@implementation TwelveMPPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //*** 1、创建UI
    [self createUI];
    
    
    
    //*** 2、添加通知
    [self addNotification];
    
}

#pragma mark --- 1、创建UI
-(void)createUI
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    //*** 4个视频播放按钮
    NSArray *titleArr = @[@"视频1",@"视频2",@"视频3",@"视频4"];
    for (int i = 0; i < 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+(i%2)*((self.view.bounds.size.width-90)/2+30), 370+(i/2)*60, (self.view.bounds.size.width-90)/2, 40);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:titleArr[i] forState:0];
        btn.tag = 223 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark --- 2、点击四个播放按钮
-(void)btnClick:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 223:
        {
            [self createMPPlayerWithResource:@"1111.mp4"];
        }
            break;
        case 224:
        {
            [self createMPPlayerWithResource:@"2222.mp4"];
        }
            break;
        case 225:
        {
            [self createMPPlayerWithResource:@"3333.mp4"];
        }
            break;
        case 226:
        {
            [self createMPPlayerWithResource:@"4444.mp4"];

        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- 3、创建播放器，播放视频
-(void)createMPPlayerWithResource:(NSString *)resource
{
    NSURL *url=[self getFileUrlWithResource:resource];
    self.moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
    self.moviePlayer.view.frame=CGRectMake(0, 64, self.view.bounds.size.width, 300);
    self.moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.moviePlayer.backgroundView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_moviePlayer.view];
    
    [self.moviePlayer play];
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
-(NSURL *)getFileUrlWithResource:(NSString *)resource
{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:resource ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}


/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification
{
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


























