//
//  ViewController.m
//  UsingSwiftInOC
//
//  Created by AlexZhang on 2018/4/19.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "ViewController.h"
#import "UsingSwiftInOC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MySwiftObject *myOb = [[MySwiftObject alloc] init];
    NSLog(@"MyOb.someProperty: %@", myOb.someProperty);
    myOb.someProperty = @"Hello world";
    NSLog(@"MyOb.someProperty: %@", myOb.someProperty);
    NSString * retString = [myOb someFunctionWithSomeArg:@"Arg"];
    NSLog(@"RetString: %@", retString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
