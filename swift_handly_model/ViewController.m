//
//  ViewController.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/2.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import "ViewController.h"
#import "AFManager.h"
#import "swift_handly_model-Swift.h"
#import "Data_read_OC.h"
#import "TestModel_OC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://app.saike.com/index.php?c=scene&m=getsceneinfo&page=1&platform=ios&sub_type=1&type=3&user_token=MTAwMDAwMDM0OF9iZjQ3MTMyZTJiZTcwYjEzNDFjMzY1YjA5NTA3MjI2MF8xNTI1MjQxMjYwX2lvc181LjcuMTdfMTgwMDA%3D&version=5.7.17";

    [AFManager Get_ManagerURl:urlString para:nil view:self.view compla:^(id data, BOOL isSuccess) {
        
        //swift数据解析
//        if (isSuccess && [Data_Read data_typeWithData:data] == 2) {
//            TestModel *model = (TestModel *)data;
//            NSLog(@"-------------------%@", model.title);
//            NSLog(@"-----+++++++++-----%@", model.base.userprovince);
//
//            for (ActionModel *actionModel in model.actionlist) {
//                NSLog(@"-----==========-----%@", actionModel.aname);
//            }
//        }
        //OC数据解析
        if (isSuccess && [Data_read_OC data_type:data] == 2) {
            TestModel_OC *model = (TestModel_OC *)data;
            NSLog(@"%@", model.title);
            NSLog(@"%@", model.base.userprovince);
            for (ActionModel_OC *actionModel in model.actionlist) {
                NSLog(@"%@", actionModel.aicon);
            }
        }
        
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    Test_ViewController *vc = [[Test_ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
