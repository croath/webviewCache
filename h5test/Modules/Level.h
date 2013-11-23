//
//  Level.h
//  h5test
//
//  Created by 芈峮 on 13-11-22.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionsView.h"

static NSString * highLevelKeyWord = @"q90";

static NSString * lowerLevelKeyWord = @"q75";

static NSString * webpKeyWord = @"webp";

static BOOL webpOr = YES;

@interface Level : NSObject

@property (nonatomic, assign) ActionType actionType;

+ (Level *) shareInstance;

@end
