//
//  GVMappingProvider.m
//  GivingSocially
//
//  Created by Noel Curtis on 1/25/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import "GSMappingProvider.h"
#import "GSUser.h"
#import "GSGiftList.h"
#import "GSGift.h"
#import "GSActivity.h"

@implementation GSMappingProvider

- (id)init {
    self = [super init];
    
    if(self){
        RKManagedObjectStore* objectStore = [RKObjectManager sharedManager].objectStore;
        
        // User mapping        
        RKManagedObjectMapping* user = [RKManagedObjectMapping mappingForClass:[GSUser class] inManagedObjectStore:objectStore];
        [user setPrimaryKeyAttribute:@"email"];
        [user mapKeyPath:@"username" toAttribute:@"username"];
        [user mapKeyPath:@"email" toAttribute:@"email"];
        [user mapKeyPath:@"authentication_token" toAttribute:@"authToken"];
        [user mapKeyPath:@"first_name" toAttribute:@"firstName"];
        [user mapKeyPath:@"last_name" toAttribute:@"lastName"];
        [self setMapping:user forKeyPath:@"user"];
        [self setSerializationMapping:[user inverseMapping] forClass:[GSUser class]];
        [self setMapping:user forKeyPath:@"users.user"];
        [self registerMapping:user withRootKeyPath:@"user"];
        
        // GiftList Mapping
        RKManagedObjectMapping* giftlist = [RKManagedObjectMapping mappingForClass:[GSGiftList class] inManagedObjectStore:objectStore];
        [giftlist setPrimaryKeyAttribute:@"giftListID"];
        [giftlist mapKeyPath:@"name" toAttribute:@"name"];
        [giftlist mapKeyPath:@"id" toAttribute:@"giftListID"];
        [giftlist mapKeyPath:@"is_editable_by_friends" toAttribute:@"editableByFriends"];
        [giftlist mapKeyPath:@"is_private" toAttribute:@"privateList"];
        [giftlist mapKeyPath:@"is_starred" toAttribute:@"starred"];
        [giftlist mapKeyPath:@"all_gifts_purchased" toAttribute:@"allGiftsPurchased"];
        [giftlist mapKeyPath:@"due_date" toAttribute:@"dueDate"];
        [giftlist mapAttributes:@"purpose", nil];
        [self setMapping:giftlist forKeyPath:@"gift_list"];
        [self setMapping:giftlist forKeyPath:@"gift_lists.gift_list"];
        
        // Gift Mapping
        RKManagedObjectMapping* gift = [RKManagedObjectMapping mappingForClass:[GSGift class] inManagedObjectStore:objectStore];
        [gift setPrimaryKeyAttribute:@"giftID"];
        [gift mapKeyPath:@"amazon_affiliate_link" toAttribute:@"amazonAffiliateURL"];
        [gift mapKeyPath:@"approximate_price" toAttribute:@"approximatePrice"];
        [gift mapKeyPath:@"id" toAttribute:@"giftID"];
        [gift mapKeyPath:@"is_purchased" toAttribute:@"purchased"];
        [gift mapKeyPath:@"link_to_example" toAttribute:@"exampleURL"];
        [gift mapAttributes:@"name", nil];
        [self setMapping:gift forKeyPath:@"gift"];
        [self setMapping:gift forKeyPath:@"gifts.gift"];
        [self registerObjectMapping:gift withRootKeyPath:@"gift"];
        
        RKObjectMapping *giftSerialization = [gift inverseMapping];
        [self setSerializationMapping:giftSerialization forClass:[GSGift class]];
        
        // Activity Mapping
        RKManagedObjectMapping* activity = [RKManagedObjectMapping mappingForClass:[GSActivity class] inManagedObjectStore:objectStore];
        [activity setPrimaryKeyAttribute:@"activityID"];
        [activity mapKeyPath:@"id" toAttribute:@"activityID"];
        [activity mapKeyPath:@"friendly_descriptor" toAttribute:@"friendlyDescription"];
        // Gift Relationship
        [activity mapKeyPath:@"gift" toRelationship:@"gift" withMapping:gift];
        // Gift List Relationship
        [activity mapKeyPath:@"gift_list" toRelationship:@"giftList" withMapping:giftlist];

        [self setMapping:activity forKeyPath:@"activity"];
        [self setMapping:activity forKeyPath:@"activities.activity"];
    }
    
    return self;
}

@end
