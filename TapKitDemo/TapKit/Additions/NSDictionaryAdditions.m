//
//  NSDictionaryAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/27/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "NSDictionaryAdditions.h"

@implementation NSDictionary (TapKit)



#pragma mark - Querying

- (BOOL)hasObjectEqualTo:(id)object
{
  return ( [[self allValues] indexOfObject:object] != NSNotFound );
}

- (BOOL)hasObjectIdenticalTo:(id)object
{
  return ( [[self allValues] indexOfObjectIdenticalTo:object] != NSNotFound );
}

- (BOOL)hasKeyEqualTo:(id)key
{
  return ( [[self allKeys] indexOfObject:key] != NSNotFound );
}

- (BOOL)hasKeyIdenticalTo:(id)key
{
  return ( [[self allKeys] indexOfObjectIdenticalTo:key] != NSNotFound );
}



#pragma mark - URL

- (NSString *)queryString
{
  if ( [self count] > 0 ) {
    
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    
    for ( NSString *key in [self keyEnumerator] ) {
      NSString *value = [self objectForKey:key];
      NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
      [parameters addObject:pair];
    }
    
    return [parameters componentsJoinedByString:@"&"];
  }
  return nil;
}

@end



@implementation NSMutableDictionary (TapKit)



#pragma mark - Adding and removing entries

- (void)setObject:(id)object forKeyIfNotNil:(id)key
{
  if ( object && key ) {
    [self setObject:object forKey:key];
  }
}

- (void)removeObjectForKeyIfNotNil:(id)key
{
  if ( key ) {
    [self removeObjectForKey:key];
  }
}

@end
