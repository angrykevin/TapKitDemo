//
//  UITableViewAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/13/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "UITableViewAdditions.h"

@implementation UITableView (TapKit)


#pragma mark - Querying

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cls
{
  if ( cls ) {
    
    NSString *identifier = NSStringFromClass(cls);
    
    UITableViewCell *cell = nil;
    
    cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if ( cell == nil ) {
      cell = [[cls alloc] init];
    }
    
    return cell;
  }
  
  return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
}

- (UITableViewCell *)firstRowInSection:(NSUInteger)section
{
  if ( section < [self numberOfSections] ) {
    NSUInteger rows = [self numberOfRowsInSection:section];
    if ( rows > 0 ) {
      return [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }
  }
  return nil;
}

- (UITableViewCell *)lastRowInSection:(NSUInteger)section
{
  if ( section < [self numberOfSections] ) {
    NSUInteger rows = [self numberOfRowsInSection:section];
    if ( rows > 0 ) {
      return [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(rows-1) inSection:section]];
    }
  }
  return nil;
}

@end



@implementation UITableViewCell (Tint)


#pragma mark - Cell height

+ (CGFloat)heightForTableView:(UITableView *)tableView object:(id)object
{
  return 44.0;
}

@end
