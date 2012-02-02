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

@implementation GSMappingProvider

- (id)init {
    self = [super init];
    
    if(self){
        
        // User mapping        
        RKObjectMapping* user = [RKObjectMapping mappingForClass:[GSUser class]];
        [user mapKeyPath:@"username" toAttribute:@"username"];
        [user mapKeyPath:@"email" toAttribute:@"email"];
        [user mapKeyPath:@"authentication_token" toAttribute:@"authToken"];
        [user mapKeyPath:@"password" toAttribute:@"password"];
        [self setMapping:user forKeyPath:@"user"];
        [self registerMapping:user withRootKeyPath:@"user"];
        
        // Users mapping        
        RKObjectMapping* users = [RKObjectMapping mappingForClass:[GSUser class]];
        [users mapKeyPath:@"username" toAttribute:@"username"];
        [users mapKeyPath:@"email" toAttribute:@"email"];
        [users mapKeyPath:@"authentication_token" toAttribute:@"authToken"];
        [users mapKeyPath:@"password" toAttribute:@"password"];
        [self setMapping:users forKeyPath:@"users.user"];
        
        // GiftList Mapping
        RKObjectMapping* giftlist = [RKObjectMapping mappingForClass:[GSGiftList class]];
        [giftlist mapKeyPath:@"name" toAttribute:@"name"];
        [giftlist mapKeyPath:@"id" toAttribute:@"resourceId"];
        [giftlist mapKeyPath:@"is_editable_by_friends" toAttribute:@"isEditableByFriends"];
        [giftlist mapKeyPath:@"is_private" toAttribute:@"isPrivate"];
        [giftlist mapKeyPath:@"purpose" toAttribute:@"purpose"];
        [giftlist mapKeyPath:@"all_gifts_purchased" toAttribute:@"allGiftsPurchased"];
        [self setMapping:giftlist forKeyPath:@"gift_list"];
        
        // GiftLists Mapping
        RKObjectMapping* giftlists = [RKObjectMapping mappingForClass:[GSGiftList class]];
        [giftlists mapKeyPath:@"name" toAttribute:@"name"];
        [giftlists mapKeyPath:@"id" toAttribute:@"resourceId"];
        [giftlists mapKeyPath:@"is_editable_by_friends" toAttribute:@"isEditableByFriends"];
        [giftlists mapKeyPath:@"is_private" toAttribute:@"isPrivate"];
        [giftlists mapKeyPath:@"purpose" toAttribute:@"purpose"];
        [giftlists mapKeyPath:@"all_gifts_purchased" toAttribute:@"allGiftsPurchased"];
        [self setMapping:giftlists forKeyPath:@"gift_lists.gift_list"];
        
        // Gift Mapping
        RKObjectMapping* gift = [RKObjectMapping mappingForClass:[GSGift class]];
        [gift mapKeyPath:@"amazon_affiliate_link" toAttribute:@"amazonAffiliateLink"];
        [gift mapKeyPath:@"approximate_price" toAttribute:@"approximatePrice"];
        [gift mapKeyPath:@"id" toAttribute:@"resourceId"];
        [gift mapKeyPath:@"is_purchased" toAttribute:@"isPurchased"];
        [gift mapKeyPath:@"link_to_example" toAttribute:@"linkToExample"];
        [gift mapKeyPath:@"name" toAttribute:@"name"];
        [self setMapping:gift forKeyPath:@"gift"];
        
        //Gifts Mapping
        RKObjectMapping* gifts = [RKObjectMapping mappingForClass:[GSGift class]];
        [gifts mapKeyPath:@"amazon_affiliate_link" toAttribute:@"amazonAffiliateLink"];
        [gifts mapKeyPath:@"approximate_price" toAttribute:@"approximatePrice"];
        [gifts mapKeyPath:@"id" toAttribute:@"resourceId"];
        [gifts mapKeyPath:@"is_purchased" toAttribute:@"isPurchased"];
        [gifts mapKeyPath:@"link_to_example" toAttribute:@"linkToExample"];
        [gifts mapKeyPath:@"name" toAttribute:@"name"];
        [self setMapping:gifts forKeyPath:@"gifts.gift"];
        
        
    }
    
    return self;
}

@end
