//
//  MJURLProtocol.m
//  h5test
//
//  Created by 芈峮 on 13-11-15.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "MJURLProtocol.h"

@implementation MJURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    // only handle http requests we haven't marked with our header.
    if ([[[request URL] scheme] isEqualToString:@"http"] || [[[request URL] scheme] isEqualToString:@"https"] ) {
        NSString * urlString =[[request URL] absoluteString];
        NSRange  jpgrang = [urlString rangeOfString:@"jpg" options:NSCaseInsensitiveSearch];
        NSRange  pngrang = [urlString rangeOfString:@"png" options:NSCaseInsensitiveSearch];
        if (jpgrang.location != 0 || pngrang.location != 0) {
            NSLog(@"url=======>%@",urlString);
        }
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
    NSLog(@"Size:=====>%d",[data length]);
}

@end
