//
//  main.m
//  ZArraySortDemo
//
//  Created by AlexZhang on 2018/5/22.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

void sortArrayWithCompareMethod(void);
void sortArrayWithNSSortDescriptor(void);
void sortArrayWithBlock(void);
void setupData(void);

NSArray *nameArray;
NSArray *birthDateTimeStampArray;
NSArray *personArray;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         * initalization
         */
        setupData();
        printf("\n-----------------------\n");
        
        NSDate *beforeDate = [NSDate date];
        
        /*
         *  对象中实现Compare方法
         */
        sortArrayWithCompareMethod();
        
        /*
         *  NSSortDescriptor
         */
//        sortArrayWithNSSortDescriptor();
        
        /*
         *  Block
         */
//        sortArrayWithBlock();
        
        printf("\n-----------------------\n");
        /*
         *  计算时长
         */
        NSDate *afterDate = [NSDate date];
        NSTimeInterval duration = [afterDate timeIntervalSince1970] - [beforeDate timeIntervalSince1970];
        printf("duration = %lf\n\n", duration);
        
    }
    return 0;
}

void setupData() {
    nameArray = @[@"Jixin",
                  @"Alex",
                  @"alex",
                  @"Chandler",
                  @"Kobe",
                  @"1Day"];
    
    birthDateTimeStampArray = @[@(1526984251),
                                @(1526923252),
                                @(1527983288),
                                @(1527983288),
                                @(1526083230),
                                @(1426983253)];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:nameArray.count];
    printf("original array:\n\n");
    printf("name: \t birthDate:     \t age:\n \n");
    for (NSUInteger index = 0; index < nameArray.count; index++) {
        NSString *name = nameArray[index];
        NSNumber *number = birthDateTimeStampArray[index];
        Person *person = [[Person alloc] init];
        person.birthDate = [NSDate dateWithTimeIntervalSince1970:number.integerValue];
        person.name = name;
        person.age = (arc4random() % 30);
        [array addObject:person];
        
        printf("%s \t %0f \t %lu \n", [person.name UTF8String], [person.birthDate timeIntervalSince1970], (unsigned long)person.age);

    }
    personArray = [array copy];
}

#pragma mark - 对象中实现Compare方法

void sortArrayWithCompareMethod() {
    printf("\n1. 对象中实现Compare方法:\n\n");
    NSArray *array = [personArray copy];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    printf("sorted array:\n");
    printf("name: \t birthDate:     \t age:\n \n");

    for (NSUInteger index = 0; index < sortedArray.count; index++) {
        Person *person = sortedArray[index];
        printf("%s \t %0f \t %lu \n", [person.name UTF8String], [person.birthDate timeIntervalSince1970], (unsigned long)person.age);
    }
    
}

#pragma mark - NSSortDescriptor

void sortArrayWithNSSortDescriptor() {
    printf("\n2. NSSortDescriptor方法:\n\n");
    NSArray *array = [personArray copy];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"birthDate" ascending:YES];
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *sortDescriptors = @[sortDescriptor,nameSortDescriptor];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    
    printf("sorted array:\n");
    printf("name: \t birthDate:     \t age:\n \n");
    
    for (NSUInteger index = 0; index < sortedArray.count; index++) {
        Person *person = sortedArray[index];
        printf("%s \t %0f \t %lu \n", [person.name UTF8String], [person.birthDate timeIntervalSince1970], (unsigned long)person.age);
    }
}

#pragma mark - Block

void sortArrayWithBlock() {
    printf("\n3. Block方法:\n \n");
    NSArray *array = [personArray copy];

    NSComparator sortComparator = ^NSComparisonResult(id a, id b) {
        NSDate *first = [(Person *)a birthDate];
        NSDate *second = [(Person *)b birthDate];
        NSComparisonResult comparator = [first compare:second];
        if (comparator != NSOrderedSame) {
            NSString *firstName = [(Person *)a name];
            NSString *secondName = [(Person *)a name];
            comparator = [firstName compare:secondName];
        }
        return comparator;
    };
    NSArray *sortedArray = [array sortedArrayUsingComparator:sortComparator];

    printf("sorted array:\n");
    printf("name: \t birthDate:     \t age:\n \n");
    
    for (NSUInteger index = 0; index < sortedArray.count; index++) {
        Person *person = sortedArray[index];
        printf("%s \t %0f \t %lu \n", [person.name UTF8String], [person.birthDate timeIntervalSince1970], (unsigned long)person.age);
    }
}
