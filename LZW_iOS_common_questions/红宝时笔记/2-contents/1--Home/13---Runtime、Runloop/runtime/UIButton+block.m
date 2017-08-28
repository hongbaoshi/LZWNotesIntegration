//
//  UIButton+block.m
//  1234567
//
//  Created by 红宝时 on 2017/8/25.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "UIButton+block.h"

static const void *ButtonKey = &ButtonKey;

@implementation UIButton (block)

-(void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(TapBlock)tapBlock
{
    //*** 运行时绑定传参
    objc_setAssociatedObject(self, ButtonKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:controlEvent];
}

-(void)btnClick:(UIButton *)sender
{
    //*** 运行时获取绑定的参数
    TapBlock tapBlock = objc_getAssociatedObject(sender, ButtonKey);
    if (tapBlock)
    {
        tapBlock(sender);
    }
}



@end





































