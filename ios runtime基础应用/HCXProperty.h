//
//  HCXProperty.h
//  ios runtime基础应用
//
//  Created by 洪晨希 on 16/1/19.
//  Copyright © 2016年 洪晨希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCXProperty : NSObject {
    float _privateName;
    
    @private
    float _privateAttribute;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, assign) int count;
@property (nonatomic, weak)id delegate;
@property (atomic, strong) NSNumber *atomicNumber;

+ (void)test;

@end
