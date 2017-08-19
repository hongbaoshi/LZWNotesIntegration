//
//  PPUtils.h
//  LZW_iOS_common_questions
//
//  Created by 饶思学 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPUtils : NSObject
/**
 alert弹框
 
 @param title 标题
 @param message 显示的内容
 @param exitTitle 左边按钮名称
 @param leftColor 左边按钮颜色

 @param cancelTitle 右边按钮名称
 @param rightColor 右边按钮颜色

 @param isCance 是否显示右边按钮
 @param preferredStyle 弹框类型
 @param viewController 当前所在的控制器
 @param sBlock 确定按钮点击回调
 @param fBlock 取消按钮点击回调
 */
+(void)alertTitle:(nullable NSString *)title Message:(nullable NSString *)message exitActionTitle:(nullable NSString *)exitTitle exitTitleColor:(UIColor *_Nullable)leftColor cancelActionTitle:(nullable NSString *)cancelTitle cancelTitleColor:(UIColor *_Nullable)rightColor isCancelAction:(BOOL)isCance preferredStyle:(UIAlertControllerStyle)preferredStyle viewController:(nullable UIViewController *)viewController Success:(void (^_Nullable)())sBlock WithFaild:(void (^_Nullable)())fBlock;

@end
