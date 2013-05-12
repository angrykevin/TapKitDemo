//
//  UITableViewAdditions.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/13/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (TapKit)

///-------------------------------
/// Querying
///-------------------------------

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cls;
- (UITableViewCell *)firstRowInSection:(NSUInteger)section;
- (UITableViewCell *)lastRowInSection:(NSUInteger)section;

@end


@interface UITableViewCell (TapKit)

///-------------------------------
/// Cell height
///-------------------------------

+ (CGFloat)heightForTableView:(UITableView *)tableView object:(id)object;

@end
