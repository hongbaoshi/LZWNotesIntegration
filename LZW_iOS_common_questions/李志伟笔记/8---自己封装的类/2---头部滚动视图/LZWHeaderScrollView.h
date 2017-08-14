//
//  LZWHeaderScrollView.h
//  LZWPackageClass
//
//  Created by 红宝时 on 2016/11/11.
//
//

#import <UIKit/UIKit.h>

typedef void(^LZWHeaderBackBlock)(NSInteger tag);
@interface LZWHeaderScrollView : UIView

@property(nonatomic,copy)LZWHeaderBackBlock block;


/*
    1、图片数组
    2、滚动一遍的总时间
    3、第一张图片点击的tag值
 */
-(id)initWithFrame:(CGRect)frame andWithImgArray:(NSArray *)imgArray andWithScrTime:(NSTimeInterval)interval andWithStartTag:(NSInteger)startTag;


@end





































































