//
//  HCXProperty.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "HCXProperty.h"
#import <objc/runtime.h>

@implementation HCXProperty

- (void)getAllProperties {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
       objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        NSLog(@"propertyName:%s - propertyAttributes:%s",propertyName,propertyAttributes);
        
        unsigned int count = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(property, &count);
        for (unsigned int j = 0; j < count; j++) {
            objc_property_attribute_t attribute = attributes[j];
            const char *attributeName = attribute.name;
            const char *attributeValue = attribute.value;
            NSLog(@"attributeName:%s - attributeValue:%s",attributeName,attributeValue);
        }
        
        free(attributes);
    }
    free(properties);
}


- (void)getAllMemberVaribles {
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"name:%s - encodetype:%s",name,type);
    }
    free(ivars);
}

+ (void)test {
    HCXProperty *p = [[HCXProperty alloc]init];
    [p getAllProperties];
    NSLog(@"=====================分割线===================================");
    [p getAllMemberVaribles];
}

@end
