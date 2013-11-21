//
//  ViewController.m
//  h5test
//
//  Created by 芈峮 on 13-11-15.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"WebTitle", @"");
    
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
	webFrame.size.height -= 40.0;
	self.myWebView = [[UIWebView alloc] initWithFrame:webFrame];
	self.myWebView.backgroundColor = [UIColor whiteColor];
	self.myWebView.scalesPageToFit = YES;
	self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.myWebView.delegate = self;
	[self.view addSubview:self.myWebView];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.taobao.com/"]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    _request = request;
    
    return YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
	_beforeLoadTime = [NSDate date];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	_afterLoadTime = [NSDate date];
    NSTimeInterval times = [_afterLoadTime timeIntervalSinceDate:_beforeLoadTime];
    if (![[[_request URL] absoluteString] isEqualToString:@"about:blank"]) {
        NSLog(@"page %@ loading times : %f",[[_request URL]absoluteString],times);
    }
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.myWebView loadHTMLString:errorString baseURL:nil];
}

@end
