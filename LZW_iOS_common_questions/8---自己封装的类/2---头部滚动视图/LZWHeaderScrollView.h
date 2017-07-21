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

-(id)initWithFrame:(CGRect)frame andWithImgArray:(NSArray *)imgArray andWithScrTime:(NSTimeInterval)interval andWithStartTag:(NSInteger)startTag;


@end





































































