//
//  TTMainViewController.h
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapKit/TapKit.h"
#import "Toolbox/Toolbox.h"


@interface TTMainViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate
> {
  UIView *_headerView;
  TBButton *_tab1;
  TBButton *_tab2;
  UITableView *_tableView;
  
  TBButton *_tab;
}

@end
