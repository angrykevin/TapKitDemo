//
//  TTMainViewController.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTMainViewController.h"


@implementation TTMainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//  button.frame = CGRectMake(10, 10, 300, 40);
//  [button addTarget:self action:@selector(doit1:) forControlEvents:UIControlEventTouchUpInside];
//  [self.view addSubview:button];
//  
//  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//  button.frame = CGRectMake(10, 60, 300, 40);
//  [button addTarget:self action:@selector(doit2:) forControlEvents:UIControlEventTouchUpInside];
//  [self.view addSubview:button];
//  
//  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//  button.frame = CGRectMake(10, 110, 300, 40);
//  [button addTarget:self action:@selector(doit3:) forControlEvents:UIControlEventTouchUpInside];
//  [self.view addSubview:button];
  
  
  _headerView = [[UIView alloc] init];
  _headerView.backgroundColor = [UIColor lightGrayColor];
  _headerView.frame = CGRectMake(0.0, 0.0, 320.0, 40.0);
  
  TBButton *button = [[TBButton alloc] init];
  [button addTarget:self action:@selector(doit1:) forControlEvents:UIControlEventTouchUpInside];
  [_headerView addSubview:button];
  button.frame = CGRectMake(0.0, 0.0, 160.0, 40.0);
  _tab1 = button;
  
  button = [[TBButton alloc] init];
  [button addTarget:self action:@selector(doit1:) forControlEvents:UIControlEventTouchUpInside];
  [_headerView addSubview:button];
  button.frame = CGRectMake(160.0, 0.0, 160.0, 40.0);
  _tab2 = button;
  
  _tab = _tab1;
  
  
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  
  
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  _tableView.frame = self.view.bounds;
//  _tableView.tableHeaderView = _headerView;
//  _headerView.frame = CGRectMake(0.0, 0.0, 320.0, 40.0);
}


- (void)doit1:(id)sender
{
  [self saveInfo];
  [self addDict:sender];
  NSMutableDictionary *dict = [sender info];
  
  
  CGFloat offsetY = [[dict objectForKey:@"offsetY"] floatValue];
  
  _tab = sender;
  [_tableView reloadData];
  [_tableView setContentOffset:CGPointMake(0.0, offsetY) animated:NO];
  
}

- (void)addDict:(TBButton *)button
{
  if ( button.info==nil ) {
    button.info = [[NSMutableDictionary alloc] init];
  }
}

- (void)saveInfo
{
  [self addDict:_tab];
  NSMutableDictionary *dict = [_tab info];
  
  CGFloat offsetY = _tableView.contentOffset.y;
  [dict setObject:[NSNumber numberWithFloat:offsetY] forKey:@"offsetY"];
  
}

- (void)doit2:(id)sender
{
}

- (void)doit3:(id)sender
{
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ( _tab == _tab1 ) {
    return 20;
  } else if ( _tab == _tab2 ) {
    return 2;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithClass:[UITableViewCell class]];
  
  if ( _tab == _tab1 ) {
    cell.textLabel.text = [NSString stringWithFormat:@"SegA: %d", indexPath.row+1];
  } else if ( _tab == _tab2 ) {
    cell.textLabel.text = [NSString stringWithFormat:@"SegB: %d", indexPath.row+1];
  }
  
  return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return _headerView;
}

@end
