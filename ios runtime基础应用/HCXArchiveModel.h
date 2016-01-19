//
//  HCXArchiveModel.h
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  runtime自动归档/解档

#import <Foundation/Foundation.h>

@interface HCXArchiveModel : NSObject<NSCoding>
@property (nonatomic, assign) int referenceCount;
@property (nonatomic, copy) NSString *archive;
@property (nonatomic, assign) const void *session;
@property (nonatomic, strong) NSNumber *totalCount;

/**
 *  测试属性为下划线的情况
 */
@property (nonatomic, assign) float _floatValue;

+ (void)test;
@end
