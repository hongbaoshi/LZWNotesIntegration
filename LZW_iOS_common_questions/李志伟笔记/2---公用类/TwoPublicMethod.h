//
//  TwoPublicMethod.h
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/6/30.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LZWSingleton.h"

@interface TwoPublicMethod : NSObject


//*** 1、获取bundle文件
+ (NSBundle *)getResourceBundleWithName:(NSString *)bundleName;

//*** 2、获取bunle文件里面的图片
+ (UIImage *)getImageFromBundle:(NSBundle *)bundle withName:(NSString *)name withType:(NSString *)type;

//*** 3、将字符串转换成md5
+ (NSString *)md5:(NSString *)input;

//*** 4、字典转成字符串
+ (NSString *)buildQueryString:(id)dict sortArray:(NSArray *)sortArray needUrlEncode:(BOOL)isEncode;


//*** 5、获取主视图的根视图控制器
+(UIViewController *)getKeyWindowRootVcr;

//*** 6、判断是否是手机号码
+(BOOL)isValidateTel:(NSString *)tel;


+ (NSString *)encodeString:(NSString*)unencodedString;

+ (NSString *)decodeString:(NSString*)encodedString;


@end
