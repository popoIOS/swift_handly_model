//
//  MBHUDManager.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/3.
//  Copyright © 2018年 yzd. All rights reserved.
//

#define LOADINGWAIT @"请稍等..."


#import "MBHUDManager.h"
#import "MBProgressHUD.h"

@implementation MBHUDManager

static MBHUDManager *hudManager;


+(instancetype)shareHUDManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudManager = [[self alloc] init];
    });
    return hudManager;
}



@end
