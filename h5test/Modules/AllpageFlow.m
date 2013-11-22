//
//  AllpageFlow.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "AllpageFlow.h"

@implementation AllpageFlow

static AllpageFlow * instance;

+ (AllpageFlow *) shareInstance
{
    if (instance == nil) {
        instance = [[AllpageFlow alloc] init];
    }
    return instance;
}
- (NSString *) getAllFlows
{
    return [NSString stringWithFormat:@"%ld   KB",[AllpageFlow shareInstance].pagesFlow/1000 ];
}


- (AllpageFlow *) init
{
    instance = [super init];
    _pagesFlow = 0;
    return instance;
}

@end
