//
//  GSGift.h
//  GivingSocially
//
//  Created by Noel Curtis on 1/29/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSGift : NSObject

@property (nonatomic, retain) NSString *amazonAffiliateLink;
@property (nonatomic, retain) NSString *approximatePrice;
@property (nonatomic, retain) NSString *resourceId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) BOOL isPurchased;
@property (nonatomic, retain) NSString *linkToExample;

@end
