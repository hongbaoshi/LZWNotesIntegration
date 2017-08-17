//
//  TwoPublicMethod.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/6/30.
//  Copyright © 2017年 红宝时. All rights reserved.
//
//

#import "TwoPublicMethod.h"
#import <CommonCrypto/CommonDigest.h>
@implementation TwoPublicMethod


//*** 1、获取bundle文件
+ (NSBundle *)getResourceBundleWithName:(NSString *)bundleName
{
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    return [NSBundle bundleWithURL:bundleUrl];
}


//*** 2、获取bunle文件里面的图片
+ (UIImage *)getImageFromBundle:(NSBundle *)bundle withName:(NSString *)name withType:(NSString *)type{
    NSString *imagePath = [bundle pathForResource:name ofType:type];
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:imagePath]];
    return image;
}

//*** 3、将字符串转换成md5
+ (NSString *)md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

//*** 4、字典转成字符串
+ (NSString *)buildQueryString:(id)dict sortArray:(NSArray *)sortArray needUrlEncode:(BOOL)isEncode{
    if ([dict isKindOfClass:[NSDictionary class]] || [dict isKindOfClass:[NSDictionary class]]) {
        NSMutableString *tempMsg = [NSMutableString string];
        for (id str in sortArray)
        {
            NSString *urlEncodedStr = nil;
            if ([[dict objectForKey:str] isKindOfClass:[NSString class]] && isEncode) {
                urlEncodedStr = [TwoPublicMethod encodeString:[dict objectForKey:str]];
            }
            else{
                urlEncodedStr = [dict objectForKey:str];
            }
            [tempMsg appendString:[NSString stringWithFormat:@"%@=%@&", str, urlEncodedStr]];
        }
        NSString *queryMsg = [tempMsg substringToIndex:tempMsg.length - 1];
        return queryMsg;
    }else{
        [NSException raise:@"SDK Error" format:@"不可用数据类型 %@", [dict class]];
        return nil;
    }
}


//*** 5、获取主视图的根视图控制器
+(UIViewController *)getKeyWindowRootVcr{
    UIViewController *vcr = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = vcr;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


//*** 6、判断是否是手机号码
+(BOOL)isValidateTel:(NSString *)tel
{
    NSString *patternTel = @"^1[3,4,5,7,8][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:tel options:0 range:NSMakeRange(0, [tel length])];
    return isMatchTel? YES: NO;
}



+ (NSString *)encodeString:(NSString*)unencodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)unencodedString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return encodedString;
}

+ (NSString *)decodeString:(NSString*)encodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)encodedString, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


@end
