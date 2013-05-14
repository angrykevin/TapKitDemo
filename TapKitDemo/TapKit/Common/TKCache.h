//
//  TKCache.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/14/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Core/Core.h"
#import "Additions/Additions.h"

@interface TKCache : NSObject {
  NSMutableArray *_items;
  NSLock *_lock;
}


///-------------------------------
/// Singleton
///-------------------------------

+ (id)sharedObject;


///-------------------------------
/// Accessing caches
///-------------------------------

- (NSData *)dataForKey:(NSString *)key;
- (BOOL)setData:(NSData *)data forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
- (BOOL)copyFileAtPath:(NSString *)filePath asKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
- (BOOL)moveFileAtPath:(NSString *)filePath asKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;


///-------------------------------
/// Basic routines
///-------------------------------

- (BOOL)hasCacheForKey:(NSString *)key;
- (void)removeCacheForKey:(NSString *)key;

- (int)count;
- (void)clearCache;
- (void)cleanUp;
- (int)cacheSize;
- (void)synchronize;

- (BOOL)createCacheDirectory;

@end



@interface TKCacheItem : NSObject<NSCoding> {
  NSString *_key;
  NSString *_path;
  int _size;
  NSDate *_expiryDate;
}

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) int size;
@property (nonatomic, strong) NSDate *expiryDate;

@end
