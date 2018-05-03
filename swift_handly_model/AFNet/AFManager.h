//
//  AFManager.h
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFManager : NSObject

+(void)Get_ManagerURl:(NSString *)url para:(NSDictionary *)param view:(UIView *)showView compla:(void(^)(id data,BOOL isSuccess))success fail:(void(^)(NSError  *error))fail;

@end
