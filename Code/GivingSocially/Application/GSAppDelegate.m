//
//  GSAppDelegate.m
//  GivingSocially
//
//  Created by Scott Penrose on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAppDelegate.h"

#import "TestFlight.h"

#import "GSNetworkManager.h"
#import "GSMappingProvider.h"

//#import "GSFriendsViewController.h"
//#import "GSAccountViewController.h"
#import "GSHomeViewController.h"
#import "GSLoginViewController.h"
//#import "GSActivitesViewController.h"

#import "GSGift.h"
#import "GSGiftList.h"
#import "GSUser.h"

@interface GSAppDelegate ()

//@property (nonatomic, strong) GSFriendsViewController *friendsViewController;
//@property (nonatomic, strong) GSAccountViewController *accountViewController;
@property (nonatomic, strong) GSHomeViewController *homeViewController;
@property (nonatomic, strong) GSLoginViewController *loginViewController;
//@property (nonatomic, strong) GSActivitesViewController *activitiesViewController;

@end

@implementation GSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if CONFIGURATION_RELEASE
    NSLog(@"\n***************************\nCONFIGURATION MODE: RELEASE\n***************************");
#elif CONFIGURATOIN_RELEASE == 0
    NSLog(@"\n***************************\nCONFIGURATION MODE: DEBUG\n***************************");
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    _friendsViewController = [[GSFriendsViewController alloc] init];
//    _accountViewController = [[GSAccountViewController alloc] init];
    _homeViewController = [[GSHomeViewController alloc] init];
//    _activitiesViewController = [[GSActivitesViewController alloc] init];
//    UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:self.activitiesViewController];
    
//    UINavigationController *rightNavigationController = [[UINavigationController alloc] initWithRootViewController:self.friendsViewController];
//    IIViewDeckController *deckController =  [[IIViewDeckController alloc] initWithCenterViewController:centerNavigationController
//                                                                                    leftViewController:self.accountViewController
//                                                                                   rightViewController:rightNavigationController];
//    [self.window setRootViewController:deckController];
    [self.window setRootViewController:_homeViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // TestFlight
#if CONFIGURATION_RELEASE == 0
    [TestFlight takeOff:@"f0598e9df64627643e461419c2617565_NTY1MzAyMDEyLTAxLTI1IDAxOjA0OjQ5LjcyMTUwMQ"];
#endif
    
    [self.window makeKeyAndVisible];
    
    // Throw up login if not logged in
//    if (![GSUser currentUser]) {
//        _loginViewController = [[GSLoginViewController alloc] init];
//        [self setupFacebook];
//        [centerNavigationController presentModalViewController:_loginViewController animated:YES];
//    }
    
    return YES;
}

- (IIViewDeckController *)deckControllerInstance
{
    return (IIViewDeckController*)self.window.rootViewController;
}

//- (void)setupRestKit
//{
//    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
////    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
//    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURLString:GSBaseURL];
//    [objectManager setObjectStore:[RKManagedObjectStore objectStoreWithStoreFilename:@"GivingSocial.sqlite"]];
//    NSLog(@"Object store located at: %@", [objectManager.objectStore pathToStoreFile]);
//    
//    [objectManager.client.requestQueue setShowsNetworkActivityIndicatorWhenBusy:YES];
//    
//    RKParserRegistry* parserRegistery = [RKParserRegistry sharedRegistry];
//    [parserRegistery setParserClass:NSClassFromString(@"RKJSONParserJSONKit") forMIMEType:@"application/json"];
//    
//    objectManager.mappingProvider = [[[GSMappingProvider alloc] init] autorelease];
//    [self setupRestKitRoutes];
//    
////    [[RKParserRegistry sharedRegistry] setParserClass:NSClassFromString(@"RKXMLParserLibXML") forMIMEType:@"application/rss+xml"]; 
////    [[RKClient sharedClient].requestQueue setShowsNetworkActivityIndicatorWhenBusy:YES];
////    [[RKClient sharedClient].requestQueue setRequestTimeout:30.0];
////    
////    //Sat, 14 Jan 2012 00:00:00 -0600
////    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
////    [dateFormatter setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
////    [RKObjectMapping addDefaultDateFormatter:dateFormatter];
//}
//
//- (void)setupRestKitRoutes
//{
//    RKObjectRouter *router = [RKObjectManager sharedManager].router;
//    
//    // User Routes
//    [router routeClass:[GSUser class] toResourcePath:@"/users/sign_in" forMethod:RKRequestMethodPOST];
//    
//    // Gift Routes
//    [router routeClass:[GSGift class] toResourcePath:@"/gift_lists/:giftListID/gifts" forMethod:RKRequestMethodPOST];
//}

//-(void)setupFacebook
//{
//    _facebook = [[Facebook alloc] initWithAppId:@"362526673776223" andDelegate:_loginViewController];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    
//    return [_facebook handleOpenURL:url]; 
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [_facebook handleOpenURL:url]; 
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
