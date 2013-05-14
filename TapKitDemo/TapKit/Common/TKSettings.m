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


- (NSArray *)keys
{
  [_lock lock];
  
  NSArray *keys = [_settings allKeys];
  
  [_lock unlock];
  
  return keys;
}

- (void)synchronize
{
  [_lock lock];
  
  NSString *path = TKPathForDocumentsResource(@"AppSettings.xml");
  [_settings writeToFile:path atomically:YES];
  
  [_lock unlock];
}

- (void)dump
{
#ifdef DEBUG
  [_lock lock];
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  NSLog(@"+");
  NSLog(@"+ total: %d", [_settings count]);
  NSLog(@"+");
  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  for ( NSString *key in [_settings keyEnumerator] ) {
    NSLog(@"+ %@ = %@", key, [_settings objectForKey:key]);
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
  [_lock unlock];
#endif
}


- (id)objectForKey:(NSString *)key
{
  [_lock lock];
  
  id object = [_settings objectForKey:key];
  
  [_lock unlock];
  
  return object;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
  [_lock lock];
  
  if ( object ) {
    [_settings setObject:object forKeyIfNotNil:key];
  } else {
    [_settings removeObjectForKeyIfNotNil:key];
  }
  
  [_lock unlock];
}

@end
