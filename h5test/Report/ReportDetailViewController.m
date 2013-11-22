//
//  ReportDetailViewController.m
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "FunctionTester.h"
#import "ResponseTime.h"
#import "ReportDetailCell.h"

@interface ReportDetailViewController ()<UITableViewDataSource>
@end

@implementation ReportDetailViewController
@synthesize contentTableView = _contentTableView, detailType = _detailType;

+ (ReportDetailViewController *)detailViewController{
    ReportDetailViewController *controller = [[ReportDetailViewController alloc] initWithNibName:@"ReportDetailViewControllerInXib" bundle:[NSBundle mainBundle]];
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
    if (self.detailType == resultDetailType) {
        self.title = @"结果详情";
    } else {
        self.title = @"响应时间详情";
    }
    self.contentTableView.dataSource = self;
    [self.contentTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_detailType) {
        case resultDetailType:
            return [[FunctionTester shareInstance].failResults count];
        case responseTimeType:
            return [[ResponseTime shareInstance].pageResponseTime count];
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportDetailCell"];
    if (!cell) {
        cell = [ReportDetailCell detailCell];
    }
    switch (_detailType) {
        case resultDetailType:
            cell.titleLabel.text = [[FunctionTester shareInstance].failResults objectAtIndex:indexPath.row];
            cell.detailLabel.text = @"失败";
            break;
        case responseTimeType:
        {
            ResponseTimeObj *obj = (ResponseTimeObj *)[[ResponseTime shareInstance].pageResponseTime objectAtIndex:0];
            cell.titleLabel.text = obj.url;
            cell.detailLabel.text = [obj getDetailResponseTime];
        }
        default:
            break;
    }
    return cell;
}

@end
