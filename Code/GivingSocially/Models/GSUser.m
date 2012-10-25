//
//  GSUser.m
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSUser.h"

static GSUser* gUser = nil;

@implementation GSUser

@synthesize password = _password;

+ (GSUser*)currentUser
{
    if (nil == gUser) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"authToken != nil"]; // TODO fix this to empty or nil
        gUser = [[GSUser findFirstWithPredicate:predicate sortedBy:@"email" ascending:YES] retain];
        if (gUser) {
            [[RKObjectManager sharedManager].client.HTTPHeaders setValue:gUser.authToken forKey:GSAuthTokenHeaderKey];
        }
    }
    
    return gUser;
}

- (void)logout
{
    GSUser* user = [GSUser currentUser];
    user.authToken = nil;
    [[user managedObjectContext] save:nil]; // TODO: Do we need to handle this error?
    [[RKObjectManager sharedManager].client.HTTPHeaders removeObjectForKey:GSAuthTokenHeaderKey];
    
    // TODO: Post notification when logged out?
}

- (NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
