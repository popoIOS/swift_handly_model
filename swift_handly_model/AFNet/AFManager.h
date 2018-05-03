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

//get请求
+(void)GetRequestURLString:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier;

//post请求
+(void)PostRequestURLString:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier;

//上传文件
+(void)PostUpLoadingImage:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view Image:(NSArray *)arrayImage success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier;
@end
