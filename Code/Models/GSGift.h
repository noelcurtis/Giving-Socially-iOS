//
//  GSGift.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/12/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GSGift : NSManagedObject

@property (nonatomic, retain) NSNumber* giftID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * amazonAffiliateURL;
@property (nonatomic, retain, getter = isPurchased) NSNumber * purchased;
@property (nonatomic, retain) NSNumber * approximatePrice;
@property (nonatomic, retain) NSString * exampleURL;

@end
