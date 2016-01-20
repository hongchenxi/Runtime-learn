//
//  NSMutableArray+HCXSwizzling.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/20.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "NSMutableArray+HCXSwizzling.h"
#import "NSObject+HCXSwizzling.h"
#import <objc/runtime.h>
@implementation NSMutableArray (HCXSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(removeObject:) withSwizzltedSelector:@selector(hcx_removeObject:)];
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(addObject:) withSwizzltedSelector:@selector(hcx_addObject:)];
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(removeObjectAtIndex:)withSwizzltedSelector:@selector(hxc_RemoveObjectAtIndex:)];
        
        [objc_getClass("__NSArrayM")swizzleSelector:@selector(insertObject:atIndex:)withSwizzltedSelector:@selector(hcx_insertObject:atIndex:)];
        
        [objc_getClass("__NSPlaceholderArray")swizzleSelector:@selector(initWithObjects:count:) withSwizzltedSelector:@selector(hcx_initWithObjects:count:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:) withSwizzltedSelector:@selector(hcx_objectAtIndex:)];
    });
}

- (void)hcx_removeObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s,尝试移除一个对象，但该对象不存在",__FUNCTION__);
        return;
    }
    else {
        [self hcx_removeObject:obj];
    }
}

- (void)hcx_addObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s,不能添加一个nil对象到数组中",__FUNCTION__);
        return;
    }
    else {
        [self hcx_addObject:obj];
    }
}

- (void)hxc_RemoveObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s,该数组为空",__FUNCTION__);
        return;
    }
    if (index > self.count) {
        NSLog(@"%s,数组越界",__FUNCTION__);
        return;
    }
    else {
        [self hxc_RemoveObjectAtIndex:index];
    }
}

- (void)hcx_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s,数组不允许插入nil值",__FUNCTION__);
        return;
    }
    else if (index > self.count) {
        NSLog(@"%s,尝试插入一个新值到数组，但是越界",__FUNCTION__);
    }
    else {
        [self hcx_insertObject:anObject atIndex:index];
    }
}

- (instancetype)hcx_initWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObjects = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObjects = YES;
            NSString *errorMsg = [NSString stringWithFormat:@"数组中元素不能为nil，%lu处的值为nil",i];
//            NSAssert(objects[i] != nil, errorMsg);
            NSLog(@"%@",errorMsg);
        }
    }
    if (hasNilObjects) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self hcx_initWithObjects:newObjects count:index];
    }
    return [self hcx_initWithObjects:objects count:cnt];
}

- (id)hcx_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s,该数组为空",__FUNCTION__);
        return nil;
    }
    if (index >= self.count) {
        NSLog(@"%s,index越界",__FUNCTION__);
        return nil;
    }
    else {
        return [self hcx_objectAtIndex:index];
    }
    
}

@end
