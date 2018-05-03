//
//  PubMethods.h
//  swift_handly_model
//
//  Created by ydz on 2018/5/3.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubMethods : NSObject

#pragma -mark- =================== 登陆判断 =======================
//md5加密
+(NSString *)md5Digest:(NSString *)digestStr;
//判断邮箱
+(BOOL)isValidateEmail:(NSString *)email;
//判断手机号码
+(BOOL)isValidatePhone:(NSString *)phone;
//  身份证号
+ (BOOL)isValidateCard:(NSString *)identityCard;
// 银行卡
+ (BOOL)isValidateBankCardNumber: (NSString *)bankCardNumber;
// 银行卡后四位
+ (BOOL)isvalidateBankCardLastNumber: (NSString *)bankCardNumber;

#pragma -mark- =================== 字符串 =======================
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
//得到当前时间
+(NSString*)getNowTime;
//把时间转化为2012-12-13
+(NSString*)getDate:(NSDate*)date;
// 获得date
+(NSDate*)getStrToDate:(NSString*)uiDate;

//获得设备信息
+(NSString *)getCurrentDeviceModel;
//打印设备信息
+(void )nslogCurrentDevice;
//获得程序信息
+(NSString *)programInformation:(NSString*)str;
//判断是否是iPhone X
+(BOOL)deviceIphoneX;
#pragma -mark- =================== 清除缓存用到 =======================
//单个文件的大小
+(long long) fileSizeAtPath:(NSString*) filePath;
//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath;
//缓存大小
+(float)theCacheSize;
//清除缓存
+(void)clearTheCache;
//查看沙盒信息
+(void)takeInform;
+(void)changePicName;//文件改名字
#pragma -mark- =================== UI弹出框 =======================
//黑色加载进度条
+(void)showMBProgress:(NSString*)str
             withView:(UIView*)view;
//黑色加载进度条 dismiss
+(void)dismissMBProgressWithView:(UIView*)view;
//自动消失的全屏提示
+(void)showAudioDismisstext:(NSString*)str;

//弹出提示框1
+(void)alertViewWithTitle:(NSString*)title
              contentText:(NSString*)contStr
          leftButtonTitle:(NSString*)leftstr
         rightButtonTitle:(NSString*)rightstr
                   finish:(void (^)(NSInteger index))block;

//弹出提示框2
+(void)sheetWithTitle:(NSString*)title
              oneText:(NSString*)oneText
              twoText:(NSString*)twoText
               finish:(void (^)(NSInteger index))block;
//截取view为图片
+ (UIImage*) imageWithUIView:(UIView*) view;
#pragma -mark- =================== UILabel用到 =======================
//富文本
+(NSMutableAttributedString *)attributieAllText:(NSString*)allText changeText:(NSString *)changeText dic_text:(NSDictionary *)dic_text;
//计算lable大小
+(CGSize )getTextRectSize:(NSString*)str font:(NSInteger)font textSize:(CGSize)textSize;
#pragma -mark- =================== UIImage用到 =======================
//快速图片拉伸
+(UIImage*)imageName:(NSString*)name
       WithCapInsets:(UIEdgeInsets)capInsets
        resizingMode:(UIImageResizingMode)resizingMode;
@end
