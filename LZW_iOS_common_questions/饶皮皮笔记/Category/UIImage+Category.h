//
//  UIImage+Category.h
//  TTReadBook
//
//  Created by fengjie on 2017/7/31.
//  Copyright © 2017年 湖北三新文化传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/*根据颜色绘制一张图片*/
+(nullable instancetype)createImageWithColor:(nullable UIColor *)color;
@end
