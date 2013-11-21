//
//  UIColor+Hex.h
//  YaoBaVersion01
//
//  Created by Hejun.lhj on 12-9-3.
//  Copyright (c) 2012年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;
@end
