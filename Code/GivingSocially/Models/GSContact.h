//
//  GSContact.h
//  GivingSocially
//
//  Created by Noel Curtis on 3/6/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSContact : NSObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSMutableArray  *emailAddresses;

@end
