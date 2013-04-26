//
//  NSArrayAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/27/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "NSArrayAdditions.h"

@implementation NSArray (Tint)



#pragma mark - Querying

- (id)objectOrNilAtIndex:(NSUInteger)idx
{
  if ( idx < [self count] ) {
    return [self objectAtIndex:idx];
  }
  return nil;
}

- (id)firstObject
{
  return [self objectOrNilAtIndex:0];
}

- (id)randomObject
{
  if ( [self count] > 0 ) {
    NSUInteger idx = arc4random() % [self count];
    return [self objectAtIndex:idx];
  }
  return nil;
}


- (BOOL)hasObjectEqualTo:(id)object
{
  return ( [self indexOfObject:object] != NSNotFound );
}

- (BOOL)hasObjectIdenticalTo:(id)object
{
  return ( [self indexOfObjectIdenticalTo:object] != NSNotFound );
}



#pragma mark - Key-Value Coding

- (NSArray *)objectsForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
  if ( [self count] > 0 ) {
    
    NSMutableArray *array = [NSMutableArray array];
    for ( NSInteger i=0; i<[self count]; ++i ) {
      id object = [self objectAtIndex:i];
      if ( [[object valueForKeyPath:keyPath] isEqual:value] ) {
        [array addObject:object];
      }
    }
    
    if ( [array count] > 0 ) {
      return array;
    }
    
  }
  return nil;
}

- (NSArray *)objectsForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
  if ( [self count] > 0 ) {
    
    NSMutableArray *array = [NSMutableArray array];
    for ( NSInteger i=0; i<[self count]; ++i ) {
      id object = [self objectAtIndex:i];
      if ( [object valueForKeyPath:keyPath] == value ) {
        [array addObject:object];
      }
    }
    
    if ( [array count] > 0 ) {
      return array;
    }
    
  }
  return nil;
}


- (id)firstObjectForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
  for ( NSInteger i=0; i<[self count]; ++i ) {
    id object = [self objectAtIndex:i];
    if ( [[object valueForKeyPath:keyPath] isEqual:value] ) {
      return object;
    }
  }
  return nil;
}

- (id)firstObjectForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
  for ( NSInteger i=0; i<[self count]; ++i ) {
    id object = [self objectAtIndex:i];
    if ( [object valueForKeyPath:keyPath] == value ) {
      return object;
    }
  }
  return nil;
}

@end
