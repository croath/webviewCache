//
//  MainCell.h
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

+ (MainCell *)mainCell;

@end
