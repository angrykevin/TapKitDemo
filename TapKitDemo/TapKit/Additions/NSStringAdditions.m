//
//  NSStringAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 4/27/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "NSStringAdditions.h"
#import "NSDataAdditions.h"
#import "NSDictionaryAdditions.h"

@implementation NSString (TapKit)



#pragma mark - UUID

+ (NSString *)UUIDString
{
	CFUUIDRef UUIDRef = CFUUIDCreate(NULL);
  
	NSString *string = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, UUIDRef);
  
  if ( UUIDRef ) {
    CFRelease(UUIDRef);
    UUIDRef = NULL;
  }
  
  return string;
}



#pragma mark - Validity

- (BOOL)isDecimalNumber
{
  return [self isInCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}

- (BOOL)isWhitespaceAndNewline
{
  return [self isInCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (BOOL)isInCharacterSet:(NSCharacterSet *)characterSet
{
  for ( NSInteger i=0; i<[self length]; ++i ) {
    unichar c = [self characterAtIndex:i];
    if ( ![characterSet characterIsMember:c] ) {
      return NO;
    }
  }
  return YES;
}



#pragma mark - Hash

- (NSString *)MD5HashString
{
  return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5HashString];
}

- (NSString *)SHA1HashString
{
  return [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1HashString];
}



#pragma mark - URL

- (NSString *)URLEncodedString
{
  return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                               (__bridge CFStringRef)self,
                                                                               NULL,
                                                                               CFSTR("!*'();:@&=+$,/?%#[]<>"),
                                                                               kCFStringEncodingUTF8);
}

- (NSString *)URLDecodedString
{
  return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                               (__bridge CFStringRef)self,
                                                                                               CFSTR(""),
                                                                                               kCFStringEncodingUTF8);
}



- (NSDictionary *)queryDictionary
{
  
  NSString *string = self;
  
  NSRange range = [self rangeOfString:@"?"];
  if ( range.location != NSNotFound ) {
    string = [self substringFromIndex:range.location + range.length];
  }
  
  NSArray *pairs = [string componentsSeparatedByString:@"&"];
  
  NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
  
	for ( NSString *pair in pairs ) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
    if ( [kv count] == 2 ) {
      NSString *key = [kv objectAtIndex:0];
      NSString *value = [[kv objectAtIndex:1] URLDecodedString];
      [dictionary setObject:value forKey:key];
    }
	}
  
  if ( [dictionary count] > 0 ) {
    return dictionary;
  }
  
  return nil;
}

- (NSString *)stringByAddingQueryDictionary:(NSDictionary *)dictionary
{
  NSString *query = [dictionary queryString];
  
  if ( [query length] > 0 ) {
    
    if ( [self rangeOfString:@"?"].location == NSNotFound ) {
      
      return [self stringByAppendingFormat:@"?%@", query];
      
    } else {
      
      if ([self hasSuffix:@"&"]
          || [self hasSuffix:@"?"])
      {
        return [self stringByAppendingFormat:@"%@", query];
      } else {
        return [self stringByAppendingFormat:@"&%@", query];
      }
      
    }
    
  }
  return self;
}

- (NSString *)stringByAppendingValue:(NSString *)value forKey:(NSString *)key
{
  if ( [key length] > 0 ) {
    
    NSString *newValue = (value == nil) ? @"" : value;
    
    if ( [self rangeOfString:@"?"].location == NSNotFound ) {
      
      return [self stringByAppendingFormat:@"?%@=%@", key, newValue];
      
    } else {
      
      if ([self hasSuffix:@"&"]
          || [self hasSuffix:@"?"])
      {
        return [self stringByAppendingFormat:@"%@=%@", key, newValue];
      } else {
        return [self stringByAppendingFormat:@"&%@=%@", key, newValue];
      }
      
    }
    
  }
  return self;
}

@end
