//
//  ApiUserTests.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "ApiUserTests.h"

@implementation ApiUserTests

- (void) testGetShowUser{
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://localhost:3000/api"];
    GSMappingProvider* provider = [[[GSMappingProvider alloc] init] autorelease];
    objectManager.mappingProvider = provider;
    
    RKObjectLoader* loader = [RKObjectLoader loaderWithResourcePath:@"/users/little_kitten.json" objectManager:objectManager delegate:nil];
    
    RKParserRegistry* parserRegistery = [RKParserRegistry sharedRegistry];
    [parserRegistery setParserClass:NSClassFromString(@"RKJSONParserJSONKit") forMIMEType:@"application/json"];
    
    [loader waitForResponse];
}

@end
