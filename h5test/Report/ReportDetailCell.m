//
//  ReportDetailCell.m
//  h5test
//
//  Created by lihejun on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ReportDetailCell.h"

@interface ReportDetailCell()
{
    CGRect titleFrame;
    CGRect detailFrame;
}
@end

@implementation ReportDetailCell
@synthesize titleLabel = _titleLabel, detailLabel = _detailLabel;
@synthesize type = _type;

+ (ReportDetailCell *)detailCell{
    ReportDetailCell *cell = (ReportDetailCell *)[[[NSBundle mainBundle] loadNibNamed:@"ReportDetailCellView" owner:self options:Nil] objectAtIndex:0];
    return cell;
}

- (void)awakeFromNib{
    titleFrame = self.titleLabel.frame;
    detailFrame = self.detailLabel.frame;
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

- (void)setType:(ReportDetailType)type{
    if (_type != type) {
        _type = type;
        if (type == resultDetailType) {
            CGRect r = self.titleLabel.frame;
            r.size.width += detailFrame.size.width;
            self.titleLabel.frame = r;
        } else {
            self.titleLabel.frame = titleFrame;
            self.detailLabel.frame = detailFrame;
        }
    }
}

@end
