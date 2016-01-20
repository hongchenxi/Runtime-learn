//
//  NSArray+HCXSwizzling.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/20.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "NSArray+HCXSwizzling.h"
#import "NSObject+HCXSwizzling.h"
#import <objc/runtime.h>
@implementation NSArray (HCXSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArray")swizzleSelector:@selector(lastObject) withSwizzltedSelector:@selector(hcx_lastObject)];
    });
}

- (id)hcx_lastObject {
    if (self.count == 0) {
        NSLog(@"%s 数组为空，直接返回nil",__FUNCTION__);
        return nil;
    }
    else {
        return [self hcx_lastObject];
    }
    
}

@end
