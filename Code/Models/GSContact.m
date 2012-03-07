//
//  GSContact.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/6/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSContact.h"

@implementation GSContact

@synthesize firstName, lastName, emailAddresses;

-(void)dealloc{
    self.firstName = nil;
    self.lastName = nil;
    self.emailAddresses = nil;
    [super dealloc];
}

@end
