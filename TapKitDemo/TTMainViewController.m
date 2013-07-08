//
//  TTMainViewController.m
//  TapKitDemo
//
//  Created by Wu Kevin on 5/17/13.
//  Copyright (c) 2013 Telligenty. All rights reserved.
//

#import "TTMainViewController.h"
#import "TTObject.h"

@implementation TTMainViewController

- (void)threadBody:(id)object
{
    
    @autoreleasepool {
        int value = [object intValue];
        NSLog(@"start: %d", value);
        while ( 1 ) {
            if ( _trigger ) {
                TTObject *object = [TTObject sharedObject];
                break;
            }
        }
        NSLog(@"stop: %d", value);
    }
    
}

- (void)creat:(id)sender
{
    static BOOL did = NO;
    if ( !did ) {
        did = YES;
        
        for ( int i=0; i<100; ++i ) {
            NSThread *thread = [[NSThread alloc] initWithTarget:self
                                                       selector:@selector(threadBody:)
                                                         object:[NSNumber numberWithInt:i+1]];
            [thread start];
        }
        
    }
}

- (void)launch:(id)sender
{
    static BOOL did = NO;
    if ( !did ) {
        did = YES;
        
        _trigger = YES;
        
    }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 10, 300, 40);
    [button addTarget:self action:@selector(creat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 60, 300, 40);
    [button addTarget:self action:@selector(launch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

@end
