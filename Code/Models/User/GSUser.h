//
//  GSUser.h
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSUser : NSObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *authToken;
@property (nonatomic, retain) NSString *password;


@end
