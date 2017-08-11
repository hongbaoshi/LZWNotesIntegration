//
//  TenViewController.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/8/11.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TenViewController.h"

//*** 2、截图
#import <AssetsLibrary/AssetsLibrary.h> //这个类用于检测是否开启相册权限
#import <Photos/Photos.h>       //iOS9之后用这个库

//*** 3、gif转png
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface TenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tenTableView;
@property(nonatomic,strong)NSMutableArray *tenDataArray;

@end

@implementation TenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tenDataArray = [NSMutableArray arrayWithArray:@[
                                                         @"1、保存图片到相册",
                                                         @"2、截图并保存到相册",
                                                         @"3、GIF图片转PNG",
                                                         @"4、GIF图片展示",
                                                         @"5、合成GIF图片",
                                                         @"6、检测两种加载图片方式消耗内存"]];
    
    [self createUI];
    
}


-(void)createUI
{
    self.tenTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tenTableView.delegate = self;
    self.tenTableView.dataSource = self;
    [self.view addSubview:self.tenTableView];
}



#pragma mark --- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tenDataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"tenViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.tenDataArray[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            //*** 1、保存图片到相册
            [self saveImageToAlbum];
        }
            break;
        case 1:
        {
            //*** 2、截图并保存到相册
            [self cutAndSaveToAlbum];
        }
            break;
        case 2:
        {
            //*** 3、GIF图片转PNG
            [self GIFConversionToPNG];
        }
            break;
        case 3:
        {
            //*** 4、GIF图片展示
            [self showGIFImage];
        }
            break;
        case 4:
        {
            //*** 5、合成GIF图片
            [self compositeGIFImage];
        }
            break;
        case 5:
        {
            //*** 6、检测两种加载图片方式消耗内存
            [self testTwoMethodMemory];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark --- 1、保存图片到相册
-(void)saveImageToAlbum{
    UIImage *image = [UIImage imageNamed:@"img.jpeg"];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}


#pragma mark --- 2、截图并保存到相册 iOS9.0之前使用的方法
-(void)cutAndSaveToAlbum{
    
    self.view.backgroundColor = [UIColor redColor];
    
    //判断是否开启相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if ((author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied))
    {
        NSLog(@"没哟开启相册权限");
    }else{
        if (author == ALAuthorizationStatusAuthorized)
        {
            NSLog(@"开启相册权限");
            UIImage *image = [self getNormalImage:self.view];
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
        }
    }
}

//截图方法
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


#pragma mark --- 3、GIF图片转PNG
-(void)GIFConversionToPNG
{
    NSLog(@"%@",NSHomeDirectory());
    //*** 1、拿到gif图片
    NSString *gifPathSource = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"GIF"];
    NSData *data = [NSData dataWithContentsOfFile:gifPathSource];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    //*** 2、一帧帧分解
    size_t count = CGImageSourceGetCount(source);
    //    NSLog(@"%ld",count);
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < count; i++) {
        CGImageRef imageref = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //*** 3、将单帧数据转换成image
        UIImage *image = [UIImage imageWithCGImage:imageref scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        [tmpArray addObject:image];
        CGImageRelease(imageref);
    }
    CFRelease(source);
    
    //*** 4、单帧保存图片
    int i = 1;
    for (UIImage *image in tmpArray) {
        NSData *data = UIImagePNGRepresentation(image);
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *gifPath = path[0];
        NSString *pathNum = [gifPath stringByAppendingString:[NSString stringWithFormat:@"/%d.png",i]];
        i++;
        [data writeToFile:pathNum atomically:NO];
    }
}

#pragma mark --- 4、GIF图片展示
-(void)showGIFImage{
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    NSMutableArray *temArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 26; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        [temArray addObject:image ];
    }
    
    //设置动画
    [imageView setAnimationImages:temArray];
    //    [imageView setAnimationRepeatCount:10];
    [imageView setAnimationDuration:3];
    [imageView startAnimating];
}


#pragma mark --- 5、合成GIF图片
-(void)compositeGIFImage{
    NSLog(@"%@",NSHomeDirectory());
    
    //*** 1、获取图片
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 1; i < 26; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        [images addObject:image];
    }
    
    //*** 2、创建gif文件
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentStr = [document objectAtIndex:0];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *textDic = [documentStr stringByAppendingString:@"/gif"];
    [filemanager createDirectoryAtPath:textDic withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *path = [textDic stringByAppendingString:@"/test1.gif"];
    NSLog(@"path =  %@",path);
    
    
    //*** 3、配置gif属性
    CGImageDestinationRef destion;
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, false);
    destion = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, NULL);
    NSDictionary *frameDic = [NSDictionary dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.3],(NSString *)kCGImagePropertyGIFDelayTime, nil] forKey:(NSString *)kCGImagePropertyGIFDelayTime];
    NSMutableDictionary *gifParmdict = [NSMutableDictionary dictionaryWithCapacity:2];
    [gifParmdict setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCGImagePropertyGIFHasGlobalColorMap];
    [gifParmdict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    [gifParmdict setObject:[NSNumber numberWithInt:8] forKey:(NSString *)kCGImagePropertyDepth];
    [gifParmdict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    
    NSDictionary *gifProperty = [NSDictionary dictionaryWithObject:gifParmdict forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //*** 4、合成GIF
    for (UIImage *dimage in images) {
        CGImageDestinationAddImage(destion, dimage.CGImage, (__bridge CFDictionaryRef)frameDic);
    }
    CGImageDestinationSetProperties(destion, (__bridge CFDictionaryRef)gifProperty);
    CGImageDestinationFinalize(destion);
    CFRelease(destion);
    
    
}


#pragma mark --- 6、检测两种加载图片方式消耗内存
-(void)testTwoMethodMemory{
    NSLog(@"%@",NSHomeDirectory());
    //*********  内存消耗好奇怪 ************
    float imgWidth  = [UIScreen mainScreen].bounds.size.width/4;
    float imgHeight = [UIScreen mainScreen].bounds.size.height/4;
    for (int i = 1; i < 20; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((i%5-1)*imgWidth, (i/5)*imgHeight, imgWidth, imgHeight)];
        //*** 用imageNamed方式加载20张图片，内存消耗34.9M；
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+3]];
        
        //*** 用contentOfFile加载20张图，内存消耗37.2M左右；
        //        NSString *imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i+3] ofType:@"png"];
        //        imgView.image = [UIImage imageWithContentsOfFile:imgPath];
        [self.view addSubview:imgView];
    }
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
