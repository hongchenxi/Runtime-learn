//
//  HCXTeacher.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "HCXTeacher.h"
#import <objc/message.h>
#import "HCXStudent.h"
@implementation HCXTeacher

//第一步，我们不动态添加方法，返回NO
+(BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

//第二步，备选提供响应aSelector的对象，我们不备选，因此设置为nil，就会进入第三步
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

//第三步，先返回方法器。如果返回nil，则表示无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector)isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

//只有返回了方法签名，都会进入这一步，这一步用户调用方法，改变对象等
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:[[HCXStudent alloc]init]];
}

@end
