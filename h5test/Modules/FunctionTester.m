//
//  FunctionTester.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "FunctionTester.h"

@implementation FunctionTester

static FunctionTester * instance;

+ (FunctionTester *) shareInstance
{
    if (instance == nil) {
        instance = [[FunctionTester alloc] init];
    }
    return instance;
}


- (FunctionTester *) init
{
    instance = [super init];
    _canTestPassed = YES;
    _failResults = [[NSMutableArray alloc] init];
    return instance;
}

@end
