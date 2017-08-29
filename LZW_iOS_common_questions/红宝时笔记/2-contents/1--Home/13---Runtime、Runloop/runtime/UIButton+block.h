//
//  UIButton+block.h
//  1234567
//
//  Created by 红宝时 on 2017/8/25.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

typedef void(^TapBlock)(UIButton *sender);

@interface UIButton (block)

-(void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(TapBlock)tapBlock;

@end
