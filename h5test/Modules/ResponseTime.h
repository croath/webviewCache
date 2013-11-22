//
//  ResponseTime.h
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseTime : NSObject

@property (nonatomic) long totalResposeTime;

@property (nonatomic, strong) NSMutableDictionary * pageResponseTime;

+ (id) shareInstance;

@end
