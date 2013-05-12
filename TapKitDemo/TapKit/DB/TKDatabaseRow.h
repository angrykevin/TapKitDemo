//
//  TKDatabaseRow.h
//  TapKitDemo
//
//  Created by Wu Kevin on 4/29/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Core/Core.h"
#import "Additions/Additions.h"

@interface TKDatabaseRow : NSObject {
  NSArray *_names;
  NSArray *_types;
  NSArray *_columns;
}

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *columns;

- (BOOL)boolForName:(NSString *)name;
- (NSInteger)integerForName:(NSString *)name;
- (CGFloat)floatForName:(NSString *)name;
- (NSString *)stringForName:(NSString *)name;
- (NSDate *)dateForName:(NSString *)name;

@end
