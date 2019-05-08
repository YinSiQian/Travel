//
//  SQMacros.h
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#ifndef SQMacros_h
#define SQMacros_h

#define kScreen_width           [UIScreen mainScreen].bounds.size.width
#define kScreen_height          [UIScreen mainScreen].bounds.size.height

#define host                    @"http://112.74.162.15:8090/"
#define sq_url_combine(path)    [NSString stringWithFormat:@"%@%@", host, path]

///color

#define kThemeColor             [UIColor colorWithHexString:@"05b14b"]
#define kLightDarkColor         [UIColor colorWithHexString:@"a9a9a9" alpha:1.0]

#endif /* SQMacros_h */
