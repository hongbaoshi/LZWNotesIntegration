//
//  PPUtils.m
//  LZW_iOS_common_questions
//
//  Created by 饶思学 on 2017/8/17.
//  Copyright © 2017年 红宝时. All rights reserved.
//



#import "PPUtils.h"


@implementation PPUtils

+(void)alertTitle:(nullable NSString *)title Message:(nullable NSString *)message exitActionTitle:(nullable NSString *)exitTitle exitTitleColor:(UIColor *_Nullable)leftColor cancelActionTitle:(nullable NSString *)cancelTitle cancelTitleColor:(UIColor *_Nullable)rightColor isCancelAction:(BOOL)isCance preferredStyle:(UIAlertControllerStyle)preferredStyle viewController:(nullable UIViewController *)viewController Success:(void (^_Nullable)())sBlock WithFaild:(void (^_Nullable)())fBlock{
    PPAlertController * alerConter =[PPAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    alerConter.tintColor=[UIColor blackColor];
    alerConter.titleColor=[UIColor blackColor];
    PPAlertAction *exit =[PPAlertAction actionWithTitle:exitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sBlock();
    }];
    PPAlertAction *cancel =[PPAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        fBlock();
    }];
    if (isCance) {
        [alerConter addAction:cancel];
    }
    [alerConter addAction:exit];
    
    cancel.textColor=leftColor;
    exit.textColor=rightColor;
    [viewController.navigationController presentViewController:alerConter animated:YES completion:nil];
}


@end
