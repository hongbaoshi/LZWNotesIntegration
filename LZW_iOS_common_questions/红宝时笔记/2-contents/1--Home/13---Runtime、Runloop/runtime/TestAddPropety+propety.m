//
//  TestAddPropety+propety.m
//  1234567
//
//  Created by 红宝时 on 2017/8/25.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "TestAddPropety+propety.h"
#import <objc/runtime.h>


@implementation TestAddPropety (propety)
@dynamic age;
@dynamic name;      //*** 告诉系统自己申明 set、get方法

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.age = @"66666";
        self.name = @"shabi";
    }
    return self;
}

//*** 添加属性扩展set方法
static char* const ageKey = "ageKey";
static char* const nameKey = "nameKey";

-(void)setAge:(NSString *)age
{
    objc_setAssociatedObject(self, ageKey, age, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)age
{
    return objc_getAssociatedObject(self, ageKey);
}

-(NSString *)name
{
    return objc_getAssociatedObject(self, nameKey);
}

@end



































