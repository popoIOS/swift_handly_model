//
//  AFManager.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#define AFFaileTip @"网络连接失败"
#define AFWaitingTip @"请稍等..."

#import "AFManager.h"
#import "AFNetworking.h"


@implementation AFManager

#pragma mark---GET请求
+(void)GetRequestURLString:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  @"text/plain" ,nil];
    [manager.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = [url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [mdic setObject:@"ios" forKey:@"platform"];
    [mdic setObject:[PubMethods programInformation:@"CFBundleShortVersionString"] forKey:@"version"];
    
    if (view) {
        [PubMethods showMBProgress:AFWaitingTip withView:view];
    }
    
    [manager GET:str parameters:mdic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PubMethods dismissMBProgressWithView:view];
        //swift数据解析
        //        [Data_Read JSON_DATAWithData:responseObject result:^(BOOL isSucc, id _Nullable data) {
        //            success(data,isSucc);
        //        }];
        //OC数据解析
        [Data_read_OC JSON_DATA_READ:responseObject compla:^(BOOL is_success, id success_data) {
            success(is_success,success_data);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PubMethods showAudioDismisstext:AFFaileTip];
        [PubMethods dismissMBProgressWithView:view];
        falier(error);
    }];

}
#pragma mark---POST请求
+(void)PostRequestURLString:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  @"text/plain" ,nil];
    [manager.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = [url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [mdic setObject:@"ios" forKey:@"platform"];
    [mdic setObject:[PubMethods programInformation:@"CFBundleShortVersionString"] forKey:@"version"];
    
    if (view) {
        [PubMethods showMBProgress:AFWaitingTip withView:view];
    }
    [manager POST:str parameters:mdic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PubMethods dismissMBProgressWithView:view];
        //swift数据解析
        //        [Data_Read JSON_DATAWithData:responseObject result:^(BOOL isSucc, id _Nullable data) {
        //            success(data,isSucc);
        //        }];
        //OC数据解析
        [Data_read_OC JSON_DATA_READ:responseObject compla:^(BOOL is_success, id success_data) {
            success(is_success,success_data);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PubMethods showAudioDismisstext:AFFaileTip];
        [PubMethods dismissMBProgressWithView:view];
        falier(error);
    }];
}

#pragma mark---POST上传文件
+(void)PostUpLoadingImage:(NSString *)url parameter:(NSDictionary *)dic showProgress:(UIView *)view Image:(NSArray *)arrayImage success:(void(^)(BOOL isSuccess,id data))success Faliuer:(void(^)(NSError  *error))falier{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  @"text/plain" ,nil];
    [manager.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = [url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [mdic setObject:@"ios" forKey:@"platform"];
    [mdic setObject:[PubMethods programInformation:@"CFBundleShortVersionString"] forKey:@"version"];

    if (view) {
        [PubMethods showMBProgress:@"请稍等..." withView:view];
    }
    [manager POST:str parameters:mdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (arrayImage.count>0) {
            id da = arrayImage[0];
            if ([da isKindOfClass:[NSURL class]]) {
                //上传视频和图片
                NSURL *viedo_url = (NSURL *)da;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[formatter stringFromDate:[NSDate date]]];
                NSError *error;
                BOOL success = [formData appendPartWithFileURL:viedo_url name:@"viedo_file" fileName:fileName mimeType:@"video/mp4" error:&error];
                if (arrayImage.count > 1) {
                    UIImage *image = (UIImage *)arrayImage[1];
                    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
                    NSString *fileName_image = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
                    [formData appendPartWithFileData:imageData name:@"image_file" fileName:fileName_image mimeType:@"image/png"];
                }
                if (!success) {
                    NSLog(@"+++++++++++appendPartWithFileURL error: %@", error);
                }
            }else if ([da isKindOfClass:[UIImage class]]) {
                //上传图片
                NSInteger imgCount = 0;
                for (UIImage *image in arrayImage) {
                    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
                    imgCount++;
                }
            }else  if ([da isKindOfClass:[NSString class]]) {
                //上传音频
                NSString *voice_str = (NSString *)da;
                NSURL * voice_url = [NSURL fileURLWithPath:voice_str];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *fileName = [NSString stringWithFormat:@"%@.mp3",[formatter stringFromDate:[NSDate date]]];
                NSError *error;
                BOOL success = [formData appendPartWithFileURL:voice_url name:@"file" fileName:fileName mimeType:@"audio/mp3" error:&error];
                if (!success) {
                    NSLog(@"appendPartWithFileURL error: %@", error);
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PubMethods dismissMBProgressWithView:view];
        //swift数据解析
        //        [Data_Read JSON_DATAWithData:responseObject result:^(BOOL isSucc, id _Nullable data) {
        //            success(data,isSucc);
        //        }];
        //OC数据解析
        [Data_read_OC JSON_DATA_READ:responseObject compla:^(BOOL is_success, id success_data) {
            success(is_success,success_data);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PubMethods showAudioDismisstext:AFFaileTip];
        [PubMethods dismissMBProgressWithView:view];
        falier(error);
    }];
}
@end
