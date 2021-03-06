//
//  TBTableView.h
//  TapKitDemo
//
//  Created by Wu Kevin on 3/19/14.
//  Copyright (c) 2014 Telligenty. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TBRefreshControl;


@interface TBTableView : UITableView {
  UIRefreshControl *_refreshControl;
  BOOL _showsRefreshControl;
  
  TBRefreshControl *_infiniteRefreshControl;
  BOOL _showsInfiniteRefreshControl;
}

@property (nonatomic, strong, readonly) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL showsRefreshControl;

@property (nonatomic, strong, readonly) TBRefreshControl *infiniteRefreshControl;
@property (nonatomic, assign) BOOL showsInfiniteRefreshControl;

@property (nonatomic, copy) NSString *refreshTitle;

- (void)startRefreshing:(BOOL)animated;
- (void)stopRefreshing:(BOOL)animated;

- (void)startInfiniteRefreshing:(BOOL)animated;
- (void)stopInfiniteRefreshing:(BOOL)animated;
- (void)stopInfiniteRefreshingAndHide:(BOOL)animated;

@end



@interface TBRefreshControl : UIControl {
  UIActivityIndicatorView *_activityIndicatorView;
  BOOL _triggered;
  
  BOOL _refreshing;
}

@property (nonatomic, readonly) BOOL refreshing;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
