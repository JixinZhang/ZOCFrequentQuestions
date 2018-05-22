//
//  Person.m
//  ZArraySortDemo
//
//  Created by AlexZhang on 2018/5/22.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSComparisonResult)compare:(Person *)person {
    return [self.birthDate compare:person.birthDate];
}

@end
