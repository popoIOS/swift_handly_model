//
//  Data_read_OC.h
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
@interface Data_read_OC : NSObject

//解析大类（data）
+(void)JSON_DATA_READ:(id)data compla:(void(^)(BOOL is_success ,id success_data))compla;

//解析小类（动作列表）
+(void)deal_into_data:(id)data result:(void(^)(id succe_data))result;
@end
