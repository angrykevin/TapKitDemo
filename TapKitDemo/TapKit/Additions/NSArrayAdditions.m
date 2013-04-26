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



@implementation NSMutableArray (Tint)



#pragma mark - Adding and removing entries

- (id)addObjectIfNotNil:(id)object
{
  if ( object ) {
    [self addObject:object];
    return object;
  }
  return nil;
}

- (id)addUnequalObjectIfNotNil:(id)object
{
  if ((object) &&
      ([self indexOfObject:object] == NSNotFound))
  {
    [self addObject:object];
    return object;
  }
  return nil;
}

- (id)addUnidenticalObjectIfNotNil:(id)object
{
  if ((object) &&
      ([self indexOfObjectIdenticalTo:object] == NSNotFound))
  {
    [self addObject:object];
    return object;
  }
  return nil;
}


- (id)insertObject:(id)object atIndexIfNotNil:(NSUInteger)idx
{
  if ((object) &&
      (idx <= [self count]))
  {
    [self insertObject:object atIndex:idx];
    return object;
  }
  return nil;
}


- (id)moveObjectAtIndex:(NSUInteger)idx toIndex:(NSUInteger)toIdx
{
  if ((idx != toIdx) &&
      (idx < [self count]) &&
      (toIdx < [self count]))
  {
    id object = [self objectAtIndex:idx];
    [self removeObjectAtIndex:idx];
    [self insertObject:object atIndex:toIdx];
    return [self objectAtIndex:toIdx];
  }
  return nil;
}


- (void)removeFirstObject
{
  if ( [self count] > 0 ) {
    [self removeObjectAtIndex:0];
  }
}



#pragma mark - Ordering and filtering

// http://en.wikipedia.org/wiki/Knuth_shuffle
- (void)shuffle
{
  for ( NSUInteger i=[self count]; i>1; --i ) {
    
    NSUInteger m = 1;
    do {
      m <<= 1;
    } while ( m < i );
    
    NSUInteger j;
    do {
      j = arc4random() % m;
    } while ( j >= i );
    
    [self exchangeObjectAtIndex:(i - 1) withObjectAtIndex:j];
  }
}

- (void)reverse
{
	for ( NSInteger i=0; i<(floor([self count] / 2.0)); ++i ) {
		[self exchangeObjectAtIndex:i withObjectAtIndex:([self count] - (i + 1))];
  }
}

- (void)unequal
{
  if ( [self count] > 0 ) {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for ( NSInteger i=0; i<[self count]; ++i ) {
      id object = [self objectAtIndex:i];
      if ( [array indexOfObject:object] == NSNotFound ) {
        [array addObject:object];
      }
    }
    
    [self removeAllObjects];
    
    for ( NSInteger i=0; i<[array count]; ++i ) {
      [self addObject:[array objectAtIndex:i]];
    }
    
  }
}

- (void)unidentical
{
  if ( [self count] > 0 ) {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for ( NSInteger i=0; i<[self count]; ++i ) {
      id object = [self objectAtIndex:i];
      if ( [array indexOfObjectIdenticalTo:object] == NSNotFound ) {
        [array addObject:object];
      }
    }
    
    [self removeAllObjects];
    
    for ( NSInteger i=0; i<[array count]; ++i ) {
      [self addObject:[array objectAtIndex:i]];
    }
    
  }
}



#pragma mark - Stack

- (id)push:(id)object
{
  return [self addObjectIfNotNil:object];
}

- (id)pop
{
  if ( [self count] > 0 ) {
    id object = [self lastObject];
    [self removeLastObject];
    return object;
  }
  return nil;
}



#pragma mark - Queue

- (id)enqueue:(id)object
{
  return [self addObjectIfNotNil:object];
}

- (id)dequeue
{
  if ( [self count] > 0 ) {
    id object = [self firstObject];
    [self removeFirstObject];
    return object;
  }
  return nil;
}

@end
