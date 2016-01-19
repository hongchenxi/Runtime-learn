//
//  NSString+HCX.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "NSString+HCX.h"
#import <objc/runtime.h>
const void *k_HCXCallbackKey = @"k_HCXCallbackKey";
@implementation NSString (HCX)

- (void)setCallBack:(HCXCallBack)callBack {
    return objc_setAssociatedObject(self, k_HCXCallbackKey, callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (HCXCallBack)callBack {
    return objc_getAssociatedObject(self, k_HCXCallbackKey);
}

@end
