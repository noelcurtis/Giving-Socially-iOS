//
//  GSContact.m
//  GivingSocially
//
//  Created by Noel Curtis on 3/6/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSContact.h"

@implementation GSContact

@synthesize firstName = _firstName, lastName = _lastName, emailAddresses = _emailAddresses;

-(void)dealloc{
    [_firstName release];
    [_lastName release];
    [_emailAddresses release];
    [super dealloc];
}

@end
