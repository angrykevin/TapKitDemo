//
//  TBViewController.h
//  Teemo
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

- (void)layoutViews;

@end
