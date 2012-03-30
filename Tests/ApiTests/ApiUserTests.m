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
#import "NSData+Base64.h"
#import "GSActivity.h"
#import "GSAppDelegate.h"

@interface ApiUserTests ()

@property (nonatomic, retain) NSString *authToken;
@property (nonatomic, readonly) NSString *authTokenParam;
@property (nonatomic, retain) RKSpecResponseLoader *loaderDelegate;

- (NSArray*)postApiRequest:(NSObject*)object;
- (NSArray*)sendApiRequest:(NSString*)requestUri;
- (void)signInUser;

@end

@implementation ApiUserTests

@synthesize loaderDelegate = _loaderDelegate;
@synthesize authToken = _authToken;

- (void)setUp
{
    [super setUp];
    //RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    _loaderDelegate = [RKSpecResponseLoader responseLoader];
    _loaderDelegate.timeout = (1000 * 20);
    [self signInUser];
}

-(void) signInUser
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/users/sign_in" usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = _loaderDelegate;
        loader.method = RKRequestMethodPOST;
        
        NSDictionary* userParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"kitten@puppy.com", @"email",
                                   @"kitten_little", @"password",
                                   nil];
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userParams, @"user", nil];
        loader.params = params;
    }];
    
    [_loaderDelegate waitForResponse];
    GSUser *currentUser = [GSUser currentUser];
    STAssertNotNil(currentUser.authToken, @"No Auth Token set, thus you could not have been Authenticated!");
    _authToken = currentUser.authToken;
}

- (void) testShowFriendsOfUser
{
    NSString *showUserUri = [NSString stringWithFormat:@"/friends%@", self.authTokenParam];
    NSArray *users = [self sendApiRequest:showUserUri];
    
    STAssertNotNil([users objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Users"]);
    STAssertTrue([[users objectAtIndex:0] isKindOfClass:[GSUser class]], @"Something other than a User was returned from the API!");
    
}

-(void) testShowGiftListsOfUser
{
    NSString *showGiftLists = [NSString stringWithFormat:@"/gift_lists%@", self.authTokenParam];
    NSArray *giftLists = [self sendApiRequest:showGiftLists];
    STAssertNotNil([giftLists objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Gift Lists"]);
    STAssertTrue([[giftLists objectAtIndex:0] isKindOfClass:[GSGiftList class]], @"Something other than a GiftList was returned from the API!");
}

-(void) testShowGiftsForGiftList
{
    NSString *giftListId = @"2";
    NSString *showGifts = [NSString stringWithFormat:@"/gift_lists/%@/gifts%@", giftListId,self.authTokenParam];
    NSArray *gifts = [self sendApiRequest:showGifts];
    STAssertNotNil([gifts objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Gifts"]);
    STAssertTrue([[gifts objectAtIndex:0] isKindOfClass:[GSGift class]], @"Something other than a Gift was returned from the API!");
}

//-(void) testSendEmailInvitation
//{
//    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/users/invite%@", self.authTokenParam] usingBlock:^(RKObjectLoader *loader) {
//        loader.delegate = _loaderDelegate;
//        loader.method = RKRequestMethodPOST;
//        
//        NSDictionary*  userParams = [NSDictionary dictionaryWithObjectsAndKeys:
//                                     @"Noel", @"first_name",
//                                     @"Curtis", @"last_name",
//                                     @"noelcurtis@gmail.com", @"email",
//                                     nil];
//        
//        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:userParams, @"user", nil];
//        loader.params = params;
//    }];
//    
//    [_loaderDelegate waitForResponse];
//}

//-(void) testShowActivities
//{
//    NSString *showActivities = [NSString stringWithFormat:@"/activities%@", self.authTokenParam];
//    NSArray *activities = [self sendApiRequest:showActivities];
//    STAssertNotNil([activities objectAtIndex:0], [NSString stringWithFormat:@"No %@ were returned!", "Activities"]);
//    STAssertTrue([[activities objectAtIndex:0] isKindOfClass:[GSActivity class]], @"Something other than a Activity was returned from the API!");
//
//}

-(void) facebookTest
{
    GSAppDelegate* appDelegateInstance = (GSAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegateInstance.facebook setAccessToken:@"AAAAAAITEghMBAP1dZC3XqEFiLpC4H7zCxQbQX2uYiAtYqKDQZCovfPqBZAx97MrVT6FQIBbBMAGRd3NdUMDRo5j2Tc8dbHr2kOzOS9I3AZDZD"];
    [appDelegateInstance.facebook requestWithGraphPath:@"me" andDelegate:self];
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"Recieved error %@", error.description);     
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    NSDictionary *userData = [NSDictionary dictionaryWithDictionary:(NSDictionary*)result];
    // fill up the rest of the required credentials for Facebook sign in.
    NSLog(@"Recieved result from Facebook.");
}

 

-(NSArray*) sendApiRequest:(NSString*) requestUri
{
    // make request
    RKObjectLoader* objectLoader = [RKObjectLoader loaderWithResourcePath:requestUri objectManager:[RKObjectManager sharedManager] delegate:_loaderDelegate];
    [objectLoader send];
    
    [_loaderDelegate waitForResponse];
    NSArray *loadedObjects = _loaderDelegate.objects;
    return loadedObjects;
}

-(NSArray*) postApiRequest:(NSObject*)object
{    
    [[RKObjectManager sharedManager] postObject:object delegate:_loaderDelegate];
    [_loaderDelegate waitForResponse];
    NSArray *loadedObjects = _loaderDelegate.objects;
    return loadedObjects;
}

-(NSString*) authTokenParam
{
    if (self.authToken) {
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
