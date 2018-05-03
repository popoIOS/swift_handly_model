//
//  Data_read_OC.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import "Data_read_OC.h"
#import "TestModel_OC.h"

@interface OutDataModel : NSObject

@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,assign) id data;

@end

@implementation OutDataModel
@end

@implementation Data_read_OC

+(void)JSON_DATA_READ:(id)data compla:(void(^)(BOOL is_success ,id success_data))compla {
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        OutDataModel * outdata = [OutDataModel mj_objectWithKeyValues:data];
        if (outdata.status == 10000) {

            [Data_read_OC deal_into_data:outdata.data result:^(id succe_data) {
                compla(YES,succe_data);
            }];

        }else{
            compla(NO,nil);
            NSLog(@"请求失败");
        }
    }
}

+(void)deal_into_data:(id)data result:(void(^)(id succe_data))result {
    
    if ([data isKindOfClass:[NSDictionary class]]) {
       
        [TestModel_OC mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"actionlist":@"ActionModel_OC"};
        }];
        TestModel_OC *model = [TestModel_OC mj_objectWithKeyValues:data];
        result(model);
        
    }else if ([data isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr = [NSMutableArray array];
        for (id i in arr) {
            TestModel_OC *model = [TestModel_OC mj_objectWithKeyValues:i];
            [arr addObject:model];
        }
        result(arr);
    }
}

//判断整合之后的数据类型 1数组  2TestModel  3其他的
+(NSInteger)data_type:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        
        return 1;
        
    }else if ([data isKindOfClass:[TestModel_OC class]]) {
        
        return 2;
        
    }else{
        
        return 3;
        
    }
}
@end
