//
//  UITabBarController+HideTabBar.m
//  NPS
//
//  Created by Carlos Oliva on 04-02-12.
//  Copyright (c) 2012 iDev. All rights reserved.
//

#import "UITabBarController+HideTabBar.h"

#define kAnimationDuration .3


@implementation UITabBarController (HideTabBar)

- (BOOL)isTabBarHidden {
	CGRect viewFrame = self.view.frame;
	CGRect tabBarFrame = self.tabBar.frame;
	return tabBarFrame.origin.y >= viewFrame.size.height;
}

- (void) setTabBarHidden:(BOOL)hidden{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ){
        fHeight = screenRect.size.width;
    }
    
    if(!hidden) fHeight -= self.tabBar.frame.size.height;
    
    //NSLog(@"fHeight ___ ___ %f",fHeight);
    
    [UIView animateWithDuration:0.01 animations:^{
        for(UIView *view in self.view.subviews){
            if([view isKindOfClass:[UITabBar class]]){
                [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
                
            }else{
                if(hidden) [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            }
        }
    }completion:^(BOOL finished){
        if(!hidden){
            
            [UIView animateWithDuration:0.01 animations:^{
                
                for(UIView *view in self.view.subviews)
                {
                    if(![view isKindOfClass:[UITabBar class]])
                        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
                }
                
            }];
        }
        
       // NSLog(@"viewframe ___ ___ %f",);
    }];
    
}

/*- (void)setTabBarHidden:(BOOL)hidden {
	[self setTabBarHidden:hidden animated:NO];
}


- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
	BOOL isHidden = self.tabBarHidden;
	if(hidden == isHidden)
		return;
	UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
	if(transitionView == nil) {
		//NSLog(@"could not get the container view!");
		return;
	}
	CGRect viewFrame = self.view.frame;
	CGRect tabBarFrame = self.tabBar.frame;
	CGRect containerFrame = transitionView.frame;
	tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
	containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration
                         animations:^{
                             self.tabBar.frame = tabBarFrame;
                             transitionView.frame = containerFrame;
                         }
         ];
    }else{
        self.tabBar.frame = tabBarFrame;
        transitionView.frame = containerFrame;
    }

}*/


@end
