//
//  CDUIKit.m
//  WYFX_Demo
//
//  Created by 顾泠轩 on 16/12/20.
//  Copyright © 2016年 ChenDan. All rights reserved.
//

#import "CDUIKit.h"

@implementation CDUIKit

+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label ;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    //设置背景图片，可以使文字与图片共存
    if(imageName){
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    //图片与文字如果需要同时存在，就需要图片足够小
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
    
}
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view ;
    
}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField ;
    
}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*text= [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    text.background=[UIImage imageNamed:imageName];
    return  text;
    
}
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView ;
}
+(UIPageControl*)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider ;
}
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma -mark 判断导航的高度
//+(float)isIOS7{
//
//    float height;
//    if (IOS7) {
//        height=64.0;
//    }else{
//        height=44;
//    }
//
//    return height;
//}
//+(NSString *)platformString{
//    // Gets a string with the device model
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    NSDictionary* d = nil;
//    if (d == nil)
//    {
//        d = @{
//              @"iPhone1,1": @"iPhone 2G",
//              @"iPhone1,2": @"iPhone 3G",
//              @"iPhone2,1": @"iPhone 3GS",
//              @"iPhone3,1": @"iPhone 4",
//              @"iPhone3,2": @"iPhone 4",
//              @"iPhone3,3": @"iPhone 4 (CDMA)",
//              @"iPhone4,1": @"iPhone 4S",
//              @"iPhone5,1": @"iPhone 5",
//              @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
//
//              @"iPod1,1": @"iPod Touch (1 Gen)",
//              @"iPod2,1": @"iPod Touch (2 Gen)",
//              @"iPod3,1": @"iPod Touch (3 Gen)",
//              @"iPod4,1": @"iPod Touch (4 Gen)",
//              @"iPod5,1": @"iPod Touch (5 Gen)",
//
//              @"iPad1,1": @"iPad",
//              @"iPad1,2": @"iPad 3G",
//              @"iPad2,1": @"iPad 2 (WiFi)",
//              @"iPad2,2": @"iPad 2",
//              @"iPad2,3": @"iPad 2 (CDMA)",
//              @"iPad2,4": @"iPad 2",
//              @"iPad2,5": @"iPad Mini (WiFi)",
//              @"iPad2,6": @"iPad Mini",
//              @"iPad2,7": @"iPad Mini (GSM+CDMA)",
//              @"iPad3,1": @"iPad 3 (WiFi)",
//              @"iPad3,2": @"iPad 3 (GSM+CDMA)",
//              @"iPad3,3": @"iPad 3",
//              @"iPad3,4": @"iPad 4 (WiFi)",
//              @"iPad3,5": @"iPad 4",
//              @"iPad3,6": @"iPad 4 (GSM+CDMA)",
//
//              @"i386": @"Simulator",
//              @"x86_64": @"Simulator"
//              };
//    }
//    NSString* ret = [d objectForKey: platform];
//
//    if (ret == nil)
//    {
//        return platform;
//    }
//    return ret;
//}

+(NSString*)isUrl:(NSString*)str{
    
    NSString*string=[[str   componentsSeparatedByString:@"offline/"]lastObject];
    NSString*str1=[[str     componentsSeparatedByString:@"/offline"]firstObject];
    return str1;
        
}


#pragma mark 系统菊花
+(UIView*)JUHUA{
    
    UIActivityIndicatorView*activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center=CGPointMake(320/2-5, 190);
    
    //放大后会粗糙
    activity.transform=CGAffineTransformMakeScale(2, 2);
    // activity.color=[UIColor whiteColor];
    return activity;
}


//#pragma mark
//+ (int)peripheralState{
//
//
//    UARTPeripheral*per=[UARTPeripheral shareManager];
//    CBPeripheral*peripheral=per.a_peripheral;
//
//    return peripheral.state;
//
//}
//#pragma mark 返回蓝牙连接状态
//+(BOOL)perpher{
//
//    UARTPeripheral*per=[UARTPeripheral shareManager];
//
//    return [per.a_peripheral isConnected];
//
//
//}


//+(void)baojing{
//
//    NSString*path=[[NSBundle mainBundle]pathForResource:@"叮咚" ofType:@"mp3"];
//    //            //创建一个系统id
//    SystemSoundID soundID;
//    //            //需要关闭ARC
//    AudioServicesCreateSystemSoundID((CFURLRef)([NSURL fileURLWithPath:path]), &soundID);
//    //            //进行播放音效
//    AudioServicesPlaySystemSound(soundID);
//    //            //短期震动
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//}
//
//#pragma mark 数组转JSON
//+(NSString *) jsonStringWithArray:(NSArray *)array{
//    NSMutableString *reString = [NSMutableString string];
//    [reString appendString:@"["];
//    NSMutableArray *values = [NSMutableArray array];
//    for (id valueObj in array) {
//        //
//        NSMutableString *s = [NSMutableString stringWithString:valueObj];
//        [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//        [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//        [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//        [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//        [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//        [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//        [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//
//
//
//        NSString *value = [NSString stringWithString:s];
//
//
//        if (value) {
//            [values addObject:[NSString stringWithFormat:@"%@",value]];
//
//
//        }
//    }
//    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
//    [reString appendString:@"]"];
//    return reString;
//}
//-(NSString *)JSONString:(NSString *)aString {
//
//    NSMutableString *s = [NSMutableString stringWithString:aString];
//    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//
//
//    return [NSString stringWithString:s];
//}




#pragma mark --------- Label --------

+ (UILabel *)labelTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)size {
    return [CDUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:size];
    
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)size {
    return [CDUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:text fontSize:size];
    
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size {
    return [CDUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:numberOfLines text:text fontSize:size];
    
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)size {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

#pragma mark --------- ImageView --------

+ (UIImageView *)imageViewWithImage:(UIImage *)image {
    
    return [CDUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image
             userInteractionEnabled:(BOOL)enabled {
    
    return [CDUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:enabled image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                                    image:(UIImage *)image {
    
    return [CDUIKit imageViewWithContentMode:mode userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                   userInteractionEnabled:(BOOL)enabled
                                    image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.userInteractionEnabled = enabled;
    imageView.image = image;
    return imageView;
}

#pragma mark --------- UIButton --------

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
    
}


+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    return [CDUIKit buttonWithBackgroundColor:backgroundColor titleColor:titleColor titleHighlightColor:titleColor title:title fontSize:size];
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                    titleHighlightColor:(UIColor *)titleHighlightColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}


+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id)delegate {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    return tableView;
}

+ (void)sj_tableView:(UITableView *)tableView withDelegate:(id)delegate {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    
}



@end
