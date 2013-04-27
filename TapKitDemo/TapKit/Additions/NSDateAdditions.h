//
//  NSDateAdditions.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/27/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TapKit)

///-------------------------------
/// Adjusting
///-------------------------------

- (NSDate *)startDate;

- (NSDate *)noonDate;


- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;

- (NSDate *)dateByAddingHours:(NSInteger)hours;

- (NSDate *)dateByAddingDays:(NSInteger)days;


///-------------------------------
/// Comparing
///-------------------------------

- (BOOL)earlierThan:(NSDate *)date;


- (BOOL)isSameYearAsDate:(NSDate *)date;

- (BOOL)isSameMonthAsDate:(NSDate *)date;

- (BOOL)isSameDayAsDate:(NSDate *)date;

- (BOOL)isSameWeekAsDate:(NSDate *)date;


///-------------------------------
/// Date components
///-------------------------------

- (NSDateComponents *)dateComponents;

@end
