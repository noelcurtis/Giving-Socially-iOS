//
//  GSGift.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSGift.h"

@implementation GSGift

@synthesize giftListID = _giftListID;

- (void)didTurnIntoFault
{
    [_giftListID release];
    [super didTurnIntoFault];
}

@end
