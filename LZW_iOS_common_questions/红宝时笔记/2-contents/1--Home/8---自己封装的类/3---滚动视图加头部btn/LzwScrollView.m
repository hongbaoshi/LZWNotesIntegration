//
//  LzwScrollView.m
//  LzwScrollViewTest
//
//  Created by 红宝时 on 2017/5/5.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "LzwScrollView.h"


@interface LzwScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *scrVcrArr;
@property(nonatomic,assign)NSInteger lzwScrTag;
@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIScrollView *scrView;
@property(nonatomic,assign)float scrWidth;
@property(nonatomic,assign)float scrHeight;

@end

@implementation LzwScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


#pragma mark --- 1、初始化
-(id)initWithFrame:(CGRect)frame andWithBtnTitleArray:(NSArray *)titleArr andWithScrollViewControlerArray:(NSArray *)scrVcrArr withTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //1、属性保存标题数组、页面数组
        _titleArr = [titleArr mutableCopy];
        _scrVcrArr = [scrVcrArr mutableCopy];
        _lzwScrTag = tag;
        
        //2、创建button
        [self creatButton];
        
        //3、加载页面
        [self loadScrView];
    }
    return self;
}


#pragma mark --- 2、创建button
-(void)creatButton
{
    float width = ([UIScreen mainScreen].bounds.size.width - 5*(_titleArr.count+1))/_titleArr.count;
    float height = 40.0;
    
    for (int i = 0; i<_titleArr.count; i++)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(5+i*(width+5), 0, width, height);
        _btn.backgroundColor = [UIColor greenColor];
        [_btn setTitle:[_titleArr objectAtIndex:i] forState:UIControlStateNormal];
        _btn.tag = _lzwScrTag + i;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
    }
}


-(void)btnClick:(UIButton *)btn
{
    _scrView.contentOffset = CGPointMake(_scrWidth*(btn.tag - _lzwScrTag + 1), 0);
}


#pragma mark --- 3、加载页面
-(void)loadScrView
{
    [_scrVcrArr insertObject:[_scrVcrArr lastObject] atIndex:0];
    _scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-40)];
    _scrWidth = _scrView.bounds.size.width;
    _scrHeight = _scrView.bounds.size.height;
    _scrView.showsHorizontalScrollIndicator = NO;
    _scrView.showsVerticalScrollIndicator = NO;
    _scrView.contentSize = CGSizeMake(_scrWidth*_scrVcrArr.count, _scrHeight);
    _scrView.pagingEnabled = YES;
    _scrView.bounces = YES;
    _scrView.delegate = self;
    _scrView.contentOffset = CGPointMake(_scrWidth, 0);
    [self addSubview:_scrView];
    
    for (int i = 0; i < _scrVcrArr.count; i++)
    {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_scrWidth*i, 0, _scrWidth, _scrHeight)];
        if (i == 0)
        {
            view.backgroundColor = [UIColor yellowColor];
        }
        else if (i == 1)
        {
            view.backgroundColor = [UIColor redColor];
        }
        else if (i == 2)
        {
            view.backgroundColor = [UIColor greenColor];
        }
        else if (i == 3)
        {
            view.backgroundColor = [UIColor blueColor];
        }else if(i == 4)
        {
            view.backgroundColor = [UIColor yellowColor];
        }
        [_scrView addSubview:view];
    }
    
}



#pragma mark -- 4、UIScrollViewDelegate代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0)
    {
        scrollView.contentOffset = CGPointMake(_scrWidth*(_scrVcrArr.count - 1), 0);
    }
    if (scrollView.contentOffset.x > _scrWidth*(_scrVcrArr.count - 1))
    {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    int tag = scrollView.bounds.origin.x/_scrWidth - 1;
//    UIButton *btn = (UIButton *)[self viewWithTag:tag];
//    btn.backgroundColor = [UIColor redColor];

}

@end












































































