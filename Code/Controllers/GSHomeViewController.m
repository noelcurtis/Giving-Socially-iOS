//
//  GSHomeViewController.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/2/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSHomeViewController.h"

@implementation GSHomeViewController

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    UILabel* test = [[[UILabel alloc] initWithFrame:(CGRect){ 0, 100, 320, 100 }] autorelease];
    [test setText:@"Home View Controller"];
    [test setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:test];
}

@end
