//
//  GSEnvironment.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/4/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kGSBaseURL;
extern NSString * const kGSAuthTokenHeaderKey;

/* Macros */
#ifdef DEBUG
#define GSLog(FORMAT, ...) printf("[%s][%s] ~ %s\n", [[[NSDate date] description] UTF8String], __PRETTY_FUNCTION__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define GSLog(FORMAT, ...) /* */
#endif