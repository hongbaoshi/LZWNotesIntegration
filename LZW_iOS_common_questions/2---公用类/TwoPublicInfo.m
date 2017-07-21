//
//  TwoPublicInfo.m
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/1.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TwoPublicInfo.h"
#import <UIKit/UIDevice.h>
#import <UIKit/UIKit.h>
#import <AdSupport/ASIdentifierManager.h>
#import "BNDReachability.h"
#import "KeyChainWrapper.h"
//************** 获取手机IP用的两个头文件；导入头文件，添加方法；
#import <arpa/inet.h>
#import <ifaddrs.h>

//************** 获取手机具体设备型号头文件；导入头文件，添加方法；
#import <sys/utsname.h>

//************** 获取手机当前网络状态；导入两个系统库 SystemConfiguration.framework；CoreTelephony.framework，添加方法；
//#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation TwoPublicInfo

LZWSingletonM(TwoPublicInfo)

#pragma mark --- 1、初始化公用信息单例类，给属性赋值；
-(void)setSDKInfoWithAppId:(NSString *)appId appKey:(NSString *)appKey directionNumber:(NSString *)directionNumber{
    
    //*** 1、appid、paysign、方向信息
    
    //*** 2、设备信息
    self.systemVer = [[UIDevice currentDevice] systemVersion];
    self.deviceName = [[UIDevice currentDevice] name];
    self.uuid = [self getUUID];
    //    self->_ipAddress = [self deviceIPAdress]; //*** 获取的内网ip，没有意义
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0){
        self.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        self.idfa = @"system version is lower than 6.0";
    }
    self.deviceInternet = [self deviceInternetType];
    self.deviceModelName = [self deviceModelName];   //*** 手机型号eg：iPhone7
    self.deviceScreenBounds = [self deviceScreenBounds];
}

#pragma mark --- 2、返回设备信息
- (NSDictionary *)createDiviceInfoForBusiness{
    return @{
             @"system_version": [self systemVer],
             @"device_modelname":[self deviceModelName],
             @"imei": [self uuid],
             @"device_id": [self idfa],
             @"os": @"1",
             @"ext": @""};
}


#pragma mark --- 3、返回设备信息
- (NSMutableDictionary *)createDiviceInfo
{
    return [[NSMutableDictionary alloc] initWithDictionary:@{@"SCREENSIZE": [self getScreenSize],
                                                             @"DEVICEID": [self idfa],
                                                             @"CHANNEL": @"",
                                                             @"TIME": [NSNumber numberWithInt:(int)[[NSDate date] timeIntervalSince1970]],
                                                             @"IMEI": [self uuid],
                                                             @"APPID": @"",
                                                             @"IPADDRESS": [self ipAddress],
                                                             @"SYSTEMVERSION": [self systemVer]}];
    
}





- (NSString *)getScreenSize
{
    NSString *height = [NSString stringWithFormat:@"%ld", (long)[UIScreen mainScreen].currentMode.size.height];
    NSString *width = [NSString stringWithFormat:@"%ld", (long)[UIScreen mainScreen].currentMode.size.width];
    return [NSString stringWithFormat:@"%@|%@", width, height];
}

//获取设备唯一标识码
-(NSString *) getUUID
{
    NSString *strUUID = [[NSString alloc] initWithData:[KeyChainWrapper load:@"uuid"] encoding:NSUTF8StringEncoding];
    //    NSLog(@"已经存储的idfv的值：%@",strUUID);
    if (!(strUUID.length>0))
    {
        strUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [KeyChainWrapper save:@"uuid" data:[strUUID dataUsingEncoding:NSUTF8StringEncoding]];
        //        NSLog(@"第一次获取的的idfv的值：%@",strUUID);
    }
    return strUUID;
}


//设备链接的网络IP地址
-(NSString *)deviceIPAdress
{
    NSString *address = @"1111111";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    //        NSLog(@"手机的IP是：%@", address);
    return address;
}


//设备的具体型号
-(NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone_1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone_3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone_3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone_4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon_iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone_4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone_5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone_5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone_5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone_5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone_5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone_5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone_6_Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone_6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone_6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone_6s_Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone_7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone_7_Plus";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod_Touch_1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod_Touch_2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod_Touch_3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod_Touch_4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod_Touch_5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad_2_(WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad_2_(GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad_2_(CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad_2_(32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad_mini_(WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad_mini_(GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad_mini_(CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad_3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad_3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad_3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad_4_(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad_4_(4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad_4_(CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad_Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad_Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad_Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad_Air_2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad_Air_2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad_mini_2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad_mini_3";
    
    return deviceModel;
}

//设备屏幕尺寸
-(NSString *)deviceScreenBounds
{
    NSString *str = [self deviceModelName];
    NSString *screenBounds = nil;
    if ([str isEqualToString:@"iPhone 4"])              screenBounds = @"586*1152";
    if ([str isEqualToString:@"Verizon iPhone 4"])      screenBounds = @"586*1152";
    if ([str isEqualToString:@"iPhone 4S"])             screenBounds = @"586*1152";
    if ([str isEqualToString:@"iPhone 5"])              screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 5"])              screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 5C"])             screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 5C"])             screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 5S"])             screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 5S"])             screenBounds = @"586*1238";
    if ([str isEqualToString:@"iPhone 6 Plus"])         screenBounds = @"778*1581";
    if ([str isEqualToString:@"iPhone 6"])              screenBounds = @"670*1381";
    if ([str isEqualToString:@"iPhone 6s"])             screenBounds = @"670*1381";
    if ([str isEqualToString:@"iPhone 6s Plus"])        screenBounds = @"778*1581";
    if ([str isEqualToString:@"iPhone_7"])              screenBounds = @"670*1381";
    if ([str isEqualToString:@"iPhone 7 Plus"])         screenBounds = @"778*1581";
    return screenBounds;
}


//设备的连接的网络
-(NSString *)deviceInternetType
{
    NSString *netconnType = nil;
    BNDReachability *reach = [BNDReachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case ReachableViaWiFi:
            //            NSLog(@"正在使用wifi网络");
            netconnType = @"wifi";
            break;
        case ReachableViaWWAN:
        {
            //            NSLog(@"正在使用蜂窝网络");
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = @"4G";
            }
            //            NSLog(@"当前连接网络：%@",netconnType);
        }
            break;
        case NotReachable:
            NSLog(@"没有网络，你在火星上吗？");
            netconnType = @"当前没有网络可连接";
            break;
            
        default:
            break;
    }
    
    return netconnType;
    
    
    //    return nil;
}



@end






















































