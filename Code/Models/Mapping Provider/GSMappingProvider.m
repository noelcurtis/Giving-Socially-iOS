//
//  GVMappingProvider.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSMappingProvider.h"
#import "GSUser.h"

@implementation GSMappingProvider

- (id)init {
    self = [super init];
    
    if(self){
        
        // User mapping        
        RKObjectMapping* user = [RKObjectMapping mappingForClass:[GSUser class]];
        [user mapKeyPath:@"username" toAttribute:@"username"];
        [user mapKeyPath:@"email" toAttribute:@"email"];
        [user mapKeyPath:@"authentication_token" toAttribute:@"authToken"];
        [self setMapping:user forKeyPath:@"user"];
    }
    
    return self;
}

@end
