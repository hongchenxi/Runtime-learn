//
//  HCXTestModel.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  runtime模型与字典互转

#import "HCXTestModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation HCXTestModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        for (NSString *key in dictionary.allKeys) {
            id value = [dictionary objectForKey:key];
            if ([key isEqualToString:@"testModel"]) {
                HCXTestModel *testModel = [[HCXTestModel alloc]initWithDictionary:value];
                value = testModel;
                self.testModel = testModel;
                continue;
            }
            SEL setter = [self propertySetterWithKey:key];
            if (setter != nil) {
                ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    }
    
    return self;
}


- (NSDictionary *)toDictionary {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    if (outCount != 0) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:outCount];
        for (unsigned int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const void *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            
            if ([key isEqualToString:@"description"]
                || [key isEqualToString:@"debugDescription"]
                || [key isEqualToString:@"hash"]
                || [key isEqualToString:@"superclass"]) {
                continue;
            }
            if ([key isEqualToString:@"testModel"]) {
                if ([self respondsToSelector:@selector(toDictionary)]) {
                    id testModel = [self.testModel toDictionary];
                    if (testModel != nil) {
                        [dict setObject:testModel forKey:key];
                    }
                    continue;
                }
            }
            SEL getter = [self propertyGetterWithKey:key];
            if (getter != nil) {
                NSMethodSignature *signature = [self methodSignatureForSelector:getter];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setTarget:self];
                [invocation setSelector:getter];
                [invocation invoke];
                
                __unsafe_unretained NSObject *propertyValue = nil;
                [invocation getReturnValue:&propertyValue];
                if (propertyValue == nil) {
                    if ([self respondsToSelector:@selector(defaultValueForEmptyProperty)]) {
                        NSDictionary *defaultValueDict = [self defaultValueForEmptyProperty];
                        id defaultValue = [defaultValueDict objectForKey:key];
                        propertyValue = defaultValue;
                    }
                }
                if (propertyValue != nil) {
                    [dict setObject:propertyValue forKey:key];
                }
            }
        }
        free(properties);
        return dict;
    }
    free(properties);
    return nil;
}

- (SEL)propertyGetterWithKey:(NSString *)key {
    if (key != nil) {
        SEL getter = NSSelectorFromString(key);
        
        if ([self respondsToSelector:getter]) {
            return getter;
        }
    }
    return nil;
}

- (SEL)propertySetterWithKey:(NSString *)key {
    NSString *propertySetter = key.capitalizedString;
    propertySetter = [NSString stringWithFormat:@"set%@:",propertySetter];
    
    SEL setter = NSSelectorFromString(propertySetter);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

#pragma mark - HCXEmptyPropertyProtocol

- (NSDictionary *)defaultValueForEmptyProperty {
    return @{@"name": [NSNull null],
             @"title": [NSNull null],
             @"count": @(1),
             @"comment": @(1),
             @"classVersion": @"0.0.1"
             };
}

+ (void)test {
    NSMutableSet *set = [NSMutableSet setWithArray:@[@"可变集合", @"字典->不可变集合->可变集合"]];
    NSDictionary *dict = @{@"name"  : @"runtime学习之",
                           @"title" : @"runtime模型与字典互转",
                           @"count" : @(11),
                           @"results" : [NSSet setWithObjects:@"集合值1", @"集合值2", set , nil],
                           @"summaries" : @[@"sm1", @"sm2", @{@"keysm": @{@"stkey": @"字典->数组->字典->字典"}}],
                           @"parameters" : @{@"key1" : @"value1", @"key2": @{@"key11" : @"value11", @"key12" : @[@"三层", @"字典->字典->数组"]}},
                           @"classVersion" : @(1.1),
                           @"testModel" : @{@"name"  : @"标哥的技术博客",
                                            @"title" : @"http://www.henishuo.com",
                                            @"count" : @(11),
                                            @"results" : [NSSet setWithObjects:@"集合值1", @"集合值2", set , nil],
                                            @"summaries" : @[@"sm1", @"sm2", @{@"keysm": @{@"stkey": @"字典->数组->字典->字典"}}],
                                            @"parameters" : @{@"key1" : @"value1", @"key2": @{@"key11" : @"value11", @"key12" : @[@"三层", @"字典->字典->数组"]}},
                                            @"classVersion" : @(1.1)}};
    HCXTestModel *model = [[HCXTestModel alloc] initWithDictionary:dict];
    
    NSLog(@"%@", model);
    
    NSLog(@"model->dict: %@", [model toDictionary]);
}

@end
