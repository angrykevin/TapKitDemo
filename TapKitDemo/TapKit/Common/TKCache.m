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
    
    [self createCacheDirectory];
    
    _items = [[NSMutableArray alloc] init];
    
    NSString *path = TKPathForDocumentsResource(@"caches/profile.dt");
    NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    for ( TKCacheItem *item in items ) {
      [_items addObject:item];
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

- (NSData *)dataForKey:(NSString *)key
{
}

- (BOOL)setData:(NSData *)data forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
}

- (BOOL)copyFileAtPath:(NSString *)filePath asKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
}

- (BOOL)moveFileAtPath:(NSString *)filePath asKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
}



#pragma mark - Basic routines

- (BOOL)hasCacheForKey:(NSString *)key
{
}

- (void)removeCacheForKey:(NSString *)key
{
}


- (int)count
{
}

- (void)clearCache
{
}

- (void)cleanUp
{
}

- (int)cacheSize
{
}

- (void)synchronize
{
}


- (BOOL)createCacheDirectory
{
  NSString *root = TKPathForDocumentsResource(@"caches");
  NSFileManager *fileManager = [NSFileManager defaultManager];
  BOOL isDirectory = NO;
  if ( ![fileManager fileExistsAtPath:root isDirectory:&isDirectory] ) {
    return [fileManager createDirectoryAtPath:root
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:NULL];
  }
  return isDirectory;
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