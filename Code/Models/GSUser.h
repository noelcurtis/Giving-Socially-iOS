//
//  GSUser.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "_GSUser.h"
#import <RestKit/RestKit.h>

@interface GSUser : _GSUser

@property (nonatomic, retain) NSString* password;

+ (GSUser*)currentUser;

- (void)logout;

- (NSString*)fullName;

@end
