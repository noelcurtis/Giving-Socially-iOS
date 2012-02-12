//
//  GSGiftList.h
//  GivingSocially
//
//  Created by Scott Penrose on 2/11/12.
//  Copyright (c) 2012 Scott Penrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GSGiftList : NSManagedObject

@property (nonatomic, retain) NSNumber * allGiftsPurchased;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * giftListID;
@property (nonatomic, retain, getter = isEditableByFriends) NSNumber * editableByFriends;
@property (nonatomic, retain, getter = isPrivateList) NSNumber * privateList;
@property (nonatomic, retain, getter = isStarred) NSNumber * starred;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * purpose;

@end
