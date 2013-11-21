//
//  URLManager.h
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLManager : NSObject
@property (nonatomic, strong)NSMutableArray *urls;

+ (URLManager *)shareManager;

- (void)addUrl:(NSString *)url;

- (void)removeUrl:(NSString *)url;

- (BOOL)storeToDisk;

@end
