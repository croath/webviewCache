//
//  Util.m
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "Util.h"

#import  "ActionsView.h"
#import "TestViewController.h"

@implementation Util

+ (UIWindow *)topWindow
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    return nil;
}

+ (ActionType)getActionType
{
    if ([[Util topWindow].rootViewController isKindOfClass:[TestViewController class]]) {
        TestViewController * vc = (TestViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        return vc.type;
    }
    return -1;
    
}

@end
