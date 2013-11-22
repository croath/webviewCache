//
//  ResponseTime.h
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseTime : NSObject

@property (nonatomic, strong) NSMutableArray * pageResponseTime;

+ (ResponseTime * ) shareInstance;

- (NSString * ) averageTime;

@end

@interface ResponseTimeObj : NSObject

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSDate * beforeLoadTime;

@property (nonatomic, strong) NSDate * afterLoadTime;

@property (nonatomic)  NSTimeInterval responseTimes;

-(ResponseTimeObj *)initWithUrl:(NSString * )url;

- (NSTimeInterval)getResponseTime;

- (NSString *)getDetailResponseTime;

@end
