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
  NSMutableDictionary *_settingEntries;
  NSLock *_lock;
}

+ (TKSettings *)sharedObject;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(NSObject *)object forKey:(NSString *)key;

- (NSArray *)keys;
- (BOOL)synchronize;
- (void)dump;

@end
