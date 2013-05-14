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
  NSLock *_lock;
}

+ (TKSettings *)sharedObject;

- (NSArray *)keys;
- (void)synchronize;
- (void)dump;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

@end
