//
//  Person.h
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *_variableString;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *array;

/**
 *  获取对象所有属性名
 */
- (NSArray *)allPropertiesName;

/**
 *  获取对象的所有属性名和属性值
 */
- (NSDictionary *)allPropertiesNamesAndValues;

/**
 *  获取对象的所有方法名
 */
- (void)allMethods;

/**
 *  获取对象的成员变量名称
 *
 */
- (NSArray *)allMemberVariables;
@end
