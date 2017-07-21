//
//  TwoPublicInfo.h
//  LZW_iOS_common_questions
//
//  Created by 红宝时 on 2017/7/1.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZWSingleton.h"
@interface TwoPublicInfo : NSObject

@property (strong) NSString *systemVer;     //手机系统版本 如:10.3
@property (strong) NSString *deviceName;    //手机设备的用户名 如:红宝时 
@property (strong) NSString *uuid;          // idfv---手机本地保存，app对应的唯一表示；
@property (strong) NSString *ipAddress;     //内网ip地址
@property (strong) NSString *idfa;          //idfa---广告标示，不能获取为0000-0000-000-00-000
@property(nonatomic,strong)NSString *deviceInternet; //网络环境wifi、4G、3G
@property(nonatomic,strong)NSString *deviceModelName; //苹果手机型号 如:iPhone7
@property(nonatomic,strong)NSString *deviceScreenBounds; //手机屏宽

LZWSingletonH(TwoPublicInfo)

#pragma mark --- 1、初始化公用信息单例类，给属性赋值；
-(void)setSDKInfoWithAppId:(NSString *)appId appKey:(NSString *)appKey directionNumber:(NSString *)directionNumber;

#pragma mark --- 2、返回设备信息
- (NSMutableDictionary *)createDiviceInfo;

#pragma mark --- 3、返回设备信息
- (NSDictionary *)createDiviceInfoForBusiness;


@end


















































