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
    _settingEntries = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if ( _settingEntries == nil ) {
      _settingEntries = [[NSMutableDictionary alloc] init];
    }
    
    _lock = [[NSLock alloc] init];
    
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


- (id)objectForKey:(NSString *)key
{
  [_lock lock];
  
  id object = [_settingEntries objectForKey:key];
  
  [_lock unlock];
  
  return object;
}

- (void)setObject:(NSObject *)object forKey:(NSString *)key
{
  [_lock lock];
  
  if ( object ) {
    [_settingEntries setObject:object forKeyIfNotNil:key];
  } else {
    [_settingEntries removeObjectForKeyIfNotNil:key];
  }
  
  [_lock unlock];
}


- (NSArray *)keys
{
  [_lock lock];
  
  NSArray *array = [_settingEntries allKeys];
  
  [_lock unlock];
  
  return array;
}

- (BOOL)synchronize
{
  [_lock lock];
  
  NSString *path = TKPathForDocumentsResource(@"AppSettings.xml");
  BOOL result = [_settingEntries writeToFile:path atomically:YES];
  
  [_lock unlock];
  
  return result;
}

- (void)dump
{
#ifdef DEBUG
  [_lock lock];
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  NSLog(@"+");
  NSLog(@"+ total: %d", [_settingEntries count]);
  NSLog(@"+");
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  for ( NSString *key in [_settingEntries keyEnumerator] ) {
    NSLog(@"+ %@ = %@", key, [_settingEntries objectForKey:key]);
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
  [_lock unlock];
#endif
}

@end
