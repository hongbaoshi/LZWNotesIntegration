//
//  LZWFloatWindow.h
//  LZWFloatWindow
//
//  Created by 红宝时 on 2017/3/6.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSInteger tag);

@interface LZWFloatWindow : UIWindow

@property(nonatomic,strong)MyBlock backBlock;

-(id)initWithFrame:(CGRect)frame andWithMainImageName:(NSString *)bgName andWithTitleDic:(NSDictionary *)titleDic andWithStartBtnTag:(int)startTag andWithAnimationColor:(UIColor *)color;

@end
