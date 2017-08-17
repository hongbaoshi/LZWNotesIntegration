//
//  CDUIKit.h
//  WYFX_Demo
//
//  Created by 顾泠轩 on 16/12/20.
//  Copyright © 2016年 ChenDan. All rights reserved.
//

//使用此类，在工程pch文件里面加入该头文件，即可在工程内任意地方进行创建
//此类设计模式为最简单的工厂模式
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CDUIKit : NSObject

//#pragma mark --判断设备型号
//+(NSString *)platformString;
#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;
//适配器的方法  扩展性方法
//现有方法，已经在工程里面存在，如果修改工程内所有方法，工作量巨大，就需要使用适配器的方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;
#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;
#pragma mark 创建UISlider
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;
#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
//#pragma mark --判断导航的高度64or44
//+(float)isIOS7;


#pragma mark --------- UILabel --------

/** Label 字色 字号 */
+ (UILabel *)labelTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)size;

/** Label 文字 字号 */
+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)size;

/** Label 字色 行数 文字 字号 */
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size;

/** Label 背景色 字色 对其 行数 文字 字号 */
+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)size;

#pragma mark --------- UIImageView --------

/** ImageView 图片 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image;

/** ImageView 图片 交互 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
             userInteractionEnabled:(BOOL)enabled;

/** ImageView 填充方式 图片 */
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                                    image:(UIImage *)image;

/** ImageView 填充方式 交互 图片 */
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                   userInteractionEnabled:(BOOL)enabled
                                    image:(UIImage *)image;

#pragma mark --------- UIButton --------

/** UIButton 前景图 */
+ (UIButton *)buttonWithImage:(UIImage *)image;

/** UIButton 背景色 标题色 标题 字号 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size;

/** UIButton 背景色 标题色 标题高亮色 标题 字号 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                    titleHighlightColor:(UIColor *)titleHighlightColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size;


#pragma mark --------- TableView --------

+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id)delegate;

+ (void)sj_tableView:(UITableView *)tableView withDelegate:(id)delegate;






#pragma mark 更新于 6.26 主要用于检测内容
+(NSString*)isUrl:(NSString*)str;


#pragma mark 系统菊花
+(UIView*)JUHUA;



@end
