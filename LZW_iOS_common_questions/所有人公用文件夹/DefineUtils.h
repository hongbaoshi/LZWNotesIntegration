//
//  DefineUtils.h
//  LZW_iOS_common_questions
//
//  Created by 文艺复兴 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#ifndef DefineUtils_h
#define DefineUtils_h


#endif /* DefineUtils_h */

//获取系统对象

#define kApplication [UIApplication sharedApplication]

#define kAppWindow [UIApplication sharedApplication].delegate.window

#define kAppDelegate [AppDelegate shareAppDelegate]

#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

//property属性快速声明
#define PropertyString(s)@property(nonatomic,copy)NSString * s

#define PropertyNSInteger(s)@property(nonatomic,assign)NSIntegers

#define PropertyFloat(s)@property(nonatomic,assign)floats

#define PropertyLongLong(s)@property(nonatomic,assign)long long s

#define PropertyNSDictionary(s)@property(nonatomic,strong)NSDictionary * s

#define PropertyNSArray(s)@property(nonatomic,strong)NSArray * s

#define PropertyNSMutableArray(s)@property(nonatomic,strong)NSMutableArray * s

//拼接字符串
#define NSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

//强引用，弱引用
#define Weak(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define Strong(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

//弱引用 weakself
#define WeakSelf __weak typeof(self) weakSelf = self;
//强引用
#define StrongSelf __strong typeof(self) strongSelf = weakSelf;

//屏幕宽高
#define SCW [[UIScreen mainScreen] bounds].size.width
#define SCH [[UIScreen mainScreen] bounds].size.height

// View 坐标(x,y)和宽高(width,height)
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// clear背景颜色
#define CColor [UIColor clearColor]

/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//GCD - 一次性执行
#define CCDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define CCDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define CCDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

//GCD - 延时线程
#define CCDISPATCH_AFTER_QUEUE(time,afterQueueBlock)     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), afterQueueBlock);

//系统版本判断
#define iOS9_LATER (([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0) ? YES : NO)
#define iOS8_LATER (([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0) ? YES : NO)
#define iOS7_LATER (([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) ? YES : NO)
#define iOS6_LATER (([[[UIDevice currentDevice]systemVersion] floatValue] >= 6.0) ? YES : NO)

//判断iphone4/4s
#define iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone5/5s
#define iPhone5_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
























