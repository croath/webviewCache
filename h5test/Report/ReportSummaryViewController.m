//
//  ReportSummaryViewController.m
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ReportSummaryViewController.h"
#import "AllpageFlow.h"
#import "ReportDetailViewController.h"
#import "FunctionTester.h"
#import "ResponseTime.h"

@interface ReportSummaryViewController ()
{
    ReportDetailType _type;
}
@end

@implementation ReportSummaryViewController
@synthesize totalFlowLabel = _totalFlowLabel, testResultLabel = _testResultLabel, averageResponseLabel = _averageResponseLabel;

+ (ReportSummaryViewController *)summaryViewController{
    ReportSummaryViewController
    *controller = (ReportSummaryViewController*)[[ReportSummaryViewController alloc] initWithNibName:@"ReportSummaryView" bundle:nil];
    return controller;
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
    if ([FunctionTester shareInstance].canTestPassed) {
        self.testResultLabel.text = @"成功";
        self.testResultLabel.textColor = [UIColor greenColor];
    } else {
        self.testResultLabel.text = @"失败";
        self.testResultLabel.textColor = [UIColor redColor];
    }
    self.totalFlowLabel.text = [[AllpageFlow shareInstance] getAllFlows];
    self.averageResponseLabel.text = [[ResponseTime shareInstance] averageTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resultDetail:(id)sender {
    [self gotoDetail:resultDetailType];
}

- (IBAction)responseDetail:(id)sender {
    [self gotoDetail:responseTimeType];
}

- (void)gotoDetail:(ReportDetailType)type{
    _type = type;
    [self performSegueWithIdentifier:@"gotoReportDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"gotoReportDetail"]) {
        ReportDetailViewController *controller = segue.destinationViewController;
        controller.detailType = _type;
    }
}
@end
