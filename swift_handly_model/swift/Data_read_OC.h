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

+(void)JSON_DATA_READ:(id)data compla:(void(^)(BOOL is_success ,id success_data))compla;
+(NSInteger)data_type:(id)data;

@end
