//
//  ApiUserTests.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "ApiUserTests.h"
#import "GSUser.h"

@interface ApiUserTests()

@property (nonatomic, retain) NSString *authToken;
@property (nonatomic, readonly) NSString *authTokenParam;

@end

@implementation ApiUserTests
@synthesize authToken = _authToken;

- (void)setUp
{
    [super setUp];
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    _loaderDelegate = [RKSpecResponseLoader responseLoader];
    _loaderDelegate.timeout = (1000 * 20);
    // Set-up code here.
}


- (void) testGetShowUser{
    
    @try {
        NSString *showUserUri = @"/users/little_kitten.json";
        // make request
        RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:showUserUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
        [objectLoader send];
        
        [_loaderDelegate waitForResponse];
        NSArray *loadedObjects = _loaderDelegate.objects;
        // assert response
        STAssertNotNil([loadedObjects objectAtIndex:0], @"No users were returned!");
        STAssertTrue([[loadedObjects objectAtIndex:0] isKindOfClass:[GSUser class]], @"Something other than a User was returned from the API!");
    }@catch (NSException *exception){
        STFail(exception.reason);
    }
}

- (void) testshowFriendsOfUser{
    
    @try {
        _authToken = @"GrvbiDuei4N2LVhxXiiG";
        
        NSString *showUserUri = [NSString stringWithFormat:@"/friends%@", self.authTokenParam];
        // make request
        RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:showUserUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
        [objectLoader send];
        
        [_loaderDelegate waitForResponse];
        NSArray *loadedObjects = _loaderDelegate.objects;
        // assert response
        STAssertNotNil([loadedObjects objectAtIndex:0], @"No users were returned!");
        STAssertTrue([[loadedObjects objectAtIndex:0] isKindOfClass:[GSUser class]], @"Something other than a User was returned from the API!");
    }
    @catch (NSException *exception) {
        STFail(exception.reason);
    }
}

-(NSString*) authTokenParam{
    if (_authToken) {
        return [NSString stringWithFormat:@"?auth_token=%@", _authToken];
    }   
    @throw [NSException exceptionWithName:@"AuthTokenNotSet" reason:@"auth_token is not set" userInfo:nil];
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}


@end
