//
//  SQCalendarView.m
//  Travel
//
//  Created by yinsiqian on 2019/5/22.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQCalendarView.h"

@interface SQCalendarView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation SQCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMaskColor;
        [self commonInit];
        [self resetupCommonInit];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    CGFloat safeBottom = [SQHelp isSpecialShapedScreen] ? 34 : 0;
    CGFloat currentHeight = 535 + safeBottom;
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_height, kScreen_width, currentHeight)];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 55)];
    title.text = @"选择日期";
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = kDarkBackColor;
    title.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:title];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.width - 36, (title.height - 36) / 2,  36, 36)];
    [closeBtn setImage:[UIImage imageNamed:@"icon_calendar_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:closeBtn];
    
    
    self.calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, title.height, kScreen_width, self.contentView.height - title.height - safeBottom)];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    self.calendar.pagingEnabled = NO;
    self.calendar.allowsMultipleSelection = YES;
    self.calendar.rowHeight = 80;
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.calendar];
    
    self.calendar.today = [NSDate date];
    self.calendar.firstWeekday = 1;
    
    self.calendar.appearance.headerTitleFont = [UIFont boldSystemFontOfSize:16];
    self.calendar.appearance.headerTitleColor = kBlackColor;
    self.calendar.appearance.weekdayFont = [UIFont systemFontOfSize:15];
    self.calendar.appearance.weekdayTextColor = kBlackColor;
    self.calendar.appearance.headerDateFormat = @"yyyy年MM月";
    self.calendar.appearance.borderRadius = 0;
    self.calendar.appearance.titleFont = [UIFont systemFontOfSize:15];
    
}

- (void)commonInit {
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.minimumDate = [NSDate date];
    NSDateComponents *dateComponents = [self.gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    //设置日为1号
    dateComponents.day = 1;
    //设置月份为后延100个月
    dateComponents.month += 100;
    
    self.maximumDate = [[self.gregorian dateFromComponents:dateComponents] dateByAddingTimeInterval:-1];
    
    self.calendar.accessibilityIdentifier = @"calendar";
}

- (void)resetupCommonInit {
    
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maximumDate;
}

#pragma mark - FSCalendarDelegate

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

//- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
//    TMCourseCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:position];
//    return cell;
//}
//
//- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
//    TMCourseCalendarCell *calendarCell = (TMCourseCalendarCell *)cell;
//    if ([date compare:self.lastSelectedDate] == NSOrderedSame && self.lastSelectedDate) {
//        calendarCell.isSelected = YES;
//        self.lastSelectedCell = (TMCourseCalendarCell *)cell;
//    } else {
//        calendarCell.isSelected = NO;
//        if (([date compare:self.minimumDate] == NSOrderedDescending && [date compare:self.maximumDate] == NSOrderedAscending) || [date compare:self.minimumDate] == NSOrderedSame) {
//            calendarCell.titleLabel.textColor = kBlackColor;
//        } else {
//            calendarCell.titleLabel.textColor = kLightDarkColor;
//        }
//    }
//    if ([self.gregorian isDateInToday:date]) {
//        if (calendarCell.isSelected) {
//            calendarCell.titleLabel.textColor = [UIColor whiteColor];
//        } else {
//            cell.titleLabel.textColor = kGreenColor;
//        }
//    }
//}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if ([date compare:self.maximumDate] == NSOrderedDescending) {
        return;
    }
//    TMCourseCalendarCell *cell = (TMCourseCalendarCell *)[calendar cellForDate:date atMonthPosition:FSCalendarMonthPositionCurrent];
//    self.lastSelectedCell.isSelected = NO;
//    cell.isSelected = YES;
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
    if (self.complectionHandler) {
        self.complectionHandler([self.dateFormatter stringFromDate:date]);
    }
    [self hide];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSLog(@"%s", __func__);
}

#pragma mark -- setter

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    if ([_minimumDate compare:[NSDate date]] == NSOrderedAscending) {
        _minimumDate = [NSDate date];
    }
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
}

#pragma mark -- public method

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.y = kScreen_height - self.contentView.height;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.y = self.height;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
