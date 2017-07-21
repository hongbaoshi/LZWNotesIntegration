//
//  LZWHeaderScrollView.m
//  LZWPackageClass
//
//  Created by 红宝时 on 2016/11/11.
//
//

#import "LZWHeaderScrollView.h"

@interface LZWHeaderScrollView()<UIScrollViewDelegate>

//传入的属性保存
@property(nonatomic,assign)float scrWidth;
@property(nonatomic,assign)float scrHeight;
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,assign)NSInteger startTag;
@property(nonatomic,assign)NSTimeInterval interval;

//界面属性
@property(nonatomic,strong)UIScrollView *LZWScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,assign)int LZWTimerNumber;
//注意＊＊这里不需要✳️号 可以理解为dispatch_time_t 已经包含了
@property (nonatomic, strong)dispatch_source_t time;

@end


@implementation LZWHeaderScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame andWithImgArray:(NSArray *)imgArray andWithScrTime:(NSTimeInterval)interval andWithStartTag:(NSInteger)startTag;
{
    
    if (self = [super initWithFrame:frame])
    {
        _scrWidth = frame.size.width;
        _scrHeight = frame.size.height;
        _imgArr = imgArray;
        _startTag = startTag;
        _interval = interval;
        //创建滚动视图的界面
        [self creatUI];

        
    }
    return self;
}


#pragma mark --- 1、创建UI界面
-(void)creatUI
{
    
    //*** 1、添加图片
    NSMutableArray *imgArray = [_imgArr mutableCopy];
    [imgArray insertObject:[imgArray lastObject] atIndex:0];
    _LZWScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _scrWidth, _scrHeight)];
    _LZWScrollView.showsHorizontalScrollIndicator = NO;
    _LZWScrollView.showsVerticalScrollIndicator = NO;
    _LZWScrollView.contentSize = CGSizeMake(_scrWidth*imgArray.count, _scrHeight);
    _LZWScrollView.pagingEnabled = YES;
    _LZWScrollView.bounces = YES;
    _LZWScrollView.delegate = self;
    _LZWScrollView.contentOffset = CGPointMake(_scrWidth, 0);
    [self addSubview:_LZWScrollView];
    
    for (int i =0; i<imgArray.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrWidth*i, 0, _scrWidth, _scrHeight)];
        imgView.userInteractionEnabled = YES;
        imgView.tag = _startTag +i -1;
        imgView.image = [UIImage imageNamed:imgArray[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        //创建图片单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewBtn:)];
        tap.numberOfTapsRequired =1;
        [imgView addGestureRecognizer:tap];
        
        [_LZWScrollView addSubview:imgView];
    }
    
    
    //*** 2、添加原点
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, _scrHeight-10, _scrWidth-200, 6)];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = _imgArr.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    //*** 3、用gcd创建计时器
    [self creatTimerByGcd];
}


-(void)imgViewBtn:(UITapGestureRecognizer *)tap
{
    self.block(tap.view.tag);
}

-(void)creatTimerByGcd
{
    __weak LZWHeaderScrollView *weakself = self;
    _LZWTimerNumber = 0;
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(_interval* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(self.time, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(self.time, ^{
        
        //回到主线程，执行定时任务
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself scrollHeaderImage];
        });
        //设置当执行五次是取消定时器
        
        //        if(count == 5){
        //
        //            dispatch_cancel(self.time);
        //
        //        }
    });
    //由于定时器默认是暂停的所以我们启动一下
    //启动定时器
    dispatch_resume(self.time);
}

-(void)scrollHeaderImage
{
    _LZWTimerNumber++;
    if (_LZWTimerNumber == _imgArr.count+1) {
        _LZWTimerNumber = 1;
    }
    
    _LZWScrollView.contentOffset = CGPointMake(_LZWTimerNumber*_scrWidth, 0);
    _pageControl.currentPage = _LZWTimerNumber -1;

}



#pragma mark ---- 2、UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x<0) {
        scrollView.contentOffset = CGPointMake(_scrWidth*_imgArr.count, 0);
    }
    if (scrollView.contentOffset.x>_scrWidth*_imgArr.count) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.bounds.origin.x/_scrWidth - 1;
    _pageControl.currentPage = currentPage;
    _LZWTimerNumber = currentPage + 1;
}



@end



















