//
//  MainCell.m
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "MainCell.h"
#import "UIColor+Hex.h"

@implementation MainCell
@synthesize title = _title;

+ (MainCell *)mainCell{
    MainCell *cell = (MainCell *)[[[NSBundle mainBundle] loadNibNamed:@"MainCellInXib" owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.title.textColor = [UIColor colorWithHex:0x666666];
    self.title.font = [UIFont systemFontOfSize:15.0f];
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
