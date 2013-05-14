//
//  UIScrollViewAdditions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/13/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "UIScrollViewAdditions.h"

@implementation UIScrollView (TapKit)


#pragma mark - Content size

- (void)makeContentSizeToViewSize
{
  CGSize newContentSize = CGSizeZero;
  newContentSize.width = MAX(self.contentSize.width, self.bounds.size.width);
  newContentSize.height = MAX(self.contentSize.height, self.bounds.size.height);
  self.contentSize = newContentSize;
}

- (void)makeHorizontalScrollable
{
  if ( self.contentSize.width <= self.bounds.size.width ) {
    self.contentSize = CGSizeMake(self.bounds.size.width+1.0, self.contentSize.height);
  }
}

- (void)makeVerticalScrollable
{
  if ( self.contentSize.height <= self.bounds.size.height ) {
    self.contentSize = CGSizeMake(self.contentSize.width, self.bounds.size.height+1.0);
  }
}



#pragma mark - Scrolling

- (void)scrollToTopAnimated:(BOOL)animated
{
  [self setContentOffset:CGPointZero animated:animated];
}

- (void)scrollToCenterAnimated:(BOOL)animated
{
  CGPoint offset = CGPointZero;
  CGFloat height = CGRectGetHeight(self.bounds);
  offset.y = self.contentSize.height - height - height/2.0;
  [self setContentOffset:offset animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
  CGPoint offset = CGPointZero;
  CGFloat height = CGRectGetHeight(self.bounds);
  offset.y = self.contentSize.height - height;
  [self setContentOffset:offset animated:animated];
}

- (void)stopScrollingAnimated:(BOOL)animated
{
  CGPoint offset = self.contentOffset;
  [self setContentOffset:offset animated:animated];
}

@end