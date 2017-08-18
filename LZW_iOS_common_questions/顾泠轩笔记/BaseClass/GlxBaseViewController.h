//
//  BaseViewController.h
//  LZW_iOS_common_questions
//
//  Created by 文艺复兴 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlxBaseViewController : UIViewController

-(void)createUI;
-(void)loadData;
//设置title
-(void)setNavTitle:(NSString *)title;
//设置返回按钮
- (void)setupNavBackButton;
//返回
- (void)goBackAction;
//右键响应方法
- (void)rightAction;

@end
