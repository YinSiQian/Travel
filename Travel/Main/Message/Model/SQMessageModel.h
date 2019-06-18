//
//  SQMessageModel.h
//  Travel
//
//  Created by yinsiqian on 2019/6/18.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQMessageModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger reply_uid;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) long timestamp;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *userName;


@end

NS_ASSUME_NONNULL_END
