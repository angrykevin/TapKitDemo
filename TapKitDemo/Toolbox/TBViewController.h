//
//  TBViewController.h
//  TapKitDemo
//
//  Created by Wu Kevin on 11/6/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TBViewController : UIViewController {
  UIView *_contentView;
  
  BOOL _viewAppeared;
  NSUInteger _appearedTimes;
}

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, readonly) BOOL viewAppeared;
@property (nonatomic, readonly) NSUInteger appearedTimes;

- (void)layoutViews;

@end
