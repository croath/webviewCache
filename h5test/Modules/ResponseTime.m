//
//  ResponseTime.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ResponseTime.h"

@implementation ResponseTime

static ResponseTime * instance;

+ (id) shareInstance
{
    if (instance == nil) {
        instance = [[ResponseTime alloc] init];
    }
    return instance;
}


- (id) init
{
    instance = [super init];
    _totalResposeTime = 0;
    _pageResponseTime = [[NSMutableDictionary alloc] init];
    return instance;
}
@end
