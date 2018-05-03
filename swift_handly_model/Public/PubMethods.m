//
//  PubMethods.m
//  swift_handly_model
//
//  Created by ydz on 2018/5/3.
//  Copyright © 2018年 yzd. All rights reserved.
//

#import "PubMethods.h"
#import "MBProgressHUD.h"
#include <sys/types.h>//设备型号
#include <sys/sysctl.h>//设备型号
#import <CommonCrypto/CommonDigest.h>//md5加密
#import "UIAlertView+Fast.h"
#import "UIActionSheet+Fast.h"
@implementation PubMethods

static PubMethods *pub_meth;

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pub_meth = [[self alloc] init];
    });
    return pub_meth;
}

#pragma -mark- =================== 登陆判断 =======================
#pragma -mark md5加密
+(NSString *)md5Digest:(NSString *)digestStr
{
    const char *cStr = [digestStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}
#pragma -mark 判断邮箱
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma -mark 判断手机号码
+(BOOL)isValidatePhone:(NSString *)phone
{
    NSString *Regex =@"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";//@"(13[0-9]|14[0-9]|15[0-9]|18[0-9])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:phone];
}
#pragma -mark  身份证号
+ (BOOL)isValidateCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
#pragma -mark 银行卡
+ (BOOL)isValidateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
#pragma -mark  银行卡后四位
+ (BOOL)isvalidateBankCardLastNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length != 4) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

#pragma -mark- =================== 字符串 =======================
#pragma -mark 普通字符串转换为十六进制的
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


#pragma -mark 获得系统时间
+(NSString*)getNowTime{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}
#pragma -mark 设定时间
+(NSString*)getDate:(NSDate*)date{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    
    return currentDateStr;
}
#pragma -mark  获得date
+(NSDate*)getStrToDate:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}

#pragma -mark 获得设备型号
+(NSString *)getCurrentDeviceModel
{
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    
    
    
    return platform;
}
#pragma -mark 打印设备信息
+(void)nslogCurrentDevice{
//    NSString *platform=[PubMethods getCurrentDeviceModel];
//    UIDevice *device=[UIDevice currentDevice];
//    CLog(@"  ");
//    CLog(@"======================设备信息======================");
//    CLog(@"  ");
//    CLog(@"设备所有者的名称----   %@",device.name);
//    CLog(@"设备的类别---------   %@",device.model);
//    CLog(@"设备的的本地版本----  %@",device.localizedModel);
//    CLog(@"设备运行的系统-----    %@",device.systemName);
//    CLog(@"当前系统的版本-----    %@",device.systemVersion);
//    CLog(@"设备识别码--------    %@",device.identifierForVendor.UUIDString);
//    CLog(@"当前设备型号:%@",platform);
//    CLog(@"沙盒路径：%@",NSHomeDirectory());
//    CLog(@"  ");
//    CLog(@"=================================================");
//    CLog(@"  ");
}
#pragma -mark 获得程序信息
+(NSString *)programInformation:(NSString*)str{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CLog(@"%@",(infoDictionary));
    //  app名称CFBundleDisplayName
    //  app版本CFBundleShortVersionString
    //  app build版本 CFBundleVersion
    NSString *appStr = [infoDictionary objectForKey:str];
    return appStr;
}
#pragma -mark 判断是否是iphoneX
+(BOOL)deviceIphoneX{
    return [[UIApplication sharedApplication] statusBarFrame].size.height > 20;
}

#pragma -mark- =================== 清除缓存用到 =======================
#pragma -mark 单个文件的大小
+(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
#pragma -mark 遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [PubMethods fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
#pragma -mark 清除大小
+(float)theCacheSize{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    return   [PubMethods folderSizeAtPath:cachPath];
}
#pragma -mark 清除缓存
+(void)clearTheCache{
    //清除缓存
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"缓存文件大小%f",[PubMethods folderSizeAtPath:cachPath]);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    NSLog(@"缓存文件个数 :%lu",(unsigned long)[files count]);
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}
#pragma -mark 查看
+(void)takeInform{
    //得到完整的文件名
    NSString *filename=@"/Users/xjkj/Desktop/face.plist";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:100];
    
    for (int i=1; i<86; i++)
    {
        NSString *str=[NSString stringWithFormat:@"%d",i];
        if (str.length==1)
        {
            str=[NSString stringWithFormat:@"00%d",i];
        }else
        {
            str=[NSString stringWithFormat:@"0%d",i];
        }
        
        NSString *value=[NSString stringWithFormat:@"<%@>",str];
        
        [dic setObject:str forKey:value];
    }
    //输入写入
    [dic writeToFile:filename atomically:YES];
    
    //那怎么证明我的数据写入了呢？读出来看看
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"%@", data1);
    
}
+(void)changePicName{
    //得到完整的文件名
    NSString *filename=@"/Users/huangjingjincoolman/Desktop/部件/腰珠";
    // NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表/Users/huangjingjincoolman/Desktop/部件/弟子珠/dizizhu_item02.png
    
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:filename error:&error];
    
    // 以下这段代码则可以列出给定一个文件夹里的所有子文件夹名
    
    //在上面那段程序中获得的fileList中列出文件夹名
    int i=0;
    for (NSString *file in fileList) {
        NSLog(@"%@",file);
        NSString *newSgtr=[NSString stringWithFormat:@"%@/%@",filename,file];
        UIImage *old=[UIImage imageWithContentsOfFile:newSgtr];
        NSData*  data = UIImagePNGRepresentation(old);
        
        NSString *lastStr=[NSString stringWithFormat:@"/Users/huangjingjincoolman/Desktop/腰珠/yaozhu_%d@2x.png",i];
        
        [data writeToFile:lastStr atomically:YES];
        i++;
    }
}

#pragma -mark- =================== UI弹出框 =======================
#pragma -mark showMBProgress
+(void)showMBProgress:(NSString*)str withView:(UIView*)view{
    
    UIView *new_v = view ? view : [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud=  [[MBProgressHUD alloc] initWithView:new_v];
    [new_v addSubview:hud];
    
    hud.detailsLabel.text = str;
    [hud showAnimated:YES];
}
#pragma -mark MBProgressHUD dismiss
+(void)dismissMBProgressWithView:(UIView*)view{
    
    for (UIView *v in [view subviews])
    {
        if ([v isKindOfClass:[MBProgressHUD class]])
        {
            [v  removeFromSuperview];
        }
    }
}
#pragma -mark  自动消失的全屏提示
+(void)showAudioDismisstext:(NSString*)str{
    //默认两秒消失
    UIView *new_v = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud=  [[MBProgressHUD alloc] initWithView:new_v];
    [new_v sendSubviewToBack:hud];
    hud.offset = CGPointMake(new_v.center.x, 200);
    [new_v addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2];
}

#pragma -mark 提示框1
+(void)alertViewWithTitle:(NSString*)title
              contentText:(NSString*)contStr
          leftButtonTitle:(NSString*)leftstr//nil--0
         rightButtonTitle:(NSString*)rightstr//@"sure"--1
                   finish:(void (^)(NSInteger index))block
{
    UIAlertView *alert;
    alert = [[UIAlertView alloc]initWithTitle:title message:contStr delegate:nil cancelButtonTitle:leftstr otherButtonTitles:rightstr, nil];
    
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {

        if (block) {
            block(buttonIndex);
        }
    }];
}
#pragma -mark 提示框2
+(void)sheetWithTitle:(NSString*)title
              oneText:(NSString*)oneText//0
              twoText:(NSString*)twoText//1
               finish:(void (^)(NSInteger index))block{
    UIActionSheet *sheet;
    sheet=[[UIActionSheet alloc]initWithTitle:title
                                     delegate:nil
                            cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                            otherButtonTitles:oneText,twoText, nil];
    [sheet showActionSheetWithCompleteBlock:^(NSInteger buttonIndex) {

        if (block) {
            block(buttonIndex);
        }
    }];
}

#pragma -mark 截取view为图片
+ (UIImage*) imageWithUIView:(UIView*) view{
    CGSize s = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma -mark- =================== UILabel用到 =======================
#pragma -mark 富文本
+(NSMutableAttributedString *)attributieAllText:(NSString*)allText changeText:(NSString *)changeText dic_text:(NSDictionary *)dic_text{
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:allText];
    [attribute addAttributes:dic_text range:[allText rangeOfString:changeText]];
    return attribute;
}
#pragma -mark 计算文字大小
+(CGSize )getTextRectSize:(NSString*)str font:(NSInteger)font textSize:(CGSize)textSize{
    return [str boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:@(font)} context:nil].size;
}
#pragma -mark- =================== 图片处理 =======================
#pragma -mark 快速图片拉伸
+(UIImage*)imageName:(NSString*)name
       WithCapInsets:(UIEdgeInsets)capInsets
        resizingMode:(UIImageResizingMode)resizingMode{
    
    UIImage *image=[[UIImage imageNamed:name]
                    resizableImageWithCapInsets:capInsets
                    resizingMode:resizingMode];
    
    return image;
}
@end
