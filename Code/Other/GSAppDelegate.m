//
//  GSAppDelegate.m
//  GivingSocially
//
//  Created by Scott Penrose on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSAppDelegate.h"
#import "GSMappingProvider.h"
#import <RestKit/RestKit.h>
#import "TestFlight.h"

@interface GSAppDelegate ()

- (void)setupRestKit;

@end

@implementation GSAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if CONFIGURATION_RELEASE
    NSLog(@"\n***************************\nCONFIGURATION MODE: RELEASE\n***************************");
#elif CONFIGURATOIN_RELEASE == 0
    NSLog(@"\n***************************\nCONFIGURATION MODE: DEBUG\n***************************");
#endif
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupRestKit];
    
    // TestFlight
#if CONFIGURATION_RELEASE == 0
    [TestFlight takeOff:@"f0598e9df64627643e461419c2617565_NTY1MzAyMDEyLTAxLTI1IDAxOjA0OjQ5LjcyMTUwMQ"];
#endif
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupRestKit
{
    //    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    //    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://stormy-sky-8032.herokuapp.com/api"];
    RKParserRegistry* parserRegistery = [RKParserRegistry sharedRegistry];
    [parserRegistery setParserClass:NSClassFromString(@"RKJSONParserJSONKit") forMIMEType:@"application/json"];
    
    GSMappingProvider* provider = [[[GSMappingProvider alloc] init] autorelease];
    objectManager.mappingProvider = provider;
//    [[RKParserRegistry sharedRegistry] setParserClass:NSClassFromString(@"RKXMLParserLibXML") forMIMEType:@"application/rss+xml"]; 
//    [[RKClient sharedClient].requestQueue setShowsNetworkActivityIndicatorWhenBusy:YES];
//    [[RKClient sharedClient].requestQueue setRequestTimeout:30.0];
//    
//    //Sat, 14 Jan 2012 00:00:00 -0600
//    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//    [dateFormatter setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
//    [RKObjectMapping addDefaultDateFormatter:dateFormatter];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
