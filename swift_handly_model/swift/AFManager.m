//
//  AFManager.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import "AFManager.h"
#import "AFNetworking.h"
#import "swift_handly_model-Swift.h"
#import "Data_read_OC.h"

@implementation AFManager

+(void)Get_ManagerURl:(NSString *)url para:(NSDictionary *)param view:(UIView *)showView compla:(void(^)(id data,BOOL isSuccess))success fail:(void(^)(NSError  *error))fail{
    
    
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manger.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];

    [manger GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //swift数据解析
//        [Data_Read JSON_DATAWithData:responseObject result:^(BOOL isSucc, id _Nullable data) {
//            success(data,isSucc);
//        }];
        //OC数据解析
        [Data_read_OC JSON_DATA_READ:responseObject compla:^(BOOL is_success, id success_data) {
            success(success_data,is_success);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        fail(error);
        
        
        NSLog(@"%@",error);
    }];
    
}

@end
