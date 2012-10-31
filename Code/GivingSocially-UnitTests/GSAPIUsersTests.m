//
//  GSAPIUsersTests.m
//  GivingSocially
//
//  Created by Scott on 10/28/12.
//  Copyright (c) 2012 Giving Socially. All rights reserved.
//

#import "Specta.h"

#define EXP_SHORTHAND
#import "Expecta.h"

#import "GSNetworkManager.h"

SpecBegin(GSAPIUsersTests)

describe(@"API Users tests", ^{
    
    context(@"when not logged in", ^{
        it(@"it should be able to log in", ^{
            
            NSDictionary *dictionary = @{
            @"email" : @"kitten@puppy.com",
            @"password" : @"kitten_little"
            };
            
            NSDictionary *userDictionary = @{ @"user" : dictionary };
            
            __block id responseObject = nil;
            [[GSNetworkManager sharedManager] loginWithParameters:userDictionary completionHandler:^(RKMappingResult *mappingResult, NSError *error) {
                responseObject = [mappingResult firstObject];
            }];
            
            expect(responseObject).willNot.beNil();
        });
    });
	
});

SpecEnd