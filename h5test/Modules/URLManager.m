//
//  URLManager.m
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "URLManager.h"

static URLManager *s_instance;

@interface URLManager()
@property (nonatomic, strong)NSFileManager *fileManager;
@property (nonatomic, strong)NSString *storageFilePath;
@end

@implementation URLManager
@synthesize urls = _urls;
@synthesize fileManager = _fileManager, storageFilePath = _storageFilePath;

#pragma mark - Getter
- (NSFileManager *)fileManager{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSString *)storageFilePath{
    if (!_storageFilePath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory=[paths objectAtIndex:0];
        _storageFilePath = [documentsDirectory stringByAppendingPathComponent:@"urls"];
    }
    return _storageFilePath;
}
- (NSMutableArray *)urls{
    if (!_urls) {
        // try read from disk
        if ([self.fileManager fileExistsAtPath:self.storageFilePath]) {
            NSData *data = [NSData dataWithContentsOfFile:self.storageFilePath];
            _urls = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        } else {
            _urls = [NSMutableArray array];
            [_urls addObject:@"http://m.taobao.com"];
        }
    }
    return _urls;
}

#pragma mark - LifeCycle
+ (URLManager *)shareManager{
    if (!s_instance) {
        s_instance = [[URLManager alloc] init];
    }
    return s_instance;
}

#pragma mark - Actions
- (BOOL)storeToDisk{
    if (_urls && [_urls count] > 0) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_urls];
        if ([data writeToFile:self.storageFilePath atomically:YES]) {
            return YES;
        }
    }
    return NO;
}

- (void)addUrl:(NSString *)url{
    if (url) {
        [self.urls insertObject:url atIndex:0];
    }
}

- (void)removeUrl:(NSString *)url{
    if ([self.urls indexOfObject:url] != NSNotFound) {
        [self.urls removeObject:url];
    }
}

@end
