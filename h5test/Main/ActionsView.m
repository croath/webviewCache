//
//  ActionsView.m
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "ActionsView.h"
#import "UIColor+Hex.h"

@implementation ActionsView
@synthesize type = _type, observer = _observer;
@synthesize typeSegements = _typeSegements;

#pragma mark - Getters
- (ActionType)type{
    _type = self.typeSegements.selectedSegmentIndex;
    return _type;
}

#pragma mark - Setters
- (void)setType:(ActionType)type{
    _type = type;
    self.typeSegements.selectedSegmentIndex = _type;
}

+ (ActionsView *)actionsView:(id)observer{
    ActionsView *view = (ActionsView *)[[[NSBundle mainBundle] loadNibNamed:@"ActionsViewInXib" owner:self options:nil] objectAtIndex:0];
    view.observer = observer;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (IBAction)allSend:(id)sender {
    if ([_observer respondsToSelector:@selector(doSend)]) {
        [_observer performSelector:@selector(doSend) withObject:nil];
    }
}

@end
