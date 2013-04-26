//
//  NSArrayAdditions.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/27/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Tint)

///-------------------------------
/// Querying
///-------------------------------

- (id)objectOrNilAtIndex:(NSUInteger)idx;

- (id)firstObject;

- (id)randomObject;


- (BOOL)hasObjectEqualTo:(id)object;

- (BOOL)hasObjectIdenticalTo:(id)object;


///-------------------------------
/// Key-Value Coding
///-------------------------------

- (NSArray *)objectsForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (NSArray *)objectsForKeyPath:(NSString *)keyPath identicalToValue:(id)value;


- (id)firstObjectForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (id)firstObjectForKeyPath:(NSString *)keyPath identicalToValue:(id)value;

@end
