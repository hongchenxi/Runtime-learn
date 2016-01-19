//
//  NSString+HCX.h
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  Category扩展属性

#import <Foundation/Foundation.h>

typedef void (^HCXCallBack)();

@interface NSString (HCX)

@property (nonatomic, copy) HCXCallBack callBack;

@end
