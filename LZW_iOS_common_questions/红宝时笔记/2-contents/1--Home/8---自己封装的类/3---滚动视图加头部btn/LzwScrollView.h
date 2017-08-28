//
//  LzwScrollView.h
//  LzwScrollViewTest
//
//  Created by 红宝时 on 2017/5/5.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LzwScrollView : UIView

/**
 *  1、frame     滚动视图坐标
 *  2、titleArr  按钮标题
 *  3、scrVcrArr 要创建的视图名称
 *  4、tag       按钮初始tag值
 */

-(id)initWithFrame:(CGRect)frame andWithBtnTitleArray:(NSArray *)titleArr andWithScrollViewControlerArray:(NSArray *)scrVcrArr withTag:(NSInteger)tag;


@end
