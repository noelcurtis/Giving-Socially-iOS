//
//  GSUser.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <RestKit/CoreData.h>

@interface GSUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * authToken;
@property (nonatomic, retain) NSString * facebookToken;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;

// Not in CoreData
@property (nonatomic, retain) NSString* password;

+ (GSUser*)currentUser;

- (void)logout;

- (NSString*)fullName;

@end
