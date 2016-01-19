//
//  HCXTestModel.h
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/18.
//  Copyright © 2016年 洪晨希. All rights reserved.
//  runtime模型与字典互转

#import <Foundation/Foundation.h>
@protocol HCXEmptyPropertyProtocol <NSObject>

@optional
- (NSDictionary *)defaultValueForEmptyProperty;

@end

@interface HCXTestModel : NSObject<HCXEmptyPropertyProtocol>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, assign) int    commentCount;
@property (nonatomic, copy) NSArray *summaries;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, copy) NSSet *results;
@property (nonatomic, strong) HCXTestModel *testModel;
@property (nonatomic, readonly, assign) NSString *classVersion;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;
+ (void)test;

@end
