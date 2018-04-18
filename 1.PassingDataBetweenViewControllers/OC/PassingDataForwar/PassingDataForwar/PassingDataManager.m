//
//  PassingDataManager.m
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/11.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "PassingDataManager.h"

@implementation PassingDataManager

+ (instancetype)sharedManager {
    static PassingDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PassingDataManager alloc] init];
    });
    return manager;
}

@end
