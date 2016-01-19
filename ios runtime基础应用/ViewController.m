//
//  ViewController.m
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "HCXTestModel.h"
#import "HCXArchiveModel.h"
#import "HCXStudent.h"
#import "HCXTeacher.h"
#import "HCXParents.h"
#import "HCXMsgSend.h"
#import "HCXProperty.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    Person *p = [[Person alloc]init];
//    p.name = @"zs";
//    
//    size_t size =  class_getInstanceSize(p.class);
//    NSLog(@"size=%ld",size);
//    
//
#pragma makr - 获取对象所有属性名
//
//    for (NSString *propertyName in [p allPropertiesName]) {
//        NSLog(@"属性名：%@",propertyName);
//    }
//
#pragma makr - 获取对象的所有属性名和属性值
//
//    NSLog(@"属性值：属性名：%@",[p allPropertiesNamesAndValues]);
//
#pragma makr - 获取对象的所有方法名
//
//    [p allMethods];
//
#pragma makr - 获取对象的成员变量名称
//
//    for (NSString *varName in [p allMemberVariables]) {
//        NSLog(@"获取对象的成员变量名称:%@",varName);
//    }
//
#pragma makr - 运行时发消息
//    objc_msgSend(p, @selector(allMethods));

#pragma makr - runtime模型与字典互转
//    [HCXTestModel test];

#pragma mark - runtime自动归档/解档
//    [HCXArchiveModel test];
    
#pragma mark - Runtime Message Forwarding(消息转发机制)
//    HCXStudent *student = [[HCXStudent alloc]init];
//    [student sing];
    
//    HCXTeacher *teacher = [[HCXTeacher alloc]init];
//    [teacher performSelector:@selector(sing) withObject:nil afterDelay:0];
//    ((void (*)(id, SEL))objc_msgSend)((id)teacher,@selector(sing));
    
//    HCXParents *parent = [[HCXParents alloc]init];
//    [parent performSelector:@selector(sing) withObject:nil withObject:0];
//    ((void (*)(id, SEL))objc_msgSend)((id)parent,@selector(sing));

#pragma mark - runtime objc_msgSend使用
//    [HCXMsgSend test];

#pragma mark - runtime属性与成员变量
    [HCXProperty test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
