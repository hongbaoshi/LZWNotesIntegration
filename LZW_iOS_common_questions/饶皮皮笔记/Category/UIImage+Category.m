//
//  UIImage+Category.m
//  TTReadBook
//
//  Created by fengjie on 2017/7/31.
//  Copyright © 2017年 湖北三新文化传媒有限公司. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+(instancetype)createImageWithColor:(nullable UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
