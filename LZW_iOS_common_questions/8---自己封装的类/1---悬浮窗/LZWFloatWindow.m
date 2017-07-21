//
//  LZWFloatWindow.m
//  LZWFloatWindow
//
//  Created by 红宝时 on 2017/3/6.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LZWFloatWindow.h"
#import <CoreMotion/CoreMotion.h>

#define LZW_WIDTH [[UIApplication sharedApplication].windows firstObject].bounds.size.width
#define WZFlashInnerCircleInitialRaius  20

@interface LZWFloatWindow()

@property(nonatomic,assign)CGRect startFrame;//*** 1、悬浮窗初始显示位置
@property(nonatomic,assign)NSInteger btnWidth;//*** 2、详情按钮的宽；
@property(nonatomic,strong)NSDictionary *titleDic;//*** 3、保存详情页面标题的字典；
@property(nonatomic,assign)int btnTag;//*** 4、详情每个按钮初始tag值；
@property(nonatomic,strong)UIColor *animationColor;//*** 5、长按雷达效果颜色
@property(nonatomic,assign)BOOL isShowDetail;//*** 6、是否展开悬浮窗，默认不展开；
@property(nonatomic,assign)BOOL isHide; //*** 7、是否隐藏悬浮窗
@property(nonatomic,strong)UIButton *mainBtn;//*** 8、主按钮
@property(nonatomic,strong)UIView *contentView;//*** 9、点击btn展示的详情界面；


@property(nonatomic,strong)UIPanGestureRecognizer *movePan;//悬浮窗移动手势
@property(nonatomic,strong)CMMotionManager *motionManager;//添加重力感应器
@property(assign, nonatomic) NSTimeInterval gyroUpdateInterval;//
@property(nonatomic,assign)double accZ; //z轴方向的偏移量；

@property(nonatomic,strong)CAAnimationGroup *animationGroup;
@property(nonatomic,strong)CAShapeLayer *circleShape;


@end
@implementation LZWFloatWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andWithMainImageName:(NSString *)bgName andWithTitleDic:(NSDictionary *)titleDic andWithStartBtnTag:(int)startTag andWithAnimationColor:(UIColor *)color;
{
    if (self = [super initWithFrame:frame])
    {
        //*** 1、初始化属性
        _startFrame = frame;
        _btnWidth = frame.size.width;
        _titleDic = titleDic;
        _btnTag = startTag;
        _animationColor = color;
        _isShowDetail = NO;
        _isHide = NO;
        
        //*** 2、悬浮Window设置
        self.backgroundColor = [UIColor clearColor];
        self.rootViewController = [UIViewController new];
        self.rootViewController.view.backgroundColor = [UIColor blackColor];
        self.windowLevel = UIWindowLevelAlert + 1;
        self.alpha = 0.8;
        self.layer.cornerRadius = self.startFrame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:0.94 green:0.61 blue:0.30 alpha:1.00].CGColor;
        self.layer.borderWidth = 1;
        [self makeKeyAndVisible];
        
        //*** 3、主按钮设置
        _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if (bgName)
        {
            [_mainBtn setImage:[UIImage imageNamed:bgName] forState:UIControlStateNormal];
        }else
        {
            _mainBtn.backgroundColor = [UIColor greenColor];
        }
        [_mainBtn addTarget:self action:@selector(mainBtnClick) forControlEvents:UIControlEventTouchUpInside];
        if (_animationColor) {
            //4---添加长按雷达效果；
//            [_mainBtn addTarget:self action:@selector(mainBtnTouchDown) forControlEvents:UIControlEventTouchDown];
        }
        [self.rootViewController.view addSubview:_mainBtn];
        
        
        //*** 5、展示按钮的详情页面
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.frame = CGRectMake(_btnWidth, 0, _titleDic.count*(_btnWidth+5), _btnWidth);
        [self.rootViewController.view addSubview:_contentView];

       //*** 6、给contentView添加按钮
        [self setContentViewBtns];
        
        //*** 7、给Window添加手势
        _movePan = [[UIPanGestureRecognizer alloc] init];
        [_movePan addTarget:self action:@selector(locationChange:)];
        _movePan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:_movePan];
        
        //*** 8、设备旋转的时候收回详情界面
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        
        //*** 9、添加翻转隐藏悬浮窗；
        //开启陀螺仪感应器；
        //重力感应的设置
        [self accelerotionDataMethod];
        
    }
    return self;
}

#pragma mark --- 1、点击悬浮窗主按钮
-(void)mainBtnClick
{
    _isShowDetail = !_isShowDetail;
    
    if (self.center.x == -5)
    {
        _mainBtn.frame = CGRectMake(0, 0, 50, 50);
        [_mainBtn setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _btnWidth+(5+_btnWidth)*_titleDic.count, _btnWidth);
            self.center = CGPointMake((_btnWidth+(5+_btnWidth)*_titleDic.count)/2, self.center.y);
        }];
        return;
    }else if (self.center.x == LZW_WIDTH+5)
    {
        _mainBtn.frame = CGRectMake(0, 0, 50, 50);
        [_mainBtn setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _btnWidth+(5+_btnWidth)*_titleDic.count, _btnWidth);
            self.center = CGPointMake(LZW_WIDTH-(_btnWidth+(5+_btnWidth)*_titleDic.count)/2, self.center.y);
        }];
        return;
    }
    
    
    if (_isShowDetail)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _btnWidth+(5+_btnWidth)*_titleDic.count, _btnWidth);
        }];
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _btnWidth, _btnWidth);
        }];
    }
    
}

#pragma mark --- 2、给contentView添加按钮
-(void)setContentViewBtns
{
    int i = 0;
    for (NSString *key in _titleDic)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_btnWidth, 0, _btnWidth, _btnWidth);
        [btn setTitle:_titleDic[key] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:key] forState:UIControlStateNormal];
        btn.tag = _btnTag;
        // 则默认image在左，title在右
        // 改成image在上，title在下
        btn.titleEdgeInsets = UIEdgeInsetsMake(self.btnWidth/2 , -[UIImage imageNamed:key].size.width, 0.0, 0.0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(2.0, 8.0, 16.0, -
                                                  btn.titleLabel.bounds.size.width + 8);
        btn.titleLabel.font = [UIFont systemFontOfSize: self.btnWidth/5];
        [btn addTarget:self action:@selector(itemsClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
        i++;
        _btnTag++;
    }
}


#pragma mark --- 3、添加手势
-(void)locationChange:(UIPanGestureRecognizer *)p
{
    //获取停止的位置坐标
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication].windows firstObject]];
    if(p.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if (p.state == UIGestureRecognizerStateEnded)
    {
        //平移点的速度以指定视图的坐标系中的点/秒为单位 velocity
        CGPoint velocity = [p velocityInView:[[UIApplication sharedApplication].windows firstObject]];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 300;
        float slideFactor = 0.1 * slideMult;
//        NSLog(@"%f  %f  %f  %f  %f",panPoint.x,panPoint.y,velocity.x,velocity.y,slideMult);
        CGPoint finalPoint = CGPointMake(p.view.center.x + (velocity.x * slideFactor),
                                         p.view.center.y + (velocity.y * slideFactor));
        
        if (!_isShowDetail)
        {
            //限制下最小、最大坐标，防止停靠在角落；
            finalPoint.x = MIN(MAX(finalPoint.x, 25), [[UIApplication sharedApplication].windows firstObject].bounds.size.width-25);
            finalPoint.y = MIN(MAX(finalPoint.y, 70), [[UIApplication sharedApplication].windows firstObject].bounds.size.height-70);
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                p.view.center = finalPoint;
                if (self.center.x == 25)
                {
                    [self performSelector:@selector(yinCanLeftFloat) withObject:nil afterDelay:0.3];
                    
                    
                }else if(self.center.x == [[UIApplication sharedApplication].windows firstObject].bounds.size.width-25)
                {
                    [self performSelector:@selector(yinCanRightFloat) withObject:nil afterDelay:0.3];
                }
                
            } completion:nil];
        }else
        {
            //限制下最小、最大坐标，防止停靠在角落；
            finalPoint.x = MIN(MAX(finalPoint.x, (_btnWidth+(5+_btnWidth)*_titleDic.count)/2), [[UIApplication sharedApplication].windows firstObject].bounds.size.width-(_btnWidth+(5+_btnWidth)*_titleDic.count)/2);
            finalPoint.y = MIN(MAX(finalPoint.y, 70), [[UIApplication sharedApplication].windows firstObject].bounds.size.height-70);
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                p.view.center = finalPoint;
            } completion:nil];
        }
    }
    else if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
        
        if (self.center.x >25)
        {
            _mainBtn.userInteractionEnabled = YES;
            _mainBtn.frame = CGRectMake(0, 0, 50, 50);
            [_mainBtn setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
            
        }else if(self.center.x < [[UIApplication sharedApplication].windows firstObject].bounds.size.width-25)
        {
            _mainBtn.userInteractionEnabled = YES;
            _mainBtn.frame = CGRectMake(0, 0, 50, 50);
            [_mainBtn setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
        }
    }
}

-(void)yinCanLeftFloat
{
    [UIView animateWithDuration:0.6 animations:^{
        self.center = CGPointMake(-50, self.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.center = CGPointMake(-5, self.center.y);
            _mainBtn.frame = CGRectMake(30, 0, 20, 50);
            [_mainBtn setImage:[UIImage imageNamed:@"left_float.png"] forState:UIControlStateNormal];
        }];
    }];
}

-(void)yinCanRightFloat
{
    [UIView animateWithDuration:0.6 animations:^{
        self.center = CGPointMake([[UIApplication sharedApplication].windows firstObject].bounds.size.width+50, self.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.center = CGPointMake([[UIApplication sharedApplication].windows firstObject].bounds.size.width+5, self.center.y);
            _mainBtn.frame = CGRectMake(0, 0, 20, 50);
            [_mainBtn setImage:[UIImage imageNamed:@"right_float.png"] forState:UIControlStateNormal];
        }];
    }];
}


#pragma mark --- 4、设备旋转的时候收回详情界面
-(void)orientChange:(NSNotification *)notification
{
    self.frame = CGRectMake(self.startFrame.origin.x, self.startFrame.origin.y, _btnWidth, _btnWidth);
}


#pragma mark --- 5、添加翻转隐藏悬浮窗；
-(void)accelerotionDataMethod
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.gyroUpdateInterval = 0.2;
    self.motionManager.accelerometerUpdateInterval = self.gyroUpdateInterval;
    __weak LZWFloatWindow *weakself = self;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [weakself outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    [self.motionManager startGyroUpdates];
}

#pragma mark --- 6、翻转隐藏悬浮窗
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    self.accZ = acceleration.z;
    
    if (self.accZ >= 0.2)
    {
        [self.motionManager stopAccelerometerUpdates];
        
        _isHide = !_isHide;
        self.hidden = _isHide;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            [self accelerotionDataMethod];
        });
    }
    
}


#pragma mark --- 7、长按主按钮动画波浪效果
- (void)mainBtnTouchDown{
    if (!_isShowDetail) {
        [self performSelector:@selector(buttonAnimation) withObject:nil afterDelay:0.7];
    }
}

- (void)buttonAnimation{
    
//    self.layer.masksToBounds = NO;
    
    CGFloat scale = 1.0f;
    
    CGFloat width = self.mainBtn.bounds.size.width, height = self.mainBtn.bounds.size.height;
    
    CGFloat biggerEdge = width > height ? width : height, smallerEdge = width > height ? height : width;
    CGFloat radius = smallerEdge / 2 > WZFlashInnerCircleInitialRaius ? WZFlashInnerCircleInitialRaius : smallerEdge / 2;
    
    scale = biggerEdge / radius + 0.5;
    _circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2)
                                              pathRect:CGRectMake(0, 0, radius * 2, radius * 2)
                                                radius:radius];
    
    // 圆圈放大效果
    //        scale = 2.5f;
    //        _circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2)
    //                                                 pathRect:CGRectMake(-CGRectGetMidX(self.mainImageButton.bounds), -CGRectGetMidY(self.mainImageButton.bounds), width, height)
    //                                                   radius:self.mainImageButton.layer.cornerRadius];
    
    
    [self.mainBtn.layer addSublayer:_circleShape];
    
    CAAnimationGroup *groupAnimation = [self createFlashAnimationWithScale:scale duration:1.0f];
    
    [_circleShape addAnimation:groupAnimation forKey:nil];
}

- (void)stopAnimation{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonAnimation) object:nil];
    
    if (_circleShape) {
        [_circleShape removeFromSuperlayer];
    }
}

- (CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius
{
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = [self createCirclePathWithRadius:rect radius:radius];
    circleShape.position = position;
    
    
    circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    circleShape.fillColor = _animationColor.CGColor;
    
    //  圆圈放大效果
    //  circleShape.fillColor = [UIColor clearColor].CGColor;
    //  circleShape.strokeColor = [UIColor purpleColor].CGColor;
    
    circleShape.opacity = 0;
    circleShape.lineWidth = 1;
    
    return circleShape;
}

- (CAAnimationGroup *)createFlashAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    _animationGroup = [CAAnimationGroup animation];
    _animationGroup.animations = @[scaleAnimation, alphaAnimation];
    _animationGroup.duration = duration;
    _animationGroup.repeatCount = INFINITY;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return _animationGroup;
}


- (CGPathRef)createCirclePathWithRadius:(CGRect)frame radius:(CGFloat)radius
{
    return [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
}



#pragma mark --- 7、回调方法
-(void)itemsClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.backBlock(btn.tag);
}



@end














































