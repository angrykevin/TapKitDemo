//
//  TBViewController.m
//  Teemo
//
//  Created by Wu Kevin on 11/6/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBViewController.h"
#import "TBCommon.h"

@implementation TBViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _contentView = [[UIView alloc] init];
  _contentView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_contentView];
  
}


- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  _viewAppeared = YES;
  _appearedTimes++;
}

- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  _viewAppeared = NO;
}


- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  [self layoutViews];
}

- (void)layoutViews
{
  _contentView.frame = self.view.bounds;
}

@end
