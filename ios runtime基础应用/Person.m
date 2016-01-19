//
//  Person.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
typedef struct objc_property *objc_property_t;
@implementation Person

/**
 *  返回搜索的属性名
 *
 *  @return <#return value description#>
 */
- (NSArray *)allPropertiesName {
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    /*--------------- 给数组分配容量----------------*/
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [propertiesArray addObject:name];
    }
    
    free(properties);
    
    return propertiesArray;
    
}

/**
 *  返回所有的属性名和属性值
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)allPropertiesNamesAndValues {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        id propertyValue = [self valueForKey:propertyName];
        
        if (propertyName && propertyValue != nil) {
            [resultDict setObject:propertyValue forKey:propertyName];
        }
        
    }
    
    free(properties);
    
    return resultDict;
    
}

- (void)allMethods {
    
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (NSUInteger i = 0; i < count; i++) {
        Method method = methods[i];
        
        SEL methodSEL = method_getName(method);
        const char *name = sel_getName(methodSEL);
        NSString *methodName = [NSString stringWithUTF8String:name];
        
        //获取方法的参数列表
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"方法名：%@，参数个数：%d",methodName, arguments);
    }
    
    free(methods);
    
}

- (NSArray *)allMemberVariables {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    NSMutableArray *results = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < count; i++) {
        Ivar variable = ivars[i];
        const char *name = ivar_getName(variable);
        NSString *varName = [NSString stringWithUTF8String:name];
        [results addObject:varName];
    }
    free(ivars);
    
    return results;
}
@end
