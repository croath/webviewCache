//
//  ReportDetailViewController.h
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    resultDetailType,
    responseTimeType
}ReportDetailType;

@interface ReportDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, assign)ReportDetailType detailType;

+ (ReportDetailViewController *)detailViewController;

@end
