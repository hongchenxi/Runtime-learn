//
//  NSObject+HCXSwizzling.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/20.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "NSObject+HCXSwizzling.h"
#import <objc/runtime.h>
@implementation NSObject (HCXSwizzling)

+ (void)swizzleSelector:(SEL)originSelector withSwizzltedSelector:(SEL)swizzltedSelector {
    Class currentClass = [self class];
    Method originMethod = class_getInstanceMethod(currentClass, originSelector);
    Method swizzltedMethod = class_getInstanceMethod(currentClass, swizzltedSelector);
    
    //若已经存在，则会添加失败
    BOOL didAddMethod = class_addMethod(currentClass, originSelector, method_getImplementation(swizzltedMethod), method_getTypeEncoding(swizzltedMethod));
    
    // 若原来的方法并不存在，则添加即可
    if (didAddMethod) {
        class_replaceMethod(currentClass, swizzltedSelector, method_getImplementation(swizzltedMethod), method_getTypeEncoding(swizzltedMethod));
    }
    else {
        method_exchangeImplementations(originMethod, swizzltedMethod);
    }
    
}
@end
