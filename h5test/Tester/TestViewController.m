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
#import "AllpageFlow.h"
#import "ResponseTime.h"
#import "FunctionTester.h"
#import "Level.h"

@interface TestViewController ()

@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL shouldContinue;

@end

@implementation TestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self cleanResult];
    _index = 0;
    _shouldContinue = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"查看结果" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(report:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
	webFrame.size.height -= 40.0;
	self.myWebView.backgroundColor = [UIColor whiteColor];
	self.myWebView.scalesPageToFit = YES;
	self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.myWebView.delegate = self;
	[self.view addSubview:self.myWebView];
    [Level shareInstance].actionType = [self type];
    [self loadPages];
    [NSTimer scheduledTimerWithTimeInterval:8.f target:self selector:@selector(loadPages) userInfo:nil repeats:_shouldContinue];
}

-(void) cleanCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
}


- (void) cleanResult
{
    [ResponseTime shareInstance].pageResponseTime = [[NSMutableArray alloc] init];
    [AllpageFlow shareInstance].pagesFlow = 0;
    [FunctionTester shareInstance].canTestPassed = YES;
    [FunctionTester shareInstance].failResults = [[NSMutableArray alloc] init];
    NSLog(@"clean Result");
}

- (void) loadPages
{
    if (_index < [_urls count]) {
    
        NSString * urlpp;
        NSString * url = [[_urls objectAtIndex:_index] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (_type == highLevels) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=false"];
        }
        if (_type == lowerLevels) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=true"];
        }
        if (_type == _noq) {
            urlpp  = [NSString stringWithFormat:@"%@%@",url,@"?getStatus=_noq"];
        }
        [self cleanCache];
        NSURL *URL = [NSURL URLWithString:urlpp];
        NSURLRequest *req = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:1];
        [_myWebView loadRequest:req];
        [self cleanCache];
        _index++;
    }else{
        [self cleanCache];
        _shouldContinue = NO;
    }
    
}

- (void) viewDidUnload
{
    [self cleanCache];
    _myWebView  = nil;
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
   // [TBMBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	_currentTimeObj.afterLoadTime = [NSDate date];
    //[TBMBProgressHUD hideHUDForView:self.view animated:YES];
    
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
