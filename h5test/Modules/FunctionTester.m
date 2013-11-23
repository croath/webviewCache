//
//  FunctionTester.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "FunctionTester.h"
#import "Level.h"

@implementation FunctionTester

static FunctionTester * instance;

+ (FunctionTester *) shareInstance
{
    if (instance == nil) {
        instance = [[FunctionTester alloc] init];
    }
    return instance;
}

- (void) functionTest:(NSString *) levelKeyWord  withurl:(NSString *)urlString andWebp:(BOOL) canWebp
{
    if ([urlString rangeOfString:levelKeyWord options:NSCaseInsensitiveSearch].location == NSNotFound) {
        [self addFailResultsWithUrl:urlString];
    }
    if (canWebp && [urlString rangeOfString:levelKeyWord options:NSCaseInsensitiveSearch].location == NSNotFound) {
        [self addFailResultsWithUrl:urlString];
    }
}

- (void) functionTestNoqWithUrl:(NSString *)urlString
{
    NSRange q75 = [urlString rangeOfString:lowerLevelKeyWord options:NSCaseInsensitiveSearch];
    NSRange q90 = [urlString rangeOfString:highLevelKeyWord options:NSCaseInsensitiveSearch];
    NSRange webp = [urlString rangeOfString:webpKeyWord options:NSCaseInsensitiveSearch];
    if (q75.location != NSNotFound && q90.location != NSNotFound && webp.location != NSNotFound) {
        [self addFailResultsWithUrl:urlString];
    }
}

- (void) addFailResultsWithUrl:(NSString *) urlString
{
    _canTestPassed = NO;
    [_failResults addObject:urlString];
}


- (FunctionTester *) init
{
    instance = [super init];
    _canTestPassed = YES;
    _failResults = [[NSMutableArray alloc] init];
    return instance;
}

@end
