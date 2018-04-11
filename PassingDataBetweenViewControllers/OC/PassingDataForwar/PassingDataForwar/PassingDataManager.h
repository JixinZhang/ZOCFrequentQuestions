//
//  PassingDataManager.h
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/11.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassingDataManager : NSObject

@property (nonatomic, copy) NSString *content;

+ (instancetype)sharedManager;

@end
