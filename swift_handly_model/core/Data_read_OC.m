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

            compla(YES,outdata.data);

        }else{
            compla(NO,nil);
            [PubMethods showAudioDismisstext:outdata.desc];
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

@end
