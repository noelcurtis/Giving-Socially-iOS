//
//  ApiUserTests.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "ApiUserTests.h"
#import "GSUser.h"
#import "GSGiftList.h"

@interface ApiUserTests()

@property (nonatomic, readonly) NSString *authToken;
@property (nonatomic, readonly) NSString *authTokenParam;

@end

@implementation ApiUserTests

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

- (void) testShowFriendsOfUser{
    
    @try {
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

-(void) testShowGiftListsOfUser{
    @try {
        NSString *showUserUri = [NSString stringWithFormat:@"/gift_lists%@", self.authTokenParam];
        // make request
        RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:showUserUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
        [objectLoader send];
        
        [_loaderDelegate waitForResponse];
        NSArray *loadedObjects = _loaderDelegate.objects;
        // assert response
        STAssertNotNil([loadedObjects objectAtIndex:0], @"No Gift Lists were returned!");
        STAssertTrue([[loadedObjects objectAtIndex:0] isKindOfClass:[GSGiftList class]], @"Something other than a GiftList was returned from the API!");
    }
    @catch (NSException *exception) {
        STFail(exception.reason);
    }
}

-(NSString*) authTokenParam{
    if (self.authToken) {
        return [NSString stringWithFormat:@"?auth_token=%@", self.authToken];
    }   
    @throw [NSException exceptionWithName:@"AuthTokenNotSet" reason:@"auth_token is not set" userInfo:nil];
}

-(NSString*) authToken{
    return @"QmrVpGgHqGSPu3z6tPBR";
}


- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}


@end
