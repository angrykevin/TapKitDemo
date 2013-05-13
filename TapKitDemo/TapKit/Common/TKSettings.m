//
//  TKSettings.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/29/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKSettings.h"

@implementation TKSettings


#pragma mark - NSObject

- (id)init
{
  self = [super init];
  if ( self ) {
    
    NSString *path = TKPathForDocumentsResource(@"AppSettings.xml");
    _settings = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if ( _settings == nil ) {
      _settings = [[NSMutableDictionary alloc] init];
    }
    
  }
  return self;
}



#pragma mark - Public

+ (TKSettings *)sharedObject
{
  static TKSettings *settings = nil;
  if ( settings == nil ) {
    settings = [[self alloc] init];
  }
  return settings;
}


- (NSArray *)keys
{
  return [_settings allKeys];
}

- (BOOL)synchronize
{
  NSString *path = TKPathForDocumentsResource(@"AppSettings.xml");
  return [_settings writeToFile:path atomically:YES];
}

- (void)dump
{
#ifdef DEBUG
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  NSLog(@"+");
  NSLog(@"+ total: %d", [_settings count]);
  NSLog(@"+");
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  for ( NSString *key in [_settings keyEnumerator] ) {
    NSLog(@"+ %@ = %@", key, [_settings objectForKey:key]);
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
#endif
}

- (BOOL)hasValueForKey:(NSString *)key
{
  return ( [_settings objectForKey:key] != nil );
}


- (BOOL)boolForKey:(NSString *)key
{
  return [[self stringForKey:key] boolValue];
}

- (int)intForKey:(NSString *)key
{
  return [[self stringForKey:key] intValue];
}

- (long long)longLongForKey:(NSString *)key
{
  return [[self stringForKey:key] longLongValue];
}

- (double)doubleForKey:(NSString *)key
{
  return [[self stringForKey:key] doubleValue];
}

- (NSDate *)dateForKey:(NSString *)key
{
  return TKDateFromInternetDateString([self stringForKey:key]);
}

- (NSString *)stringForKey:(NSString *)key
{
  return [_settings objectForKey:key];
}


- (void)setBool:(BOOL)value forKey:(NSString *)key
{
  [self setString:(NSString *)[NSNumber numberWithBool:value] forKey:key];
}

- (void)setInt:(int)value forKey:(NSString *)key
{
  [self setString:(NSString *)[NSNumber numberWithInt:value] forKey:key];
}

- (void)setLongLong:(long long)value forKey:(NSString *)key
{
  [self setString:(NSString *)[NSNumber numberWithLongLong:value] forKey:key];
}

- (void)setDouble:(double)value forKey:(NSString *)key
{
  [self setString:(NSString *)[NSNumber numberWithDouble:value] forKey:key];
}

- (void)setDate:(NSDate *)value forKey:(NSString *)key
{
  [self setString:TKInternetDateStringFromDate(value) forKey:key];
}

- (void)setString:(NSString *)value forKey:(NSString *)key
{
  if ( value ) {
    [_settings setObject:value forKeyIfNotNil:key];
  } else {
    [_settings removeObjectForKeyIfNotNil:key];
  }
}

@end
