//
//  CircleLHQView.m
//  SliderCircleDemo
//
//  Created by 123456 on 15-7-1.
//  Copyright (c) 2015年 HuaZhengInfo. All rights reserved.
//

#import "CircleLHQView.h"

@implementation CircleLHQView
{
    //****** 初始化方式初始化一下属性
    NSInteger _decelerTime;//*** 1、减速计数
    NSMutableArray *_subViewArray;//*** 2、子试图数组
    UIImageView *_circleView;//*** 3、圆形图：背景图片
    int _mRadius; //*** 4、半径
    double _mStartAngle;//*** 5、转动的角度
    int _mFlingableValue;//*** 6、转动临界速度，超过此速度便是快速滑动，手指离开仍会转动
    BOOL _isPlaying; //*** 7、是否正在转动
    
    
    CGSize _subViewSize;//*** 8、子试图大小
    CGFloat _numOfSubView;//*** 9、子试图数量
    NSMutableArray *_btnArray;//*** 10、保存自视图按钮的数组
    UIPanGestureRecognizer *_pgr; //*** 11、背景视图添加手势
    
    float _mTmpAngle;   //*** 12、检测按下到抬起时旋转的角度
    CGPoint _beginPoint;//*** 13、第一触碰点
    NSDate *_startTouchDate; //*** 14、开始旋转是保存数据 --- 用于计算总时间(开始->结束)
    CGPoint _movePoint;//*** 15、第二触碰点
    
    NSTimer *_timer;//减速定时器
    NSDate * date;//滑动时间

}
-(void)dealloc
{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
}


-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    
    if(self=[super initWithFrame:frame]){
//        self.backgroundColor = [UIColor redColor];
        
        //*** 1、初始化，加背景视图；
        _decelerTime=0;
        _subViewArray=[[NSMutableArray alloc] init];
        _circleView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if(image==nil){
            _circleView.backgroundColor=[UIColor greenColor];
            _circleView.layer.cornerRadius=frame.size.width/2;
            
        }else{
            _circleView.image=image;
            _circleView.backgroundColor=[UIColor clearColor];
        }
        _mRadius =frame.size.width/2;
        _mStartAngle = 0;
        _mFlingableValue = 300;
        _isPlaying = false;
        _circleView.userInteractionEnabled=YES;
        [self addSubview:_circleView];
    }
    return self;
}


#pragma mark --- 1、加子视图
-(void)addSubViewWithSubView:(NSArray *)imageArray andTitle:(NSArray *)titleArray andSize:(CGSize)size andcenterImage:(UIImage *)centerImage
{
    _subViewSize=size;
    if(titleArray.count==0){
        _numOfSubView=(CGFloat)imageArray.count;
    }
    if(imageArray.count==0){
        _numOfSubView=(CGFloat)titleArray.count;
    }
    _btnArray = [[NSMutableArray alloc]init];
    
    //*** 1、旋转按钮
    for(NSInteger i=0; i<_numOfSubView ;i++){
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(20, 20, size.width, size.height)];
        
        if(imageArray==nil){
            button.backgroundColor=[UIColor yellowColor];
            button.layer.cornerRadius=size.width/2;
        }else{
            [button setImage:imageArray[i] forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:1];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag=160+i;
        [button addTarget:self action:@selector(subViewOut:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:button];
        [_subViewArray addObject:button];
        [_circleView addSubview:button];
    }
    
    //*** 2、自视图布局
    [self layoutBtn];
    
    //*** 3、中间视图
    UIButton *buttonCenter=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, self.frame.size.height/3.0)];
    buttonCenter.tag=100+_numOfSubView;
    if(centerImage==nil){
        buttonCenter.layer.cornerRadius=self.frame.size.width/6.0;
        buttonCenter.backgroundColor=[UIColor redColor];
        [buttonCenter setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [buttonCenter setTitle:@"中间" forState:UIControlStateNormal];
        [buttonCenter setTitleColor:[UIColor greenColor] forState:1];
    }else{
        [buttonCenter setImage:centerImage forState:UIControlStateNormal];
    }
    buttonCenter.center= _circleView.center;
    [buttonCenter addTarget:self action:@selector(subViewOut:) forControlEvents:UIControlEventTouchUpInside];
    [_subViewArray addObject:buttonCenter];
    [_circleView addSubview:buttonCenter];
    
    
    //*** 4、加转动手势
    _pgr=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zhuanPgr:)];
    [_circleView addGestureRecognizer:_pgr];
}


#pragma mark --- 2、旋转按钮布局
//按钮布局
-(void)layoutBtn{
    //*** 😄 复习下sin、cos
    /*
        sin 对边比斜边
        cos 邻边比斜边
     */
    for (NSInteger i = 0; i < _numOfSubView ;i++) {
        CGFloat xx = self.frame.size.width/2 + cos((i/_numOfSubView)*M_PI*2+_mStartAngle)*(self.frame.size.width/2-_subViewSize.width/2-20);
        CGFloat yy = self.frame.size.width/2 + sin((i/_numOfSubView)*M_PI*2+_mStartAngle)*(self.frame.size.width/2-_subViewSize.width/2-20);
        UIButton *button = [_btnArray objectAtIndex:i];
        button.center = CGPointMake(xx, yy);
    }
}


NSTimer *flowtime;
float anglePerSecond;
float speed;  //转动速度


#pragma mark --- 3、转动手势
-(void)zhuanPgr:(UIPanGestureRecognizer *)pgr
{
//    UIView *view=pgr.view;
    if(pgr.state == UIGestureRecognizerStateBegan)
    {
        _mTmpAngle = 0;
        _beginPoint = [pgr locationInView:self];
        _startTouchDate = [NSDate date];
    }else if (pgr.state == UIGestureRecognizerStateChanged)
    {
        float StartAngleLast = _mStartAngle;
        _movePoint= [pgr locationInView:self];
        float start = [self getAngle:_beginPoint];   //获得起始弧度
        float end = [self getAngle:_movePoint];     //结束弧度
        if ([self getQuadrant:_movePoint] == 1 || [self getQuadrant:_movePoint] == 4)
        {
            _mStartAngle += end - start;
            _mTmpAngle += end - start;
//            NSLog(@"第一、四象限____%f",_mStartAngle);
        } else
        {
            // 二、三象限，色角度值是付值
            _mStartAngle += start - end;
            _mTmpAngle += start - end;
//            NSLog(@"第二、三象限____%f",_mStartAngle);
//             NSLog(@"_mTmpAngle is %f",_mTmpAngle);
        }
        [self layoutBtn];
        _beginPoint=_movePoint;
        speed = _mStartAngle - StartAngleLast;
//        NSLog(@"speed is %f",speed);
    }else if (pgr.state==UIGestureRecognizerStateEnded)
    {
        // 计算，每秒移动的角度
        NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:_startTouchDate];
        anglePerSecond = _mTmpAngle*50/ time;
//        NSLog(@"anglePerSecond is %f",anglePerSecond);
        // 如果达到该值认为是快速移动
        if (fabs(anglePerSecond) > _mFlingableValue && !_isPlaying)
        {
            // post一个任务，去自动滚动
            _isPlaying = true;
            flowtime = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(flowAction)
                                                      userInfo:nil
                                                       repeats:YES];
        }
    }
}


#pragma mark --- 4、获取当前点弧度
//获取当前点弧度
-(float)getAngle:(CGPoint)point
{
    double x = point.x - _mRadius;
    double y = point.y - _mRadius;
    return (float) (asin(y / hypot(x, y)));
}


#pragma mark --- 5、根据当前位置计算象限
/**
 * 根据当前位置计算象限
 */
-(int) getQuadrant:(CGPoint) point {
    int tmpX = (int) (point.x - _mRadius);
    int tmpY = (int) (point.y - _mRadius);
    if (tmpX >= 0) {
        return tmpY >= 0 ? 1 : 4;
    } else {
        return tmpY >= 0 ? 2 : 3;
    }
}


#pragma mark --- 6、速度过快，自动滑动
-(void)flowAction{
    if (speed < 0.1) {
        _isPlaying = false;
        [flowtime invalidate];
        flowtime = nil;
        return;
    }
    // 不断改变_mStartAngle，让其滚动，/30为了避免滚动太快
    _mStartAngle += speed ;
    speed = speed/1.1;
    // 逐渐减小这个值
//    anglePerSecond /= 1.1;
    [self layoutBtn];
}


#pragma mark --- 7、按钮点击事件
-(void)subViewOut:(UIButton *)button
{
    //点击
    if(self.block){
        self.block([NSString stringWithFormat:@"%ld",(long)button.tag]);
    }
}

@end






















