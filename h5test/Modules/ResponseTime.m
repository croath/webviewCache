//
//  ResponseTime.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ResponseTime.h"

@implementation ResponseTimeObj

-(ResponseTimeObj *)initWithUrl:(NSString * )url
{
    self = [super init];
    _url = url;
    return self;
}

- (NSTimeInterval)getResponseTime
{
    return [_afterLoadTime timeIntervalSinceDate:_beforeLoadTime];
}

- (NSString *)getDetailResponseTime
{
    return [NSString stringWithFormat:@"%f  秒",[self getResponseTime]];
}


@end

@implementation ResponseTime

static ResponseTime * instance;

+ (ResponseTime *) shareInstance
{
    if (instance == nil) {
        instance = [[ResponseTime alloc] init];
    }
    return instance;
}
- (NSString * ) averageTime
{
    NSTimeInterval totalTimes = 0;
    for (ResponseTimeObj * resobj in _pageResponseTime) {
        if ([resobj isKindOfClass:[ResponseTimeObj class]]) {
            ResponseTimeObj * testobj = (ResponseTimeObj *)resobj;
            totalTimes = totalTimes + [testobj getResponseTime];
        }
    }
    NSTimeInterval averageTime = totalTimes/[_pageResponseTime count];
    
    return [NSString stringWithFormat:@"%.2f  秒",averageTime];
}


- (ResponseTime *) init
{
    instance = [super init];
    _pageResponseTime = [[NSMutableArray alloc] init];
    return instance;
}
@end
