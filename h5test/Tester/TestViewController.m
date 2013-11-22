//
//  ViewController.m
//  h5test
//
//  Created by 芈峮 on 13-11-15.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "TestViewController.h"
#import "TBMBProgressHUD.h"
#import "ReportSummaryViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"查看结果" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(report:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
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
    [self loadPages];
    
}

- (void) loadPages
{
    for (NSString * url in _urls) {
        
        NSString * urlpp;
        
        if (_type == q90Type) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=NO"];
        }
        if (_type == q75Type) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=YES"];
        }
        if (_type == originalType) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=originalType"];
        }
        
        
        [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlpp]]];
        
        //[NSThread sleepForTimeInterval:5];
    }
    
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
	if ([[[_request URL]absoluteString]rangeOfString:@"?getStatus"].location != NSNotFound) {
        _currentTimeObj = [[ResponseTimeObj alloc] initWithUrl:[[_request URL] absoluteString]];
        _currentTimeObj.beforeLoadTime = [NSDate date];
        [[ResponseTime shareInstance].pageResponseTime addObject:_currentTimeObj];
    }
    [TBMBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	_currentTimeObj.afterLoadTime = [NSDate date];
    [TBMBProgressHUD hideHUDForView:self.view animated:YES];
    
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

#pragma mark - Action;
- (void)report:(UIButton *)sender{
    [self performSegueWithIdentifier:@"gotoReportSummary" sender:self];
}

@end
