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
        NSInteger len = [urlString length];
        NSRange  jpgrang = [urlString rangeOfString:@"jpg" options:NSCaseInsensitiveSearch];
        NSRange  pngrang = [urlString rangeOfString:@"png" options:NSCaseInsensitiveSearch];
        NSRange  q75rang = [urlString rangeOfString:@"q75" options:NSCaseInsensitiveSearch];
        NSRange  q90rang = [urlString rangeOfString:@"q90" options:NSCaseInsensitiveSearch];
        if (jpgrang.location < len || pngrang.location < len) {
            if (q75rang.location < len || q90rang.location < len) {
                NSLog(@"url=======>%@",urlString);
            }
            
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
