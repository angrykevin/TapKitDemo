//
//  UIViewControllerExtentions.m
//  TapKitDemo
//
//  Created by Wu Kevin on 8/27/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "UIViewControllerExtentions.h"

@implementation UIViewController (Extentions)

- (void)presentChildViewController:(UIViewController *)childViewController inView:(UIView *)containerView
{
  UIView *boxView = containerView;
  if ( !boxView  ) {
    boxView = self.view;
  }
  
  [self addChildViewController:childViewController];
  [boxView addSubview:childViewController.view];
  [childViewController didMoveToParentViewController:self];
  
}

- (void)dismissChildViewController:(UIViewController *)childViewController
{
  
  [childViewController willMoveToParentViewController:nil];
  [childViewController.view removeFromSuperview];
  [childViewController removeFromParentViewController];
  
}

@end

