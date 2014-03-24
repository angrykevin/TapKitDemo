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
  
    
    NSString *path = TKPathForBundleResource(nil, @"emotion.plist");
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSString *text = @"I[a][a]f you are bit co [b]bout C[asd]TFramesetter and the CTFrame – that’s OK.";
  
    _label = [[TTTAttributedLabel alloc] init];
    _label.imageBricks = array;
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_label];
    //_label.frame = CGRectMake(10.0, 30.0, 300.0, 440.0);
    [_label showBorderWithBlueColor];
    _label.text = text;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:_label.attributedText
//                                                   withConstraints:CGSizeMake(300.0, 10000.0)
//                                            limitedToNumberOfLines:0];
    _label.frame = CGRectMake(10.0, 30.0, 300.0, 200.0);
    
    //_label.frame = CGRectMake(10.0, 30.0, 300.0, 100.0);
    
}


- (void)doit1:(id)sender
{
}

- (void)doit2:(id)sender
{
}

- (void)doit3:(id)sender
{
}

@end
