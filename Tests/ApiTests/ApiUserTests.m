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
#import "GSGift.h"

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
        [self sendApiRequest:showUserUri responseType:[GSUser class]];
    }@catch (NSException *exception){
        STFail(exception.reason);
    }
}

- (void) testShowFriendsOfUser{
    
    @try {
        NSString *showUserUri = [NSString stringWithFormat:@"/friends%@", self.authTokenParam];
        [self sendApiRequest:showUserUri responseType:[GSUser class]];
    }
    @catch (NSException *exception) {
        STFail(exception.reason);
    }
}

-(void) testShowGiftListsOfUser{
    @try {
        NSString *showGiftLists = [NSString stringWithFormat:@"/gift_lists%@", self.authTokenParam];
        [self sendApiRequest:showGiftLists responseType:[GSGiftList class]];
    }
    @catch (NSException *exception) {
        STFail(exception.reason);
    }
}

-(void) testShowGiftsForGiftList{
    @try {
        
        NSString *giftListId = @"2";
        NSString *showGifts = [NSString stringWithFormat:@"/gift_lists/%@/gifts%@", giftListId,self.authTokenParam];
        [self sendApiRequest:showGifts responseType:[GSGift class]];
    }
    @catch (NSException *exception) {
        STFail(exception.reason);
    }
}


-(void) sendApiRequest:(NSString*) requestUri responseType:(Class) classType{
    @try {
        // make request
        RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:requestUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
        [objectLoader send];
        
        [_loaderDelegate waitForResponse];
        NSArray *loadedObjects = _loaderDelegate.objects;
        // assert response
        STAssertNotNil([loadedObjects objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", [classType description]]);
        STAssertTrue([[loadedObjects objectAtIndex:0] isKindOfClass:classType], @"Something other than a GiftList was returned from the API!");
    }
    @catch (NSException *exception) {
        @throw exception;
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
