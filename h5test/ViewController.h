//
//  ViewController.h
//  h5test
//
//  Created by 芈峮 on 13-11-15.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * myWebView;

@property (nonatomic, strong) NSDate * beforeLoadTime;

@property (nonatomic, strong) NSDate * afterLoadTime;

@property (nonatomic, strong) NSURLRequest * request;

@end
