//
//  TestModel_OC.h
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel_OC : NSObject
@property (nonatomic,copy) NSString *userprovince;
@property (nonatomic,copy) NSString *coverurl;
@end

@interface ActionModel_OC : NSObject
@property (nonatomic,copy) NSString *aicon;
@end


@interface TestModel_OC : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSMutableArray<ActionModel_OC *> *actionlist;
@property (nonatomic,strong) BaseModel_OC *base;

@end

