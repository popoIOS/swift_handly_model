//
//  MBHUDManager.h
//  swift_handly_model
//
//  Created by ydz on 2018/5/3.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBHUDManager : NSObject

+(instancetype)shareHUDManager;
-(void)hiddenHUD;

//加载请稍等
-(void)showLoadingMessage;
-(void)showLoadingMessage:(UIView *)view;



@end
