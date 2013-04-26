//
//  NSObjectAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/26/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "NSObjectAdditions.h"
#import <objc/runtime.h>

@implementation NSObject (Tint)



#pragma mark - Class string

+ (NSString *)classString
{
  return NSStringFromClass([self class]);
}

- (NSString *)classString
{
  return NSStringFromClass([self class]);
}



#pragma mark - Associate object

- (void)associateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key
{
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key
{
	return objc_getAssociatedObject(self, key);
}


#pragma mark - Key-Value Coding

- (BOOL)isValueForKeyPath:(NSString *)keyPath equalToValue:(id)value
{
  return [[self valueForKeyPath:keyPath] isEqual:value];
}

- (BOOL)isValueForKeyPath:(NSString *)keyPath identicalToValue:(id)value
{
  return ( [self valueForKeyPath:keyPath] == value );
}

+ (NSSet *)propertyNames
{
  NSMutableSet *set = [NSMutableSet set];
  
  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList(self, &count);
  if ( count > 0 ) {
    
    for ( int i=0; i<count; ++i ) {
      objc_property_t property = properties[i];
      NSString *name = [NSString stringWithUTF8String:property_getName(property)];
      [set addObject:name];
    }
    
  }
  free(properties);
  
  if ( [set count] > 0 ) {
    return set;
  }
  
  return nil;
}

+ (NSDictionary *)propertyAttributes
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList(self, &count);
  if ( count > 0 ) {
    
    for ( int i=0; i<count; ++i ) {
      objc_property_t property = properties[i];
      NSString *name = [NSString stringWithUTF8String:property_getName(property)];
      NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
      [dictionary setObject:attribute forKey:name];
    }
    
  }
  free(properties);
  
  if ( [dictionary count] > 0 ) {
    return dictionary;
  }
  
  return nil;
}

@end
