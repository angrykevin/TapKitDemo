//
//  TKSettings.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/29/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Core/Core.h"
#import "Additions/Additions.h"

@interface TKSettings : NSObject {
  NSMutableDictionary *_settings;
}

+ (TKSettings *)sharedObject;

- (NSArray *)keys;
- (BOOL)synchronize;
- (void)dump;
- (BOOL)hasValueForKey:(NSString *)key;

- (BOOL)boolForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setInt:(int)value forKey:(NSString *)key;
- (void)setLongLong:(long long)value forKey:(NSString *)key;
- (void)setDouble:(double)value forKey:(NSString *)key;
- (void)setDate:(NSDate *)value forKey:(NSString *)key;
- (void)setString:(NSString *)value forKey:(NSString *)key;

@end
