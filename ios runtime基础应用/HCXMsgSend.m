//
//  HCXMsgSend.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  runtime objc_msgSend使用

#import "HCXMsgSend.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
@implementation HCXMsgSend

- (void)noArgumentsAndNoReturnValue {
    NSLog(@"%s was called, and it has no arguments and no return values",__func__);
}

- (void)hasArgumentsAndNoReturnValue:(NSString *)arg {
    NSLog(@"%s was called, and arguments is:%@ but no return values",__func__, arg);
}

- (NSString *)noArgumentsButHasReturnValue {
    NSLog(@"%s was called, and it has no arguments but has return values is:%@",__func__,@"不带参数，但是有返回值");
    return @"不带参数，但是有返回值";
}

- (int)hasArguments:(NSString *)param andReturnValue:(int)param1 {
    NSLog(@"%s was called, and argument is %@, return value is %d", __FUNCTION__, param, param1);
    return param1;
}

+ (void)test {
    
#pragma mark - 创建并初始化对象
    HCXMsgSend *msg = ((HCXMsgSend * (*)(id, SEL))objc_msgSend)((id)[HCXMsgSend class], @selector(alloc));
    msg = ((HCXMsgSend * (*)(id, SEL))objc_msgSend)((id)msg, @selector(init));
    
#pragma mark - 发送无参数无返回值消息
        ((void (*)(id, SEL))objc_msgSend)((id)msg, @selector(noArgumentsAndNoReturnValue));
    
#pragma mark - 带参数不带返回值消息
        ((void (*)(id, SEL,NSString *))objc_msgSend)((id)msg, @selector(hasArgumentsAndNoReturnValue:),@"带一个参数，但没有返回值");
    
#pragma mark - 带返回值不带参数消息
        NSString *returnValues = ((NSString * (*)(id, SEL))objc_msgSend)((id)msg, @selector(noArgumentsButHasReturnValue));
        NSLog(@"returnValues:%@",returnValues);
    
#pragma mark - 带参数带返回值的消息
        int returnIntValue = ((int (*)(id, SEL, NSString *, int))objc_msgSend)((id)msg,
                                                                  @selector(hasArguments:andReturnValue:),
                                                                  @"参数1",
                                                                  2016);
        NSLog(@"returnValue:%d",returnIntValue);
    
#pragma mark - 动态添加方法再调用
        class_addMethod(msg.class, NSSelectorFromString(@"cStyleFunc"), (IMP)cStyleFunc, "i@:");
        int returnValue = ((int (*)(id, SEL, const void *, const void *))objc_msgSend)((id)msg,
                                                                                       NSSelectorFromString(@"cStyleFunc"),
                                                                                       "参数1",
                                                                                       "参数2");
        NSLog(@"returnValue:%d",returnValue);
    
#pragma mark - 带浮点返回值的消息objc_msgSend_fpret和objc_msgSend一样
    float returnFloatValue = ((float (*)(id, SEL))objc_msgSend)((id)msg, @selector(returnFloatType));
    NSLog(@"returnFloatValue:%f",returnFloatValue);
    
    float returnFloatValue2 = ((float (*)(id, SEL))objc_msgSend_fpret)((id)msg, @selector(returnFloatType));
    NSLog(@"returnFloatValue2:%f",returnFloatValue2);
    
    
#pragma mark - 返回结构体时，不能使用objc_msgSend，而是要使用objc_msgSend_stret，否则会crash
    CGRect rect = ((CGRect (*)(id, SEL))objc_msgSend_stret)((id)msg, @selector(returnStructType));
    NSLog(@"rect:%@",NSStringFromCGRect(rect));
}

int cStyleFunc(const void *arg1, const void *arg2) {
    NSLog(@"%s was called, arg1 is %s, and arg2 is %s", __FUNCTION__, arg1, arg2);
    return 1;
}

- (float)returnFloatType {
    NSLog(@"%s was called, and has return value", __FUNCTION__);
    return 3.1415926;
}

- (CGRect)returnStructType {
    NSLog(@"%s was called", __FUNCTION__);
    return CGRectMake(10, 10, 10, 10);
}

@end
