//
//  SQMacros.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#ifndef SQMacros_h
#define SQMacros_h

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define kScreen_width           [UIScreen mainScreen].bounds.size.width
#define kScreen_height          [UIScreen mainScreen].bounds.size.height

#define host                    @"http://112.74.162.15:8090/"
#define sq_url_combine(path)    [NSString stringWithFormat:@"%@%@", host, path]

///color

#define kThemeColor             [UIColor colorWithHexString:@"0x1890FF"]
#define kLightDarkColor         [UIColor colorWithHexString:@"a9a9a9" alpha:1.0]
#define kMaskColor          [UIColor colorWithHexString:@"282828" alpha:0.8]
#define kDarkBackColor      [UIColor colorWithHexString:@"f7f7f7" alpha:1.0]
#define kSeparatorColor     [UIColor colorWithHexString:@"e6e7e6" alpha:0.8]
#define kBlackColor         [UIColor colorWithHexString:@"282828" alpha:1.0]
#define kDarkGrayColor      [UIColor colorWithHexString:@"737373" alpha:1.0]


#endif /* SQMacros_h */
