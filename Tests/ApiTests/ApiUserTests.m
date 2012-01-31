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

@property (nonatomic, retain) NSString *authToken;
@property (nonatomic, readonly) NSString *authTokenParam;
@property (nonatomic, retain) RKSpecResponseLoader *loaderDelegate;
@property (nonatomic, readonly) GSUser *testUser;

@end

@implementation ApiUserTests

@synthesize loaderDelegate = _loaderDelegate;
@synthesize authToken = _authToken;

- (void)setUp
{
    [super setUp];
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    _loaderDelegate = [RKSpecResponseLoader responseLoader];
    _loaderDelegate.timeout = (1000 * 20);
    [self signInUser];
    // Set-up code here.
}

-(void) signInUser{
    NSArray *users = [self postApiRequest:[self testUser]];
    STAssertNotNil([users objectAtIndex:0], @"No Users were returned, thus you could not have been Authenticated!");
    GSUser *authenticatedUser = [users objectAtIndex:0];
    _authToken = authenticatedUser.authToken;
    STAssertNotNil(authenticatedUser.authToken, @"No Users were returned, thus you could not have been Authenticated!");
}

- (void) testShowFriendsOfUser{

    NSString *showUserUri = [NSString stringWithFormat:@"/friends%@", self.authTokenParam];
    NSArray *users = [self sendApiRequest:showUserUri responseType:[GSUser class]];
    
    STAssertNotNil([users objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Users"]);
    STAssertTrue([[users objectAtIndex:0] isKindOfClass:[GSUser class]], @"Something other than a User was returned from the API!");
    
}

-(void) testShowGiftListsOfUser{

    NSString *showGiftLists = [NSString stringWithFormat:@"/gift_lists%@", self.authTokenParam];
    NSArray *giftLists = [self sendApiRequest:showGiftLists responseType:[GSGiftList class]];
    STAssertNotNil([giftLists objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Gift Lists"]);
    STAssertTrue([[giftLists objectAtIndex:0] isKindOfClass:[GSGiftList class]], @"Something other than a GiftList was returned from the API!");
}

-(void) testShowGiftsForGiftList{
    NSString *giftListId = @"2";
    NSString *showGifts = [NSString stringWithFormat:@"/gift_lists/%@/gifts%@", giftListId,self.authTokenParam];
    NSArray *gifts = [self sendApiRequest:showGifts responseType:[GSGift class]];
    STAssertNotNil([gifts objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Gifts"]);
    STAssertTrue([[gifts objectAtIndex:0] isKindOfClass:[GSGift class]], @"Something other than a Gift was returned from the API!");
}


-(NSArray*) sendApiRequest:(NSString*) requestUri responseType:(Class) classType{
    // make request
    RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:requestUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
    [objectLoader send];
    
    [_loaderDelegate waitForResponse];
    NSArray *loadedObjects = _loaderDelegate.objects;
    return loadedObjects;
}

-(NSArray*) postApiRequest:(NSObject*)object{
    [[RKObjectManager sharedManager] postObject:object delegate:_loaderDelegate];
    [_loaderDelegate waitForResponse];
    NSArray *loadedObjects = _loaderDelegate.objects;
    return loadedObjects;
}

-(NSString*) authTokenParam{
    if (self.authToken) {
        return [NSString stringWithFormat:@"?auth_token=%@", _authToken];
    }   
    @throw [NSException exceptionWithName:@"AuthTokenNotSet" reason:@"auth_token is not set" userInfo:nil];
}

-(GSUser *)testUser{
    GSUser *user = [[GSUser alloc] init];
    user.email = @"kitten@puppy.com";
    user.password = @"kitten_little";
    return user;
}


- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}


@end
