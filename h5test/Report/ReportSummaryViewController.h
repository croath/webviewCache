//
//  ReportSummaryViewController.h
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportSummaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *totalFlowLabel;
@property (weak, nonatomic) IBOutlet UILabel *testResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageResponseLabel;

+ (ReportSummaryViewController *)summaryViewController;

- (IBAction)resultDetail:(id)sender;
- (IBAction)responseDetail:(id)sender;
@end
