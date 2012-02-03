//
//  GSAccountViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/2/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAccountViewController.h"

@implementation GSAccountViewController

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UILabel* test = [[[UILabel alloc] initWithFrame:(CGRect){ 0, 100, 320, 100 }] autorelease];
    [test setText:@"Account View Controller"];
    [test setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:test];
}

@end
