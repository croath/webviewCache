//
//  ReportDetailCell.h
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

+ (ReportDetailCell *)detailCell;

@end
