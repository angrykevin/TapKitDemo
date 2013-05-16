//
//  TKCache.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/14/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKCache.h"

@implementation TKCache


#pragma mark - NSObject

- (id)init
{
  self = [super init];
  if ( self ) {
    
    NSString *root = TKPathForDocumentsResource(@"Caches");
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:root isDirectory:NULL] ) {
      [[NSFileManager defaultManager] createDirectoryAtPath:root
                                withIntermediateDirectories:YES
                                                 attributes:nil
                                                      error:NULL];
    }
    
    
    _items = [[NSMutableArray alloc] init];
    
    NSString *path = TKPathForDocumentsResource(@"Caches/profile.dt");
    NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    for ( TKCacheItem *item in items ) {
      if ( [item.expiryDate earlierThan:[NSDate date]] ) {
        [[NSFileManager defaultManager] removeItemAtPath:item.path error:NULL];
      } else {
        [_items addObject:item];
      }
    }
    
    _lock = [[NSLock alloc] init];
    
  }
  return self;
}



#pragma mark - Singleton

+ (id)sharedObject
{
  TKCache *cache = nil;
  if ( cache == nil ) {
    cache = [[self alloc] init];
  }
  return cache;
}



#pragma mark - Accessing caches

- (void)addCacheItem:(TKCacheItem *)item
{
  if ( item ) {
    if ( [item.key length] <= 0 ) {
      return;
    }
    
    NSString *path = [[NSString alloc] initWithFormat:@"Caches/%@", item.key];
    if ( ![TKPathForDocumentsResource(path) isEqualToString:item.path] ) {
      return;
    }
    
    if ( [item.expiryDate earlierThan:[NSDate date]] ) {
      return;
    }
    
    [_lock lock];
    [_items addObject:item];
    [_lock unlock];
  }
}

- (NSData *)dataForKey:(NSString *)key
{
  NSData *data = nil;
  
  if ( [key length] > 0 ) {
    [_lock lock];
    TKCacheItem *item = [_items firstObjectForKeyPath:@"key" equalToValue:key];
    if ( ![item.expiryDate earlierThan:[NSDate date]] ) {
      data = [[NSData alloc] initWithContentsOfFile:item.path];
    }
    [_lock unlock];
  }
  
  return data;
}

- (BOOL)setData:(NSData *)data forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
  BOOL result = NO;
  
  if ( [key length] > 0 ) {
    [_lock lock];
    
    TKCacheItem *item = [_items firstObjectForKeyPath:@"key" equalToValue:key];
    if ( item == nil ) {
      item = [[TKCacheItem alloc] init];
      [_items addObject:item];
    }
    
    item.key = key;
    
    NSString *path = [[NSString alloc] initWithFormat:@"Caches/%@", key];
    item.path = TKPathForDocumentsResource(path);
    
    NSTimeInterval interval = (timeoutInterval > 0) ? timeoutInterval : TKTimeIntervalWeek();
    NSDate *expiryDate = [[NSDate alloc] initWithTimeIntervalSinceNow:interval];
    item.expiryDate = expiryDate;
    
    item.size = [data length];
    
    if ( data ) {
      [data writeToFile:item.path atomically:YES];
    } else {
      [[NSFileManager defaultManager] removeItemAtPath:item.path error:NULL];
    }
    
    result = YES;
    
    [_lock unlock];
  }
  
  return result;
}



#pragma mark - Basic routines

- (BOOL)hasCacheForKey:(NSString *)key
{
  BOOL result = NO;
  
  if ( [key length] > 0 ) {
    [_lock lock];
    TKCacheItem *item = [_items firstObjectForKeyPath:@"key" equalToValue:key];
    if ( item ) {
      if ( ![item.expiryDate earlierThan:[NSDate date]] ) {
        result = YES;
      }
    }
    [_lock unlock];
  }
  
  return result;
}

- (void)removeCacheForKey:(NSString *)key
{
  if ( [key length] > 0 ) {
    [_lock lock];
    
    TKCacheItem *item = [_items firstObjectForKeyPath:@"key" equalToValue:key];
    if ( item ) {
      [_items removeObjectIdenticalTo:item];
      [[NSFileManager defaultManager] removeItemAtPath:item.path error:NULL];
    }
    
    [_lock unlock];
  }
}


- (int)count
{
  int amount = 0;
  
  [_lock lock];
  amount = [_items count];
  [_lock unlock];
  
  return amount;
}

- (void)clearCache
{
  [_lock lock];
  
  [_items removeAllObjects];
  
  NSString *root = TKPathForDocumentsResource(@"Caches");
  
  [[NSFileManager defaultManager] removeItemAtPath:root error:NULL];
  
  if ( ![[NSFileManager defaultManager] fileExistsAtPath:root isDirectory:NULL] ) {
    [[NSFileManager defaultManager] createDirectoryAtPath:root
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
  }
  
  [_lock unlock];
}

- (void)cleanUp
{
  [_lock lock];
  
  NSArray *items = [[NSArray alloc] initWithArray:_items];
  [_items removeAllObjects];
  for ( TKCacheItem *item in items ) {
    if ( [item.expiryDate earlierThan:[NSDate date]] ) {
      [[NSFileManager defaultManager] removeItemAtPath:item.path error:NULL];
    } else {
      [_items addObject:item];
    }
  }
  
  [_lock unlock];
}

- (int)cacheSize
{
  int size = 0;
  
  [_lock lock];
  for ( TKCacheItem *item in _items ) {
    size += item.size;
  }
  [_lock unlock];
  
  return size;
}

- (void)synchronize
{
  [_lock lock];
  
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_items];
  NSString *path = TKPathForDocumentsResource(@"Caches/profile.dt");
  [data writeToFile:path atomically:YES];
  
  [_lock unlock];
}



#pragma mark - Paths

- (NSString *)cacheRootDirectory
{
  return TKPathForDocumentsResource(@"Caches");
}

- (NSString *)cachePathForKey:(NSString *)key
{
  if ( [key length] > 0 ) {
    NSString *path = [[NSString alloc] initWithFormat:@"Caches/%@", key];
    return TKPathForDocumentsResource(path);
  }
  return nil;
}

@end



@implementation TKCacheItem

@synthesize key = _key;
@synthesize path = _path;
@synthesize expiryDate = _expiryDate;
@synthesize size = _size;

- (id)initWithCoder:(NSCoder *)decoder
{
  self = [super init];
  if ( self ) {
    _key = [decoder decodeObjectForKey:@"kKey"];
    _path = [decoder decodeObjectForKey:@"kPath"];
    _size = [decoder decodeIntForKey:@"kSize"];
    _expiryDate = [decoder decodeObjectForKey:@"kExpiryDate"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeObject:_key forKey:@"kKey"];
  [encoder encodeObject:_path forKey:@"kPath"];
  [encoder encodeInt:_size forKey:@"kSize"];
  [encoder encodeObject:_expiryDate forKey:@"kExpiryDate"];
}

@end
