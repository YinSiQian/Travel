//
//  SQCalendarView.h
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQCalendarView : UIView<FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, copy) void(^complectionHandler)(NSString *date);

@property (nonatomic, strong) FSCalendar *calendar;

//@property (nonatomic, strong) TMCourseCalendarCell *lastSelectedCell;

@property (nonatomic, strong) NSCalendar *gregorian;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSDate *minimumDate;

@property (nonatomic, strong) NSDate *maximumDate;

@property (nonatomic, strong) NSDate *lastSelectedDate;

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
