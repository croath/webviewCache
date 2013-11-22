//
//  EditViewController.m
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "EditViewController.h"
#import "URLManager.h"
#import "UIColor+Hex.h"

@interface EditViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UITextView *textView;
@end

@implementation EditViewController
@synthesize textView = _textView;

#pragma mark - Getter
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
        self.textView.layer.masksToBounds = NO;
        self.textView.layer.shadowOffset = CGSizeMake(0, 1);
        self.textView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.textView.layer.shadowRadius = 1;
        self.textView.layer.shadowOpacity = 0.15;
        self.textView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.textView.bounds].CGPath;
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.delegate = self;
    }
    return _textView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
}

- (void)viewWillAppear:(BOOL)animated{
    CGRect r = self.textView.frame;
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        r.origin.y = 20 + 44;
    }
    self.textView.frame = r;
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    [[URLManager shareManager] addUrl:self.textView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
