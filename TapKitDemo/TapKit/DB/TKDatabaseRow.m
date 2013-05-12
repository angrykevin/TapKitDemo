//
//  TKDatabaseRow.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/29/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKDatabaseRow.h"

@implementation TKDatabaseRow


#pragma mark - Public

- (BOOL)boolForName:(NSString *)name
{
  NSUInteger idx = [_names indexOfObject:name];
  return [[_columns objectOrNilAtIndex:idx] boolValue];
}

- (NSInteger)integerForName:(NSString *)name
{
  NSUInteger idx = [_names indexOfObject:name];
  return [[_columns objectOrNilAtIndex:idx] integerValue];
}

- (CGFloat)floatForName:(NSString *)name
{
  NSUInteger idx = [_names indexOfObject:name];
  return [[_columns objectOrNilAtIndex:idx] floatValue];
}

- (NSString *)stringForName:(NSString *)name
{
  NSUInteger idx = [_names indexOfObject:name];
  return [_columns objectOrNilAtIndex:idx];
}

- (NSDate *)dateForName:(NSString *)name
{
  NSUInteger idx = [_names indexOfObject:name];
  return TKDateFromInternetDateString([_columns objectOrNilAtIndex:idx]);
}

@end
