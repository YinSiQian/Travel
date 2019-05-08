//
//  SQDeviceMsg.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQDeviceMsg.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>

@implementation SQDeviceMsg

+(NSDictionary *)getDeviceMsg{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    UIDevice *device = [UIDevice currentDevice];
    NSString *name = device.name;       //获取设备所有者的名称
    NSString *model = [self getCurrentDeviceModel];      //获取设备的类别
    //    NSString *type = device.localizedModel; //获取本地化版本
    NSString *systemName = device.systemName;   //获取当前运行的系统
    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];//获取当前app版本
    [dict setValue:name forKey:@"DeviceName"];
    [dict setValue:model forKey:@"DeviceModel"];
    [dict setValue:@"ios" forKey:@"DeviceType"];
    [dict setValue:[NSString stringWithFormat:@"%@ %@",systemName,systemVersion] forKey:@"SystemVersion"];
    [dict setValue:appVersion forKey:@"AppVersion"];
//    [dict setValue:VersionNum forKey:@"AppVersionInt"];
    
//    [dict setValue:[self getCurrentNetworkStatus] forKey:@"NetworkType"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"openTime"] forKey:@"AppInstallTime"];
//    if ([TMUserModel shared].isLogin) {
//        [dict setValue: [TMUserModel shared].accessToken forKey:@"accessToken"];
//        [dict setValue:[NSString stringWithFormat:@"%@", [TMUserModel shared].uid] forKey:@"memberId"];
//    } else {
//        [dict setValue:@"" forKey:@"accessToken"];
//        [dict setValue:@"" forKey:@"memberId"];
//    }
    return [dict copy];
}

+(NSString *)getDeviceName{
    return [UIDevice currentDevice].name;
}

+(NSString *)getDeviceModel {
    return [self getCurrentDeviceModel];
}

+(NSString *)getDeviceType{
    return [UIDevice currentDevice].localizedModel;
}

+(NSString *)getSystemVersion{
    return [NSString stringWithFormat:@"%@ %@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
}

+(NSString *)getAppVersion{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+(NSString *)getAPP_VERSION_INT{
    return @"46";
}

//+(NSString *)getNetwork_type {
//    return [self getCurrentNetworkStatus];
//}

+ (NSString *)getCurrentDeviceModel {
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
    
    //iPhone
    
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
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1633/A1688/A1691/A1700)";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE (A1662/A1723/A1724)";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7 (A1660/A1679/A1680)";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus (A1661/A1685/A1686)";
    
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7 (A1778)";
    
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus (A1784)";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8 (A1863/A1906/A1907)";
    
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus (A1864/A1898/A1899)";
    
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8 (A1905)";
    
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus (A1897)";
    
    if ([platform isEqualToString:@"iPhone10,6"] || [platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) {
        return @"iPhone XS";
    }
    
    if ([platform isEqualToString:@"iPhone11,6"] || [platform isEqualToString:@"iPhone11,4"]) {
        return @"iPhone XS Max";
    }
    
    if ([platform isEqualToString:@"iPhone11,8"]) {
        return @"iPhone XR";
    }
    
    //iPod Touch
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch (A1213)";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G (A1574)";
    
    
    
    //iPad
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    
    
    //iPad Air
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2 (A1566)";
    
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2 (A1567)";
    
    
    
    //iPad mini
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini 1G (A1432)";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad mini 1G (A1454)";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad mini 2 (A1489)";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad mini 2 (A1490)";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad mini 2 (A1491)";
    
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad mini 3 (A1599)";
    
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad mini 3 (A1600)";
    
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad mini 3 (A1601)";
    
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4 (A1538)";
    
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4 (A1550)";
    
    
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

//+ (NSString *)getCurrentNetworkStatus {
//    
//    Reachability *conn = [Reachability reachabilityForInternetConnection];
//    NetworkStatus status = [conn currentReachabilityStatus];
//    switch (status){
//        case ReachableViaWiFi:
//            return @"WIFI";
//            break;
//        case ReachableViaWWAN:
//            return @"3G/4G";
//            break;
//        case NotReachable:
//            return @"没有网络";
//            break;
//        default:
//            return @"";
//            break;
//    }
//    
//}

@end
