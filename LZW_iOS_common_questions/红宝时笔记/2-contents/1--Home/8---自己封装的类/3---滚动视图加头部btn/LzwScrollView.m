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

@property(nonatomic,strong)UIScrollView *scrView;
@property(nonatomic,assign)float scrWidth;
@property(nonatomic,assign)float scrHeight;

@property(nonatomic,strong)NSMutableArray *btnArray;   //保存头部按钮数组

@end

@implementation LzwScrollView

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

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
    float width = ([UIScreen mainScreen].bounds.size.width)/_titleArr.count;
    float height = 40.0;
    
    for (int i = 0; i<_titleArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(width), 0, width, height);
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:[_titleArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = _lzwScrTag + i;
        if (i == 0)
        {
            btn.backgroundColor = [UIColor redColor];
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
}


-(void)btnClick:(UIButton *)sender
{
    for (UIButton *btn in self.btnArray)
    {
        if (btn.tag == sender.tag)
        {
            sender.backgroundColor = [UIColor redColor];
        }else
        {
            btn.backgroundColor = [UIColor greenColor];
        }
    }
    _scrView.contentOffset = CGPointMake(_scrWidth*(sender.tag - _lzwScrTag + 1), 0);
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
        Class A = NSClassFromString(_scrVcrArr[i]);
        UIView *view = [[A alloc] initWithFrame:CGRectMake(_scrWidth*i, 0, _scrWidth, _scrHeight)];
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












































































