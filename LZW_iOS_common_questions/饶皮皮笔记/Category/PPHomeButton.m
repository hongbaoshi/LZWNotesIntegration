//
//  TTHomeButton.m
//  YunTianZhiHui
//
//  Created by fengjie on 2017/2/23.
//  Copyright © 2017年 湖北三新文化传媒有限公司. All rights reserved.
//

#import "PPHomeButton.h"

@implementation PPHomeButton


- (void)setup
{
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}
- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

//重写父类方法,改变标题和image的坐标
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
  
  CGFloat superWidth =CGRectGetWidth(contentRect);
  CGFloat imageWith =30*Widths;
  CGRect rect = CGRectMake((superWidth-imageWith)/2, 23, imageWith, imageWith);
  
  return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
  
  CGFloat imageHeight =30*Widths;//23
  CGRect rect = CGRectMake(0, imageHeight+23, CGRectGetWidth(contentRect) , CGRectGetHeight(contentRect) -imageHeight-23 );
  
  return rect;
}


@end
