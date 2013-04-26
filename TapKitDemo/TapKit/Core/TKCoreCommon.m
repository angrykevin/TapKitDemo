//
//  TKCoreCommon.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/25/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TKCoreCommon.h"



#pragma mark - Version

NSComparisonResult TKCompareVersion(NSString *ver1, NSString *ver2)
{
  NSArray *components1 = [ver1 componentsSeparatedByString:@"."];
  NSArray *components2 = [ver2 componentsSeparatedByString:@"."];
  
  NSInteger count = MIN( [components1 count], [components2 count] );
  
  for ( NSInteger i=0; i<count; ++i ) {
    NSInteger component1 = [[components1 objectAtIndex:i] integerValue];
    NSInteger component2 = [[components2 objectAtIndex:i] integerValue];
    
    if ( component1 > component2 ) {
      return NSOrderedDescending;
    } else if ( component1 < component2 ) {
      return NSOrderedAscending;
    }
    
  }
  
  return NSOrderedSame;
}

NSInteger TKMajorVersion(NSString *ver)
{
  NSArray *components = [ver componentsSeparatedByString:@"."];
  if ( [components count] >= 1 ) {
    return [[components objectAtIndex:0] integerValue];
  }
  return 0;
}

NSInteger TKMinorVersion(NSString *ver)
{
  NSArray *components = [ver componentsSeparatedByString:@"."];
  if ( [components count] >= 2 ) {
    return [[components objectAtIndex:1] integerValue];
  }
  return 0;
}

NSInteger TKBugfixVersion(NSString *ver)
{
  NSArray *components = [ver componentsSeparatedByString:@"."];
  if ( [components count] >= 3 ) {
    return [[components objectAtIndex:2] integerValue];
  }
  return 0;
}



#pragma mark - System paths

NSString *TKPathForBundleResource(NSBundle *bundle, NSString *relativePath)
{
  NSString *resourcePath = [( (bundle == nil) ? [NSBundle mainBundle] : bundle ) resourcePath];
  return [resourcePath stringByAppendingPathComponent:relativePath];
}

NSString *TKPathForDocumentsResource(NSString *relativePath)
{
  static NSString *documentsPath = nil;
  if ( documentsPath == nil ) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    documentsPath = [paths objectAtIndex:0];
  }
  return [documentsPath stringByAppendingPathComponent:relativePath];
}

NSString *TKPathForLibraryResource(NSString *relativePath)
{
  static NSString *libraryPath = nil;
  if ( libraryPath == nil ) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    libraryPath = [paths objectAtIndex:0];
  }
  return [libraryPath stringByAppendingPathComponent:relativePath];
}

NSString *TKPathForCachesResource(NSString *relativePath)
{
  static NSString *cachesPath = nil;
  if ( cachesPath == nil ) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    cachesPath = [paths objectAtIndex:0];
  }
  return [cachesPath stringByAppendingPathComponent:relativePath];
}



#pragma mark - Weak collections

NSMutableArray *TKCreateWeakMutableArray()
{
  return (__bridge_transfer NSMutableArray *)CFArrayCreateMutable(nil, 0, nil);
}

NSMutableDictionary *TKCreateWeakMutableDictionary()
{
  return (__bridge_transfer NSMutableDictionary *)CFDictionaryCreateMutable(nil, 0, nil, nil);
}

NSMutableSet *TKCreateWeakMutableSet()
{
  return (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
}



#pragma mark - Object validaty

BOOL TKIsInstance(id object, Class cls)
{
  return ((object)
          && [object isKindOfClass:cls]
          );
}


BOOL TKIsStringWithText(id object)
{
  return ((object)
          && [object isKindOfClass:[NSString class]]
          && ([(NSString *)object length] > 0)
          );
}

BOOL TKIsDataWithBytes(id object)
{
  return ((object)
          && [object isKindOfClass:[NSData class]]
          && ([(NSData *)object length] > 0)
          );
}

BOOL TKIsArrayWithItems(id object)
{
  return ((object)
          && [object isKindOfClass:[NSArray class]]
          && ([(NSArray *)object count] > 0)
          );
}

BOOL TKIsDictionaryWithItems(id object)
{
  return ((object)
          && [object isKindOfClass:[NSDictionary class]]
          && ([(NSDictionary *)object count] > 0)
          );
}

BOOL TKIsSetWithItems(id object)
{
  return ((object)
          && [object isKindOfClass:[NSSet class]]
          && ([(NSSet *)object count] > 0)
          );
}



#pragma mark - Internet date

NSDateFormatter *TKInternetDateFormatter()
{
  static NSDateFormatter *internetDateFormatter = nil;
  if ( internetDateFormatter == nil ) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    internetDateFormatter = formatter;
  }
  return internetDateFormatter;
}

NSDate *TKDateFromInternetDateString(NSString *string)
{
  return [TKInternetDateFormatter() dateFromString:string];
}

NSString *TKInternetDateStringFromDate(NSDate *date)
{
  return [TKInternetDateFormatter() stringFromDate:date];
}
