//
//  Person.h
//  ZArraySortDemo
//
//  Created by AlexZhang on 2018/5/22.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSDate *birthDate;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy) NSString *name;

- (NSComparisonResult)compare:(Person *)person;

@end
