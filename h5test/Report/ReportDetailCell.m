//
//  ReportDetailCell.m
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ReportDetailCell.h"

@implementation ReportDetailCell
@synthesize titleLabel = _titleLabel, detailLabel = _detailLabel;

+ (ReportDetailCell *)detailCell{
    ReportDetailCell *cell = (ReportDetailCell *)[[[NSBundle mainBundle] loadNibNamed:@"ReportDetailCellView" owner:self options:Nil] objectAtIndex:0];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
