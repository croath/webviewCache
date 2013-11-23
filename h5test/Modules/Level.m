//
//  Level.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "Level.h"

@implementation Level

static Level * instance;

+ (Level *) shareInstance
{
    if (instance == nil) {
        instance = [[Level alloc] init];
    }
    return instance;
}


- (Level *) init
{
    instance = [super init];
    return instance;
}


@end
