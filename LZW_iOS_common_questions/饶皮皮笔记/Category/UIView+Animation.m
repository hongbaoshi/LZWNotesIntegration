//
//  UIView+Animation.m
//  TTReadBook
//
//  Created by fengjie on 2017/7/24.
//  Copyright © 2017年 湖北三新文化传媒有限公司. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
- (void)setAnimationWithType:(AnimationType)animation
                    duration:(float)durationTime
            directionSubtype:(Direction)subtype
{
    //CATransition实体
    CATransition* ani=[CATransition animation];
    //动画时间:
    ani.duration = durationTime;
    //选择动画过渡方向:
    switch (subtype) {
        case SXleft:
            ani.subtype = kCATransitionFromLeft;
            break;
        case SXright:
            ani.subtype = kCATransitionFromRight;
            break;
        case SXtop:
            ani.subtype = kCATransitionFromTop;
            break;
        case SXbottom:
            ani.subtype = kCATransitionFromBottom;
            break;
        case SXmiddle:
            ani.subtype = kCATruncationMiddle;
            break;
        default:
            break;
    }
    //选择动画效果：
    switch (animation)
    {
        case SXpageCurl:
        {
            ani.type = @"pageCurl";
        }
            break;
        case SXpageUnCurl:
        {
            ani.type = @"pageUnCurl";
        }
            break;
        case SXrippleEffect:
        {
            ani.type = @"rippleEffect";
        }
            break;
        case SXsuckEffect:
        {
            ani.type = @"suckEffect";
        }
            break;
        case SXcube:
        {
            ani.type = @"cube";
        }
            break;
        case SXcameraIrisHollowOpen:
        {
            ani.type = @"cameraIrisHollowOpen";
        }
            break;
        case SXoglFlip:
        {
            ani.type = @"oglFlip";
        }
            break;
        case SXcameraIrisHollowClose:
        {
            ani.type = @"cameraIrisHollowClose";
        }
            break;
        case SXmovein:
            ani.type = kCATransitionMoveIn;
            break;
        case SXpush:
            ani.type = kCATransitionPush;
            break;
        case SXfade:
            ani.type = kCATransitionFade;
            break;
        default:
            break;
    }
    //动画加到图层上
    [self.layer addAnimation:ani forKey:nil];
}

@end
