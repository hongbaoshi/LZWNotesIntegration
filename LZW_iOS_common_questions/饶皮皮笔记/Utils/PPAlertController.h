//
//  TTAlertController.h
//  TTReadBook
//
//  Created by fengjie on 2017/8/1.
//  Copyright © 2017年 湖北三新文化传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPAlertAction : UIAlertAction

@property (nonatomic,strong) UIColor *textColor; /**< 按钮title字体颜色 */

@end


@interface PPAlertController : UIAlertController

@property (nonatomic,strong) UIColor *tintColor; /**< 统一按钮样式 不写系统默认的蓝色 */
@property (nonatomic,strong) UIColor *titleColor; /**< 标题的颜色 */
@property (nonatomic,strong) UIColor *messageColor; /**< 信息的颜色 */

@end
