//
//  SQUserModel.m
//  Travel
//
//  Created by ABJ on 2019/5/9.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQUserModel.h"

@implementation SQUserModel

+ (instancetype)shared {
    static SQUserModel *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [SQUserModel new];
        NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        if (data) {
            [_shared initWithDict:data];
        }
    });
    return _shared;
}

- (void)initWithDict:(NSDictionary *)dict {
    if (dict) {
        self.name = dict[@"username"];
        self.phoneNum = [NSString stringWithFormat:@"%@", dict[@"usermobile"]];
        self.accessToken = dict[@"accessToken"];
        self.uid = [NSString stringWithFormat:@"%@", dict[@"id"]];
        self.icon = [NSString stringWithFormat:@"%@", dict[@"icon"]];
        [self syncDataWithData:dict];
    }
}

- (void)syncDataWithData:(NSDictionary *)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clear {
    self.name = @"";
    self.phoneNum = @"";
    self.accessToken = @"";
    self.uid = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin {
    return self.accessToken && ![self.accessToken isEqualToString:@""];
}

@end
