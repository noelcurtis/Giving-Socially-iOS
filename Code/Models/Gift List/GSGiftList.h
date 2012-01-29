//
//  GSGiftList.h
//  GivingSocially
//
//  Created by Noel Curtis on 1/27/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSGiftList : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *resourceId;
@property (nonatomic, assign) BOOL isEditableByFriends;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, retain) NSString *purpose;
@property (nonatomic, assign) BOOL allGiftsPurchased;

@end
