//
//  HCXStudent.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "HCXStudent.h"
#import <objc/message.h>
@implementation HCXStudent
/**
 *  第一步：实现此方法，在调用对象的某个方法找不到时，会先调用这个方法，允许我们动态添加方法实现
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 这里没有给student实现sing方法，所以我们可以动态添加sing方法
    if ([NSStringFromSelector(sel)isEqualToString:@"sing"]) {
        class_addMethod(self, sel, (IMP)sing,  "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


void sing(id self, SEL cmd) {
    NSLog(@"%@在唱歌",self);
}
@end
