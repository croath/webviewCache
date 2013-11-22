//
//  MJURLProtocol.m
//  h5test
//
//  Created by 芈峮 on 13-11-15.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//



#import "MJURLProtocol.h"
#import "AllpageFlow.h"
#import "Util.h"
#import "ActionsView.h"
#import "FunctionTester.h"
#import "Level.h"

@interface MJURLProtocol () // <NSURLConnectionDelegate, NSURLConnectionDataDelegate> iOS5-only
@property (nonatomic, readwrite, strong) NSURLConnection *connection;
@property (nonatomic, readwrite, strong) NSMutableData *data;
@property (nonatomic, readwrite, strong) NSURLResponse *response;
@end

static NSString *MJURLHeader = @"mijunHeader";

static NSDate * lastReceiveDataTime;


@implementation MJURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    // only handle http requests we haven't marked with our header.
    if ([[[request URL] scheme] isEqualToString:@"http"] || [[[request URL] scheme] isEqualToString:@"https"] ) {
        if ([request valueForHTTPHeaderField:MJURLHeader] == nil) {
            NSString * urlString =[[request URL] absoluteString];
            NSRange  jpgrang = [urlString rangeOfString:@"jpg" options:NSCaseInsensitiveSearch];
            ActionType type = [Level shareInstance].actionType;
            if (jpgrang.location != NSNotFound) {
                NSLog(@"url=====>%@",[[request URL]absoluteString]);
                switch (type) {
                    case q90Type:
                        if ([urlString rangeOfString:@"q90" options:NSCaseInsensitiveSearch].location == NSNotFound) {
                            [FunctionTester shareInstance].canTestPassed = NO;
                            NSString * url = [[request URL] absoluteString];
                            [[FunctionTester shareInstance].failResults addObject:url];
                        }
                        break;
                    case q75Type:
                        if ([urlString rangeOfString:@"q75" options:NSCaseInsensitiveSearch].location == NSNotFound) {
                            [FunctionTester shareInstance].canTestPassed = NO;
                            NSString * url = [[request URL] absoluteString];
                            [[FunctionTester shareInstance].failResults addObject:url];
                        }
                        break;
                    case originalType:
                        break;
                        
                    default:
                        [FunctionTester shareInstance].canTestPassed = NO;
                        [[FunctionTester shareInstance].failResults addObject:@"测试类型没有拿到"];
                        break;
                }
            }
            return YES;
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
    [AllpageFlow shareInstance].pagesFlow = [AllpageFlow shareInstance].pagesFlow + [data length];
    NSLog(@"liuliang=====>%ld",[AllpageFlow shareInstance].pagesFlow);
}

- (void)startLoading
{
    NSMutableURLRequest * connectionRequest = [[self request] mutableCopy];
    [connectionRequest setValue:@"" forHTTPHeaderField:MJURLHeader];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:connectionRequest
                                                                delegate:self];
    [self setConnection:connection];
    
}

- (void)stopLoading
{
    [[self connection] cancel];
}

// NSURLConnection delegates (generally we pass these on to our client)

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    if (response != nil) {
        NSMutableURLRequest *redirectableRequest =
#if WORKAROUND_MUTABLE_COPY_LEAK
        [request mutableCopyWorkaround];
#else
        [request mutableCopy];
#endif
        // We need to remove our header so we know to handle this request and cache it.
        // There are 3 requests in flight: the outside request, which we handled, the internal request,
        // which we marked with our header, and the redirectableRequest, which we're modifying here.
        // The redirectable request will cause a new outside request from the NSURLProtocolClient, which
        // must not be marked with our header.
        [redirectableRequest setValue:nil forHTTPHeaderField:MJURLHeader];
        
        [[self client] URLProtocol:self wasRedirectedToRequest:redirectableRequest redirectResponse:response];
        return redirectableRequest;
    } else {
        return request;
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[self client] URLProtocol:self didFailWithError:error];
    [self setConnection:nil];
    [self setData:nil];
    [self setResponse:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self setResponse:response];
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[self client] URLProtocolDidFinishLoading:self];
    
    [self setConnection:nil];
    [self setData:nil];
    [self setResponse:nil];
}


@end
