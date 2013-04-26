//
//  NSObjectAdditions.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tint)

///-------------------------------
/// Class string
///-------------------------------

+ (NSString *)classString;

- (NSString *)classString;


///-------------------------------
/// Associate object
///-------------------------------

- (void)associateValue:(id)value withKey:(void *)key;

- (void)weaklyAssociateValue:(id)value withKey:(void *)key;

- (id)associatedValueForKey:(void *)key;


///-------------------------------
/// Key-Value coding
///-------------------------------

- (BOOL)isValueForKeyPath:(NSString *)keyPath equalToValue:(id)value;

- (BOOL)isValueForKeyPath:(NSString *)keyPath identicalToValue:(id)value;

+ (NSSet *)propertyNames;

+ (NSDictionary *)propertyAttributes;

@end