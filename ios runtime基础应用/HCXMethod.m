//
//  HCXMethod.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/20.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  runtime Method学习

#import "HCXMethod.h"
#import <objc/message.h>
@implementation HCXMethod

- (int)testInstanceMethod:(NSString *)name Value:(NSNumber *)value {
    NSLog(@"name:%@",name);
    return value.intValue;
}

- (NSArray *)arrayWithNames:(NSArray *)names {
    NSLog(@"names:%@",names);
    return names;
}

#pragma mark -  获取函数列表

- (void)getMethodList {
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        NSLog(@"方法名：%@",NSStringFromSelector(methodName));
        
        unsigned int argumentCount = method_getNumberOfArguments(method);
        char argName[512] = {};
        for (unsigned int j = 0; j < argumentCount; j++) {
            method_getArgumentType(method, j, argName, 512);
            NSLog(@"第%u个参数的类型是：%s",j,argName);
            memset(argName, '\0', strlen(argName));
        }
        char returntType[512] = {};
        method_getReturnType(method, returntType, 512);
        NSLog(@"返回值类型：%s",returntType);
        
        NSLog(@"TypeEncoding:%s",method_getTypeEncoding(method));
    }
    free(methodList);
}

+ (void)test {
    HCXMethod *mmthod = [[HCXMethod alloc]init];
    [mmthod getMethodList];
    
    int intValue = ((int (*)(id, SEL, NSString *, NSNumber *))objc_msgSend)((id)mmthod, @selector(testInstanceMethod:Value:),@"runtimeMethod学习",@100);
    NSLog(@"intValue:%d",intValue);
    
    Method mm = class_getInstanceMethod([self class], @selector(testInstanceMethod:Value:));
    int sameIntValue = ((int (*)(id, SEL, NSString *, NSNumber *))method_invoke)((id)mmthod, mm,@"runtimeMethod学习",@100);
    NSLog(@"sameIntValue:%d",sameIntValue);
}

@end
